# Change Log

All notable changes to this project will be documented in this file.

<a name="unreleased"></a>
## [Unreleased]

- Add documentation ([#18](https://github.com/umotif-public/terraform-aws-bastion/issues/18))
- Allow setting time_zone for ASG schedules ([#17](https://github.com/umotif-public/terraform-aws-bastion/issues/17))


<a name="2.2.0"></a>
## [2.2.0] - 2021-06-04

- Add tags to IAM profile ([#14](https://github.com/umotif-public/terraform-aws-bastion/issues/14))


<a name="2.1.0"></a>
## [2.1.0] - 2021-04-23

- Update AWS partition sourcing ([#13](https://github.com/umotif-public/terraform-aws-bastion/issues/13))


<a name="2.0.3"></a>
## [2.0.3] - 2021-02-19

- Update bastion-userdata.sh ([#12](https://github.com/umotif-public/terraform-aws-bastion/issues/12))


<a name="2.0.2"></a>
## [2.0.2] - 2021-02-19

- Update bastion-userdata.sh ([#11](https://github.com/umotif-public/terraform-aws-bastion/issues/11))


<a name="2.0.1"></a>
## [2.0.1] - 2021-02-19

- Fix bastion policy to handle china partition ([#10](https://github.com/umotif-public/terraform-aws-bastion/issues/10))


<a name="2.0.0"></a>
## [2.0.0] - 2021-02-17

- Add support for different aws partitions ([#9](https://github.com/umotif-public/terraform-aws-bastion/issues/9))


<a name="1.5.0"></a>
## [1.5.0] - 2020-12-18

- [On Demand] Support for on-demand instance lifecycle type. ([#8](https://github.com/umotif-public/terraform-aws-bastion/issues/8))
- Update README.md


<a name="1.4.2"></a>
## [1.4.2] - 2020-11-09

- Update module to remove 0.14 limit ([#7](https://github.com/umotif-public/terraform-aws-bastion/issues/7))


<a name="1.4.1"></a>
## [1.4.1] - 2020-08-05

- Feature/v3 provider support ([#6](https://github.com/umotif-public/terraform-aws-bastion/issues/6))


<a name="1.4.0"></a>
## [1.4.0] - 2020-07-27

- Feature/volume support ([#5](https://github.com/umotif-public/terraform-aws-bastion/issues/5))


<a name="1.3.0"></a>
## [1.3.0] - 2020-05-21

- Update security group configuration with lifecycle and revoke ([#4](https://github.com/umotif-public/terraform-aws-bastion/issues/4))


<a name="1.2.0"></a>
## [1.2.0] - 2020-04-21

- Feature/ipv6 ([#3](https://github.com/umotif-public/terraform-aws-bastion/issues/3))


<a name="1.1.0"></a>
## [1.1.0] - 2020-04-21

- Allow IPv6 to be utilized ([#2](https://github.com/umotif-public/terraform-aws-bastion/issues/2))
- add git hooks and update docs ([#1](https://github.com/umotif-public/terraform-aws-bastion/issues/1))
- Fix link in readme


<a name="1.0.3"></a>
## [1.0.3] - 2019-12-19

- Update docs and fix hostedzone conditional creation
- update README


<a name="1.0.2"></a>
## [1.0.2] - 2019-12-19

- Add ability to have custom userdata script
- add customisation for asg scaling events and termination policies
- Add conditional scaling of auto scaling group


<a name="1.0.1"></a>
## [1.0.1] - 2019-12-18

- fix important variable
- update README with example usage


<a name="1.0.0"></a>
## 1.0.0 - 2019-12-18

- add outputs and futher improvements
- Add initial bastion configuration
- Initial commit


[Unreleased]: https://github.com/umotif-public/terraform-aws-bastion/compare/2.2.0...HEAD
[2.2.0]: https://github.com/umotif-public/terraform-aws-bastion/compare/2.1.0...2.2.0
[2.1.0]: https://github.com/umotif-public/terraform-aws-bastion/compare/2.0.3...2.1.0
[2.0.3]: https://github.com/umotif-public/terraform-aws-bastion/compare/2.0.2...2.0.3
[2.0.2]: https://github.com/umotif-public/terraform-aws-bastion/compare/2.0.1...2.0.2
[2.0.1]: https://github.com/umotif-public/terraform-aws-bastion/compare/2.0.0...2.0.1
[2.0.0]: https://github.com/umotif-public/terraform-aws-bastion/compare/1.5.0...2.0.0
[1.5.0]: https://github.com/umotif-public/terraform-aws-bastion/compare/1.4.2...1.5.0
[1.4.2]: https://github.com/umotif-public/terraform-aws-bastion/compare/1.4.1...1.4.2
[1.4.1]: https://github.com/umotif-public/terraform-aws-bastion/compare/1.4.0...1.4.1
[1.4.0]: https://github.com/umotif-public/terraform-aws-bastion/compare/1.3.0...1.4.0
[1.3.0]: https://github.com/umotif-public/terraform-aws-bastion/compare/1.2.0...1.3.0
[1.2.0]: https://github.com/umotif-public/terraform-aws-bastion/compare/1.1.0...1.2.0
[1.1.0]: https://github.com/umotif-public/terraform-aws-bastion/compare/1.0.3...1.1.0
[1.0.3]: https://github.com/umotif-public/terraform-aws-bastion/compare/1.0.2...1.0.3
[1.0.2]: https://github.com/umotif-public/terraform-aws-bastion/compare/1.0.1...1.0.2
[1.0.1]: https://github.com/umotif-public/terraform-aws-bastion/compare/1.0.0...1.0.1
