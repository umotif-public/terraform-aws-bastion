data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

data "aws_iam_policy_document" "bastion_role_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.${data.aws_partition.current.dns_suffix}"]
    }
  }
}

data "aws_iam_policy_document" "bastion_role_policy" {
  count = var.hosted_zone_id != "" ? 1 : 0

  statement {
    actions = [
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeAutoScalingGroups",
      "ec2:DescribeAddresses",
      "ec2:DescribeInstances",
      "ec2:DescribeTags"
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:GetHostedZone"
    ]
    effect    = "Allow"
    resources = ["arn:${data.aws_partition.current.partition}:route53:::hostedzone/${var.hosted_zone_id}"]
  }
}
