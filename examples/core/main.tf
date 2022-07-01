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

  delete_on_termination = true
  volume_size           = 10
  encrypted             = true

  userdata_file_content = templatefile("./custom-userdata.sh", {}) # if you want to use default one, simply remove this line

  tags = {
    Project = "Test"
  }
}

output "sg_id" {
  value = module.bastion.security_group_id
}
