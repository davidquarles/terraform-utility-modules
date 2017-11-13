contains Terraform Utility Module
=================================

This module implements functionality similar to the native `contains` interpolation function, adding
type-agnostic support for deep traversal of any complex data type (maps, lists, and nested combinations of
the two).

#### Disclaimer:
* This will hard-fail if the input is _not_ a (json-encoded) complex type.
* This is tested only against Terraform v0.11, and is not intended for production use.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| input | JSON-encoded complex type | string | - | yes |
| path | [jq](https://stedolan.github.io/jq/manual) path to extract (e.g. `.foo[-1].bar`)<br>Use complex / ambiguous paths at your own risk! | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| result | (Boolean) Lookup result |

Usage
-----
```hcl
variable "path" {}

locals {
  test {
    a {
      b = [
        {
          c {
            foo = "bar"
          }
        }
      ]
    }
  }
}

module "contains" {
  source = "github.com/davidquarles/terraform-utility-modules//contains"
  input  = "${jsonencode(local.test)}"
  path   = "${var.path}"
}

output "result" {
  value = "${module.contains.result}"
}
```

```hcl
$ terraform apply
var.path
  Enter a value: .a.b[0].c.foo

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

result = 1
```

```hcl
$ terraform apply
var.path
  Enter a value: .foo[]

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

result = 0
```

## Requirements
* [jq](https://stedolan.github.io/jq)
