nested_map_lookup Terraform Utility Module
============================================

This is a hacky implementation of (arbitrarily) nested map lookups, using pure terraform,
as a workaround for current HCL limitations.
This is intended to support dynamic resource creation in a reusable way using complex, hierarchical
maps (not that this is something I'm necessarily advocating).

Note that this module supports a _very_ specific use case (see limitations below), but it can easily
be extended, with very slight modifications, to support a range of other use cases -- nested lookups of
other other types, type-agnostic existence checks, etc.

#### Disclaimer:
* This will hard-fail if the target path contains any data structure besides a flat map (or an undefined key).
* There is no current support for default values, but the `found` output parameter should enable this externally.
* This is tested only against Terraform v0.11, and is not intended for production use.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| map | Nested map from which to extract `var.path` | map | - | yes |
| path | [jq](https://stedolan.github.io/jq/manual) path to extract (e.g. `.foo[-1].bar`), matching 0\|1 flat maps<br>Use complex / ambiguous paths at your own risk! | string | - | yes |
| separator | Separator used when converting maps from/to strings | string | `^:--:^` | no |

## Outputs

| Name | Description |
|------|-------------|
| found | (Boolean) Lookup outcome |
| result | Lookup output -- if `var.path` does not exist in `var.map`, this will be an empty map |

Usage
-----
```hcl
locals {
  test {
    a {
      b {
        c {
          foo = "bar"
        }
      }
      d = [
        {
          e {
            foo = "baz"
          }
        }
      ]
    }
  }
}

module "lookup1" {
  source = "github.com/davidquarles/terraform-utility-modules//nested_map_lookup"
  map    = "${local.test}"
  path   = ".a.b.c"
}

module "lookup2" {
  source = "github.com/davidquarles/terraform-utility-modules//nested_map_lookup"
  map    = "${local.test}"
  path   = ".a.b.x"
}

module "lookup3" {
  source = "github.com/davidquarles/terraform-utility-modules//nested_map_lookup"
  map    = "${local.test}"
  path   = ".a.d[0].e"
}
```

```hcl
$ terraform apply

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

lookup1.found  = 1
lookup1.result = {
  foo = bar
}
lookup2.found  = 0
lookup2.result = {}
lookup3.found  = 1
lookup3.result = {
  foo = baz
}
```

## Requirements
* [jq](https://stedolan.github.io/jq)
