provider "aws" {
  region = "eu-west-1"
}

#####
# VPC and subnets
#####
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

#####
# Bastion Host
#####
module "bastion" {
  source = "../../"

  name_prefix = "core-example"

  vpc_id         = data.aws_vpc.default.id
  public_subnets = flatten([data.aws_subnets.all.ids])

  hosted_zone_id = "Z1IY32BQNIYX17"
  ssh_key_name   = "eks-test"

  enable_asg_scale_down = true
  enable_asg_scale_up   = true

  # Configure the spot instance allocation strategy
  spot_allocation_strategy = "capacity-optimized" # Options: "lowest-price", "diversified", "capacity-optimized", "capacity-optimized-prioritized"

  # Enable capacity rebalancing for better spot instance availability
  capacity_rebalance = true

  # Configure instance types for mixed instances policy
  bastion_instance_types = ["t3.nano", "t3.micro", "t3a.nano", "t3a.micro"]

  block_device_mappings = [
    {
      device_name = "/dev/xvda"
      ebs = {
        delete_on_termination = true
        volume_size           = 10
        encrypted             = true
        volume_type           = "gp3"
      }
    }
  ]

  userdata_file_content = templatefile("./custom-userdata.sh", {}) # if you want to use default one, simply remove this line

  tags = {
    Name        = "Test"
    Environment = "tst"
    Terraform   = "true"
  }

  tag_specifications = [
    "instance",
    "volume",
    "network-interface",
  ]
}

output "aws_ami" {
  value = module.bastion.aws_ami
}
