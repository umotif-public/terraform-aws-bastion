variable "name_prefix" {
  description = "A prefix used for naming resources."
  type        = string
}

variable "region" {
  type        = string
  default     = "eu-west-1"
  description = "AWS region in which resources will get deployed. Defaults to Ireland."
}

variable "availability_zones" {
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  description = "Availability zones for the default Ireland region."
}

variable "bastion_instance_types" {
  type        = list(string)
  description = "Bastion instance types used for spot instances."
  default     = ["t3.nano", "t3.micro", "t3.small", "t2.nano", "t2.micro", "t2.small"]
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where bastion hosts and security groups will be created."
}

variable "private_subnets" {
  type        = list(string)
  description = "Classless Inter-Domain Routing ranges for private subnets."
  default     = []
}

variable "public_subnets" {
  type        = list(string)
  description = "Classless Inter-Domain Routing ranges for public subnets."
}

variable "tags" {
  type        = map(string)
  description = "Default tags attached to all resources."
  default = {
    ServiceType = "ceng-eks"
  }
}

variable "ssh_key_name" {
  type        = string
  description = "SSH key used to connect to the bastion host"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to be used for bastion host. If not provided, it will default to latest amazon linux 2 image."
  default     = ""
}

variable "hosted_zone_id" {
  type        = string
  description = "Hosted zone id where A record will be added for bastion host/s."
  default     = ""
}

variable "desired_capacity" {
  type        = number
  description = "Auto Scalling Group value for desired capacity of bastion hosts."
  default     = 1
}

variable "on_demand_base_capacity" {
  type        = number
  description = "Auto Scalling Group value for desired capacity for instance lifecycle type on-demand of bastion hosts."
  default     = 0
}

variable "max_size" {
  type        = number
  description = "Auto Scalling Group value for maximum capacity of bastion hosts."
  default     = 1
}

variable "min_size" {
  type        = number
  description = "Auto Scalling Group value for minimum capacity of bastion hosts."
  default     = 1
}

variable "ssh_port" {
  description = "SSH port used to access a bastion host."
  default     = 22
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR ranges to allow ssh access at security group level. Defaults to 0.0.0.0/0"
  default     = ["0.0.0.0/0"]
}

variable "ingress_ipv6_cidr_blocks" {
  type        = list(string)
  description = "List of IPv6 CIDR ranges to allow ssh access at security group level. Defaults to ::/0"
  default     = ["::/0"]
}

variable "egress_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR ranges to allow outbound traffic at security group level. Defaults to 0.0.0.0/0"
  default     = ["0.0.0.0/0"]
}

variable "egress_ipv6_cidr_blocks" {
  type        = list(string)
  description = "List of IPv6 CIDR ranges to allow outbound traffic at security group level. Defaults to ::/0"
  default     = ["::/0"]
}

variable "enable_asg_scale_down" {
  type    = bool
  default = false
}

variable "enable_asg_scale_up" {
  type    = bool
  default = false
}

variable "asg_scale_down_recurrence" {
  type        = string
  description = "The time when recurring future actions will start. Start time is specified by the user following the Unix cron syntax format. Scale down action."
  default     = "0 18 * * MON-FRI"
}

variable "asg_scale_up_recurrence" {
  type        = string
  description = "The time when recurring future actions will start. Start time is specified by the user following the Unix cron syntax format. Scale up action."
  default     = "0 9 * * MON-FRI"
}

variable "asg_scale_down_max_size" {
  type        = number
  description = "Auto Scalling Group value for maximum capacity of bastion hosts. Scale down action."
  default     = 0
}

variable "asg_scale_down_min_size" {
  type        = number
  description = "Auto Scalling Group value for minimum capacity of bastion hosts. Scale down action."
  default     = 0
}

variable "asg_scale_down_desired_capacity" {
  type        = number
  description = "Auto Scalling Group value for desired capacity of bastion hosts. Scale down action."
  default     = 0
}

variable "asg_scale_up_max_size" {
  type        = number
  description = "Auto Scalling Group value for maximum capacity of bastion hosts. Scale up action."
  default     = 1
}

variable "asg_scale_up_min_size" {
  type        = number
  description = "Auto Scalling Group value for minimum capacity of bastion hosts. Scale up action."
  default     = 1
}

variable "asg_scale_up_desired_capacity" {
  type        = number
  description = "Auto Scalling Group value for desired capacity of bastion hosts. Scale up action."
  default     = 1
}

variable "termination_policies" {
  type        = list(string)
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, OldestLaunchTemplate, AllocationStrategy."
  default     = ["OldestInstance"]
}

variable "userdata_file_content" {
  type        = string
  description = "The user data to provide when launching the instance."
  default     = ""
}

variable "device_name" {
  type        = string
  description = "The name of the device to mount."
  default     = "/dev/xvda"
}

variable "delete_on_termination" {
  type        = bool
  description = "Whether the volume should be destroyed on instance termination."
  default     = true
}

variable "volume_size" {
  type        = number
  description = "The size of the volume in gigabytes."
  default     = 20
}

variable "encrypted" {
  type        = bool
  description = "Enables EBS encryption on the volume."
  default     = true
}

variable "volume_type" {
  type        = string
  description = "The type of volume. Can be `standard`, `gp2`, or `io1`."
  default     = "gp2"
}

variable "aws_partition" {
  type    = string
  default = "public"

  description = "A Partition is a group of AWS Region and Service objects. You can use a partition to determine what services are available in a region, or what regions a service is available in."

  validation {
    condition     = contains(["public", "china"], var.aws_partition)
    error_message = "Argument \"aws_partition\" must be either \"public\" or \"china\"."
  }
}
