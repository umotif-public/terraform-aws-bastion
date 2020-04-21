# terraform-aws-bastion

Terraform module to create Bastion Host in AWS VPC running as Spot Instance/s

## Resources created

This module will create Bastion Host/s which will make use of Launch Template and Auto Scaling Group. Bastion host will run as a spot instance. In order to reduce the amount of Elastic IPs, module creates a route53 A record which points to the bastion host/s.

## Terraform versions

Terraform 0.12. Pin module version to `~> v1.0`. Submit pull-requests to `master` branch.

## Usage

```hcl
module "bastion" {
  source = "umotif-public/bastion/aws"
  version = "~> 1.1.0"

  name_prefix = "core-example"

  vpc_id         = "vpc-abasdasd132"
  subnets        = ["subnet-abasdasd132123", "subnet-abasdasd132123132"]

  hosted_zone_id = "Z1IY32BQNIYX16"
  ssh_key_name   = "marcin-test"

  tags = {
    Project = "Test"
  }
}
```

## Bastion Host Visual Architecture

![Basiton](bastion-arch.jpeg)

## Assumptions

Module is to be used with Terraform > 0.12.

## Examples

* [Bastion Host](https://github.com/umotif-public/terraform-aws-bastion/tree/master/examples/core)

## Authors

Module managed by [Marcin Cuber](https://github.com/marcincuber) [LinkedIn](https://www.linkedin.com/in/marcincuber/).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.6 |
| aws | ~> 2.45 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.45 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami\_id | AMI ID to be used for bastion host. If not provided, it will default to latest amazon linux 2 image. | `string` | `""` | no |
| asg\_scale\_down\_desired\_capacity | Auto Scalling Group value for desired capacity of bastion hosts. Scale down action. | `number` | `0` | no |
| asg\_scale\_down\_max\_size | Auto Scalling Group value for maximum capacity of bastion hosts. Scale down action. | `number` | `0` | no |
| asg\_scale\_down\_min\_size | Auto Scalling Group value for minimum capacity of bastion hosts. Scale down action. | `number` | `0` | no |
| asg\_scale\_down\_recurrence | The time when recurring future actions will start. Start time is specified by the user following the Unix cron syntax format. Scale down action. | `string` | `"0 18 * * MON-FRI"` | no |
| asg\_scale\_up\_desired\_capacity | Auto Scalling Group value for desired capacity of bastion hosts. Scale up action. | `number` | `1` | no |
| asg\_scale\_up\_max\_size | Auto Scalling Group value for maximum capacity of bastion hosts. Scale up action. | `number` | `1` | no |
| asg\_scale\_up\_min\_size | Auto Scalling Group value for minimum capacity of bastion hosts. Scale up action. | `number` | `1` | no |
| asg\_scale\_up\_recurrence | The time when recurring future actions will start. Start time is specified by the user following the Unix cron syntax format. Scale up action. | `string` | `"0 9 * * MON-FRI"` | no |
| availability\_zones | Availability zones for the default Ireland region. | `list(string)` | <pre>[<br>  "eu-west-1a",<br>  "eu-west-1b",<br>  "eu-west-1c"<br>]</pre> | no |
| bastion\_instance\_types | Bastion instance types used for spot instances. | `list(string)` | <pre>[<br>  "t3.nano",<br>  "t3.micro",<br>  "t3.small",<br>  "t2.nano",<br>  "t2.micro",<br>  "t2.small"<br>]</pre> | no |
| desired\_capacity | Auto Scalling Group value for desired capacity of bastion hosts. | `number` | `1` | no |
| egress\_cidr\_blocks | List of CIDR ranges to allow outbound traffic at security group level. Defaults to 0.0.0.0/0 | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| egress\_ipv6\_cidr\_blocks | List of IPv6 CIDR ranges to allow outbound traffic at security group level. Defaults to ::/0 | `list(string)` | <pre>[<br>  "::/0"<br>]</pre> | no |
| enable\_asg\_scale\_down | n/a | `bool` | `false` | no |
| enable\_asg\_scale\_up | n/a | `bool` | `false` | no |
| hosted\_zone\_id | Hosted zone id where A record will be added for bastion host/s. | `string` | `""` | no |
| ingress\_cidr\_blocks | List of CIDR ranges to allow ssh access at security group level. Defaults to 0.0.0.0/0 | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| ingress\_ipv6\_cidr\_blocks | List of IPv6 CIDR ranges to allow ssh access at security group level. Defaults to ::/0 | `list(string)` | <pre>[<br>  "::/0"<br>]</pre> | no |
| max\_size | Auto Scalling Group value for maximum capacity of bastion hosts. | `number` | `1` | no |
| min\_size | Auto Scalling Group value for minimum capacity of bastion hosts. | `number` | `1` | no |
| name\_prefix | A prefix used for naming resources. | `string` | n/a | yes |
| private\_subnets | Classless Inter-Domain Routing ranges for private subnets. | `list(string)` | `[]` | no |
| public\_subnets | Classless Inter-Domain Routing ranges for public subnets. | `list(string)` | n/a | yes |
| region | AWS region in which resources will get deployed. Defaults to Ireland. | `string` | `"eu-west-1"` | no |
| ssh\_key\_name | SSH key used to connect to the bastion host | `string` | n/a | yes |
| ssh\_port | SSH port used to access a bastion host. | `number` | `22` | no |
| tags | Default tags attached to all resources. | `map(string)` | <pre>{<br>  "ServiceType": "ceng-eks"<br>}</pre> | no |
| termination\_policies | A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, OldestLaunchTemplate, AllocationStrategy. | `list(string)` | <pre>[<br>  "OldestInstance"<br>]</pre> | no |
| userdata\_file\_content | n/a | `string` | `""` | no |
| vpc\_id | VPC ID where bastion hosts and security groups will be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| auto\_scaling\_group\_arn | The ARN of the bastion's auto scaling group. |
| auto\_scaling\_group\_id | The ID of the bastion's auto scaling group. |
| iam\_role\_arn | The ARN of the bastion's IAM Role. |
| iam\_role\_id | The ID or name of the bastion's IAM Role. |
| launch\_template\_arn | The ARN of the bastion's launch template. |
| launch\_template\_id | The ID of the bastion's launch template. |
| security\_group\_id | The ID of the bastion's security group. |

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
