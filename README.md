![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/umotif-public/terraform-aws-bastion?style=social)

# terraform-aws-bastion

Terraform module to create Bastion Host in AWS VPC running as Spot Instance/s or On Demand.

## Resources created

This module will create Bastion Host/s which will make use of Launch Template and Auto Scaling Group. Bastion host will run as a spot instance. In order to reduce the amount of Elastic IPs, module creates a route53 A record which points to the bastion host/s.

## Terraform versions

Terraform 0.13+. Pin module version to `~> v2.0`. Submit pull-requests to `master` branch.

## Usage

```hcl
module "bastion" {
  source = "umotif-public/bastion/aws"
  version = "~> 2.1.0"

  name_prefix = "core-example"

  vpc_id         = "vpc-abasdasd132"
  subnets        = ["subnet-abasdasd132123", "subnet-abasdasd132123132"]

  hosted_zone_id = "Z1IY32BQNIYX16"
  ssh_key_name   = "test"

  tags = {
    Project = "Test"
  }
}
```

## Bastion Host Visual Architecture

![Basiton](bastion-arch.jpeg)

## Examples

* [Bastion Host](https://github.com/umotif-public/terraform-aws-bastion/tree/master/examples/core)

## Authors

Module managed by [Marcin Cuber](https://github.com/marcincuber) [LinkedIn](https://www.linkedin.com/in/marcincuber/).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.45 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.45 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_schedule.asg_scale_down](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_autoscaling_schedule.asg_scale_up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_iam_instance_profile.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.iam_bastion_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_launch_template.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.bastion_role_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.bastion_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID to be used for bastion host. If not provided, it will default to latest amazon linux 2 image. | `string` | `""` | no |
| <a name="input_asg_scale_down_desired_capacity"></a> [asg\_scale\_down\_desired\_capacity](#input\_asg\_scale\_down\_desired\_capacity) | Auto Scalling Group value for desired capacity of bastion hosts. Scale down action. | `number` | `0` | no |
| <a name="input_asg_scale_down_max_size"></a> [asg\_scale\_down\_max\_size](#input\_asg\_scale\_down\_max\_size) | Auto Scalling Group value for maximum capacity of bastion hosts. Scale down action. | `number` | `0` | no |
| <a name="input_asg_scale_down_min_size"></a> [asg\_scale\_down\_min\_size](#input\_asg\_scale\_down\_min\_size) | Auto Scalling Group value for minimum capacity of bastion hosts. Scale down action. | `number` | `0` | no |
| <a name="input_asg_scale_down_recurrence"></a> [asg\_scale\_down\_recurrence](#input\_asg\_scale\_down\_recurrence) | The time when recurring future actions will start. Start time is specified by the user following the Unix cron syntax format. Scale down action. | `string` | `"0 18 * * MON-FRI"` | no |
| <a name="input_asg_scale_up_desired_capacity"></a> [asg\_scale\_up\_desired\_capacity](#input\_asg\_scale\_up\_desired\_capacity) | Auto Scalling Group value for desired capacity of bastion hosts. Scale up action. | `number` | `1` | no |
| <a name="input_asg_scale_up_max_size"></a> [asg\_scale\_up\_max\_size](#input\_asg\_scale\_up\_max\_size) | Auto Scalling Group value for maximum capacity of bastion hosts. Scale up action. | `number` | `1` | no |
| <a name="input_asg_scale_up_min_size"></a> [asg\_scale\_up\_min\_size](#input\_asg\_scale\_up\_min\_size) | Auto Scalling Group value for minimum capacity of bastion hosts. Scale up action. | `number` | `1` | no |
| <a name="input_asg_scale_up_recurrence"></a> [asg\_scale\_up\_recurrence](#input\_asg\_scale\_up\_recurrence) | The time when recurring future actions will start. Start time is specified by the user following the Unix cron syntax format. Scale up action. | `string` | `"0 9 * * MON-FRI"` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones for the default Ireland region. | `list(string)` | <pre>[<br>  "eu-west-1a",<br>  "eu-west-1b",<br>  "eu-west-1c"<br>]</pre> | no |
| <a name="input_aws_partition"></a> [aws\_partition](#input\_aws\_partition) | [Deprecated] Variable will be removed in version `3.0.0`. A Partition is a group of AWS Region and Service objects. You can use a partition to determine what services are available in a region, or what regions a service is available in. | `string` | `"public"` | no |
| <a name="input_bastion_instance_types"></a> [bastion\_instance\_types](#input\_bastion\_instance\_types) | Bastion instance types used for spot instances. | `list(string)` | <pre>[<br>  "t3.nano",<br>  "t3.micro",<br>  "t3.small",<br>  "t2.nano",<br>  "t2.micro",<br>  "t2.small"<br>]</pre> | no |
| <a name="input_delete_on_termination"></a> [delete\_on\_termination](#input\_delete\_on\_termination) | Whether the volume should be destroyed on instance termination. | `bool` | `true` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | Auto Scalling Group value for desired capacity of bastion hosts. | `number` | `1` | no |
| <a name="input_device_name"></a> [device\_name](#input\_device\_name) | The name of the device to mount. | `string` | `"/dev/xvda"` | no |
| <a name="input_egress_cidr_blocks"></a> [egress\_cidr\_blocks](#input\_egress\_cidr\_blocks) | List of CIDR ranges to allow outbound traffic at security group level. Defaults to 0.0.0.0/0 | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_egress_ipv6_cidr_blocks"></a> [egress\_ipv6\_cidr\_blocks](#input\_egress\_ipv6\_cidr\_blocks) | List of IPv6 CIDR ranges to allow outbound traffic at security group level. Defaults to ::/0 | `list(string)` | <pre>[<br>  "::/0"<br>]</pre> | no |
| <a name="input_enable_asg_scale_down"></a> [enable\_asg\_scale\_down](#input\_enable\_asg\_scale\_down) | n/a | `bool` | `false` | no |
| <a name="input_enable_asg_scale_up"></a> [enable\_asg\_scale\_up](#input\_enable\_asg\_scale\_up) | n/a | `bool` | `false` | no |
| <a name="input_encrypted"></a> [encrypted](#input\_encrypted) | Enables EBS encryption on the volume. | `bool` | `true` | no |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | Hosted zone id where A record will be added for bastion host/s. | `string` | `""` | no |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | List of CIDR ranges to allow ssh access at security group level. Defaults to 0.0.0.0/0 | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_ingress_ipv6_cidr_blocks"></a> [ingress\_ipv6\_cidr\_blocks](#input\_ingress\_ipv6\_cidr\_blocks) | List of IPv6 CIDR ranges to allow ssh access at security group level. Defaults to ::/0 | `list(string)` | <pre>[<br>  "::/0"<br>]</pre> | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | Auto Scalling Group value for maximum capacity of bastion hosts. | `number` | `1` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | Auto Scalling Group value for minimum capacity of bastion hosts. | `number` | `1` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | A prefix used for naming resources. | `string` | n/a | yes |
| <a name="input_on_demand_base_capacity"></a> [on\_demand\_base\_capacity](#input\_on\_demand\_base\_capacity) | Auto Scalling Group value for desired capacity for instance lifecycle type on-demand of bastion hosts. | `number` | `0` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | Classless Inter-Domain Routing ranges for private subnets. | `list(string)` | `[]` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | Classless Inter-Domain Routing ranges for public subnets. | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS region in which resources will get deployed. Defaults to Ireland. | `string` | `"eu-west-1"` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | SSH key used to connect to the bastion host | `string` | n/a | yes |
| <a name="input_ssh_port"></a> [ssh\_port](#input\_ssh\_port) | SSH port used to access a bastion host. | `number` | `22` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Default tags attached to all resources. | `map(string)` | <pre>{<br>  "ServiceType": "ceng-eks"<br>}</pre> | no |
| <a name="input_termination_policies"></a> [termination\_policies](#input\_termination\_policies) | A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, OldestLaunchTemplate, AllocationStrategy. | `list(string)` | <pre>[<br>  "OldestInstance"<br>]</pre> | no |
| <a name="input_userdata_file_content"></a> [userdata\_file\_content](#input\_userdata\_file\_content) | The user data to provide when launching the instance. | `string` | `""` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | The size of the volume in gigabytes. | `number` | `20` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | The type of volume. Can be `standard`, `gp2`, or `io1`. | `string` | `"gp2"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where bastion hosts and security groups will be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_auto_scaling_group_arn"></a> [auto\_scaling\_group\_arn](#output\_auto\_scaling\_group\_arn) | The ARN of the bastion's auto scaling group. |
| <a name="output_auto_scaling_group_id"></a> [auto\_scaling\_group\_id](#output\_auto\_scaling\_group\_id) | The ID of the bastion's auto scaling group. |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | The ARN of the bastion's IAM Role. |
| <a name="output_iam_role_id"></a> [iam\_role\_id](#output\_iam\_role\_id) | The ID or name of the bastion's IAM Role. |
| <a name="output_launch_template_arn"></a> [launch\_template\_arn](#output\_launch\_template\_arn) | The ARN of the bastion's launch template. |
| <a name="output_launch_template_id"></a> [launch\_template\_id](#output\_launch\_template\_id) | The ID of the bastion's launch template. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the bastion's security group. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

See LICENSE for full details.

## Pre-commit hooks

### Install dependencies

* [`pre-commit`](https://pre-commit.com/#install)
* [`terraform-docs`](https://github.com/segmentio/terraform-docs) required for `terraform_docs` hooks.
* [`TFLint`](https://github.com/terraform-linters/tflint) required for `terraform_tflint` hook.

#### MacOS

```bash
brew install pre-commit terraform-docs tflint

brew tap git-chglog/git-chglog
brew install git-chglog
```
