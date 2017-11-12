if_then_else Terraform Utility Module
=====================================

Conditional logic that can be used with (i.e. output) list values.

This module was inspired by (i.e. it is a near-verbatim copy of) [this currently-WIP module](https://github.com/cloudnativelabs/terraform-packet-kubernetes/tree/provider-agnostic-reorg/if_then_list), over in the [terraform-packet-kubernetes](https://github.com/cloudnativelabs/terraform-packet-kubernetes) repo.
This implementation simply externalizes the conditional and exposes an internal truth table for additional flexibility.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| if | Boolean to check<br>Supported patterns: y\|n, true\|false, 0\|1 | string | - | yes |
| then | List to return when true | list | - | yes |
| else | List to return when false | list | - | yes |
| facts | map<string, bool> which will extend the internal truth table | map | `<map>` | no |
| separator | Separator used during intermediate processing | string | `^:--:^` | no |

## Outputs

| Name | Description |
|------|-------------|
| result | Resulting list |

## Usage

```hcl
# main.tf
variable "bool" {}

module "if_then_list" {
  source = "./if_then_list"
  if     = "${var.bool}"
  then   = ["a", "b", "c"]
  else   = ["x", "y", "x"]
}

output "if_then_list.result" {
  value = "${module.if_then_list.result}"
}
```

```hcl
$ terraform apply
var.bool
  Enter a value: 0

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

if_then_list.result = [
    a,
    b,
    c
]
```

```hcl
$ terraform apply
var.bool
  Enter a value: 1

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

if_then_list.result = [
    x,
    y,
    x
]
```
