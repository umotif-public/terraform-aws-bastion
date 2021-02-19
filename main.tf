#####
# Bastion Host configuration
#####

resource "aws_launch_template" "bastion" {
  name_prefix = "${var.name_prefix}-bastion-"
  image_id    = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux.id
  key_name    = var.ssh_key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.bastion.name
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [aws_security_group.bastion.id]
  }

  block_device_mappings {
    device_name = var.device_name

    ebs {
      delete_on_termination = var.delete_on_termination
      volume_size           = var.volume_size
      volume_type           = var.volume_type
      encrypted             = var.encrypted
    }
  }

  user_data = var.userdata_file_content != "" ? base64encode(var.userdata_file_content) : base64encode(templatefile("${path.module}/bastion-userdata.sh", { HOSTED_ZONE_ID = var.hosted_zone_id, NAME_PREFIX = var.name_prefix }))

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "bastion" {
  name_prefix         = "${var.name_prefix}-bastion-asg-"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.public_subnets

  force_delete         = true
  termination_policies = var.termination_policies

  mixed_instances_policy {
    instances_distribution {
      on_demand_percentage_above_base_capacity = 0
      on_demand_base_capacity                  = var.on_demand_base_capacity
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.bastion.id
        version            = "$Latest"
      }

      dynamic "override" {
        for_each = var.bastion_instance_types
        content {
          instance_type = override.value
        }
      }
    }
  }

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-bastion"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  timeouts {
    delete = "15m"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_launch_template.bastion]
}

resource "aws_autoscaling_schedule" "asg_scale_down" {
  count = var.enable_asg_scale_down ? 1 : 0

  scheduled_action_name  = "bastion_asg_scale_down"
  autoscaling_group_name = aws_autoscaling_group.bastion.name
  min_size               = var.asg_scale_down_min_size
  max_size               = var.asg_scale_down_max_size
  desired_capacity       = var.asg_scale_down_desired_capacity
  recurrence             = var.asg_scale_down_recurrence

  depends_on = [aws_autoscaling_group.bastion]
}

resource "aws_autoscaling_schedule" "asg_scale_up" {
  count = var.enable_asg_scale_up ? 1 : 0

  scheduled_action_name  = "bastion_asg_scale_up"
  autoscaling_group_name = aws_autoscaling_group.bastion.name
  min_size               = var.asg_scale_up_min_size
  max_size               = var.asg_scale_up_max_size
  desired_capacity       = var.asg_scale_up_desired_capacity
  recurrence             = var.asg_scale_up_recurrence

  depends_on = [aws_autoscaling_group.bastion]
}


resource "aws_security_group" "bastion" {
  name_prefix = "${var.name_prefix}-bastion-ssh-"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = var.ssh_port
    to_port          = var.ssh_port
    protocol         = "tcp"
    cidr_blocks      = var.ingress_cidr_blocks
    ipv6_cidr_blocks = var.ingress_ipv6_cidr_blocks
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.egress_cidr_blocks
    ipv6_cidr_blocks = var.egress_ipv6_cidr_blocks
  }

  tags = merge(
    {
      "Name" = "${var.name_prefix}-bastion-ssh"
    },
    var.tags
  )

  revoke_rules_on_delete = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "bastion" {
  name = "${var.name_prefix}-bastion-instance-profile"
  role = aws_iam_role.bastion.name
}

resource "aws_iam_role" "bastion" {
  name = "${var.name_prefix}-bastion-role"
  path = "/"

  assume_role_policy = data.aws_iam_policy_document.bastion_role_assume_role_policy.json

  tags = var.tags
}

resource "aws_iam_role_policy" "iam_bastion_policy" {
  count = var.hosted_zone_id != "" ? 1 : 0

  name = "custom-bastion-policy"
  role = aws_iam_role.bastion.name

  policy = data.aws_iam_policy_document.bastion_role_policy[0].json
}
