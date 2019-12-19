## Example deployment flow

```bash
terraform init
terraform validate
terraform plan
terraform apply --auto-approve
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name\_prefix | A prefix used for naming resources. | string | n/a | yes |
| public\_subnets | Classless Inter-Domain Routing ranges for public subnets. | list(string) | n/a | yes |
| ssh\_key\_name | SSH key used to connect to the bastion host | string | n/a | yes |
| vpc\_id | VPC ID where bastion hosts and security groups will be created. | string | n/a | yes |
| ami\_id | AMI ID to be used for bastion host. If not provided, it will default to latest amazon linux 2 image. | string | `""` | no |
| asg\_scale\_down\_desired\_capacity | Auto Scalling Group value for desired capacity of bastion hosts. Scale down action. | number | `"0"` | no |
| asg\_scale\_down\_max\_size | Auto Scalling Group value for maximum capacity of bastion hosts. Scale down action. | number | `"0"` | no |
| asg\_scale\_down\_min\_size | Auto Scalling Group value for minimum capacity of bastion hosts. Scale down action. | number | `"0"` | no |
| asg\_scale\_down\_recurrence | The time when recurring future actions will start. Start time is specified by the user following the Unix cron syntax format. Scale down action. | string | `"0 18 * * MON-FRI"` | no |
| asg\_scale\_up\_desired\_capacity | Auto Scalling Group value for desired capacity of bastion hosts. Scale up action. | number | `"1"` | no |
| asg\_scale\_up\_max\_size | Auto Scalling Group value for maximum capacity of bastion hosts. Scale up action. | number | `"1"` | no |
| asg\_scale\_up\_min\_size | Auto Scalling Group value for minimum capacity of bastion hosts. Scale up action. | number | `"1"` | no |
| asg\_scale\_up\_recurrence | The time when recurring future actions will start. Start time is specified by the user following the Unix cron syntax format. Scale up action. | string | `"0 9 * * MON-FRI"` | no |
| availability\_zones | Availability zones for the default Ireland region. | list(string) | `[ "eu-west-1a", "eu-west-1b", "eu-west-1c" ]` | no |
| bastion\_instance\_types | Bastion instance types used for spot instances. | list(string) | `[ "t3.nano", "t3.micro", "t3.small", "t2.nano", "t2.micro", "t2.small" ]` | no |
| desired\_capacity | Auto Scalling Group value for desired capacity of bastion hosts. | number | `"1"` | no |
| egress\_cidr\_blocks | List of CIDR ranges to allow outbound traffic at security group level. Defaults to 0.0.0.0/0 | list(string) | `[ "0.0.0.0/0" ]` | no |
| enable\_asg\_scale\_down |  | bool | `"false"` | no |
| enable\_asg\_scale\_up |  | bool | `"false"` | no |
| hosted\_zone\_id | Hosted zone id where A record will be added for bastion host/s. | string | `""` | no |
| ingress\_cidr\_blocks | List of CIDR ranges to allow ssh access at security group level. Defaults to 0.0.0.0/0 | list(string) | `[ "0.0.0.0/0" ]` | no |
| max\_size | Auto Scalling Group value for maximum capacity of bastion hosts. | number | `"1"` | no |
| min\_size | Auto Scalling Group value for minimum capacity of bastion hosts. | number | `"1"` | no |
| private\_subnets | Classless Inter-Domain Routing ranges for private subnets. | list(string) | `[]` | no |
| region | AWS region in which resources will get deployed. Defaults to Ireland. | string | `"eu-west-1"` | no |
| ssh\_port | SSH port used to access a bastion host. | string | `"22"` | no |
| tags | Default tags attached to all resources. | map(string) | `{ "ServiceType": "ceng-eks" }` | no |
| termination\_policies | A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, OldestLaunchTemplate, AllocationStrategy. | list(string) | `[ "OldestInstance" ]` | no |
| userdata\_file\_content |  | string | `""` | no |

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
