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

  user_data = base64encode(templatefile("${path.module}/bastion-userdata.sh", { HOSTED_ZONE_ID = var.hosted_zone_id, NAME_PREFIX = var.name_prefix }))

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
  vpc_zone_identifier = var.public_subnets #flatten([module.vpc.public_subnets])

  force_delete         = true
  termination_policies = ["OldestInstance"]

  mixed_instances_policy {
    instances_distribution {
      on_demand_percentage_above_base_capacity = 0
      on_demand_base_capacity                  = 0
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
  scheduled_action_name  = "bastion_asg_scale_down"
  autoscaling_group_name = aws_autoscaling_group.bastion.name
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  recurrence             = "0 18 * * MON-FRI"

  depends_on = [aws_autoscaling_group.bastion]
}

resource "aws_autoscaling_schedule" "asg_scale_up" {
  scheduled_action_name  = "bastion_asg_scale_up"
  autoscaling_group_name = aws_autoscaling_group.bastion.name
  min_size               = 1
  max_size               = 1
  desired_capacity       = 1
  recurrence             = "0 9 * * MON-FRI"

  depends_on = [aws_autoscaling_group.bastion]
}


resource "aws_security_group" "bastion" {
  name_prefix = "${var.name_prefix}-bastion-ssh-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      "Name" = "${var.name_prefix}-bastion-ssh"
    },
    var.tags
  )
}

resource "aws_iam_instance_profile" "bastion" {
  name = "${var.name_prefix}-bastion-instance-profile"
  role = aws_iam_role.bastion.name
}

resource "aws_iam_role" "bastion" {
  name = "${var.name_prefix}-bastion-role"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

  tags = var.tags
}

resource "aws_iam_policy" "bastion" {
  name = "${var.name_prefix}-bastion-ec2-asg-policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeAutoScalingGroups",
        "ec2:DescribeAddresses",
        "ec2:DescribeInstances",
        "ec2:DescribeTags"
      ],
      "Resource": "*"
    },
    { 
      "Effect":"Allow",
      "Action": [
        "route53:ChangeResourceRecordSets",
        "route53:GetHostedZone"
      ],  
      "Resource": [
        "arn:aws:route53:::hostedzone/${var.hosted_zone_id}"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "bastion" {
  role       = aws_iam_role.bastion.name
  policy_arn = aws_iam_policy.bastion.arn
}
