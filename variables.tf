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
  type           = string
  description    = "Hosted zone id where A record will be added for bastion host/s."
  hosted_zone_id = ""
}

variable "desired_capacity" {
  type        = number
  description = "Auto Scalling Group value for desired capacity of bastion hosts."
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Auto Scalling Group value for maximum capacity of bastion hosts."
  default     = 2
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
