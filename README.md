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
  version = "~> 1.0"
  
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

* [Bastion Host](https://github.com/umotif-public/terraform-aws-bsation/tree/master/examples/core)

## Authors

Module managed by [Marcin Cuber](https://github.com/marcincuber) [linkedin](https://www.linkedin.com/in/marcincuber/).

## License

See LICENSE for full details.