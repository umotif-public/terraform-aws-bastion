variable "name_prefix" {
  description = "A prefix used for naming resources."
  type        = string
}

variable "bastion_instance_types" {
  type        = list(string)
  description = "Bastion instance types used for spot instances."
  default     = ["t4g.nano", "t4g.micro", "t4g.small"]
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where bastion hosts and security groups will be created."
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

variable "ssh_port" {
  description = "SSH port used to access a bastion host."
  default     = 22
  type        = number
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

variable "time_zone" {
  type        = string
  default     = "Etc/UTC"
  description = "Used for ASG Scale Up/Down. Valid values are the canonical names of the IANA time zones (such as Etc/GMT+9 or London/Europe)"
}

variable "tag_specifications" {
  type        = list(string)
  default     = ["instance", "volume", "network-interface", "spot-instances-request"]
  description = "The tags to apply to the resources during launch. You can tag instances, volumes, elastic GPUs and spot instance requests. "
}

variable "block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"
  type = list(object({
    device_name  = string
    no_device    = optional(string)
    virtual_name = optional(string)
    ebs = optional(object({
      delete_on_termination = optional(bool, true)
      encrypted             = optional(bool, true)
      iops                  = optional(number)
      kms_key_id            = optional(string)
      snapshot_id           = optional(string)
      volume_size           = optional(number)
      volume_type           = optional(string)
      throughput            = optional(number)
    }))
  }))

  default = []
}

variable "ebs_optimized" {
  type        = bool
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = null
}
