# terraform-aws-bastion

Terraform module to create Bastion Host in AWS VPC running as Spot Instance/s

## Resources created

This module will create Bastion Host/s which will make use of Launch Template and Auto Scaling Group. Bastion host will run as a spot instance. In order to reduce the amount of Elastic IPs, module creates a route53 A record which points to the bastion host/s.

## Terraform versions

Terraform 0.12. Pin module version to `~> v1.0`. Submit pull-requests to `master` branch.

## Usage

```hcl

```

## Bastion Host Visual Architecture

![Basiton](bastion-arch.jpeg)

## Assumptions

Module is to be used with Terraform > 0.12.

## Examples

* [Bastion Host](https://github.com/umotif-public/terraform-aws-alb/tree/master/examples/alb)

## Authors

Module managed by [Marcin Cuber](https://github.com/marcincuber) [linkedin](https://www.linkedin.com/in/marcincuber/).

## License

See LICENSE for full details.