locals {
  filter = <<-EOF
    .input
      | fromjson
      | try (getpath(path(${var.path}))) and 1 // { found: "0" }
  EOF
}

data "external" "lookup" {
  program = [
    "jq",
    "${local.filter}",
  ]

  query {
    input = "${jsonencode(var.map)}"
  }
}

locals {
  found = "${lookup(data.external.lookup.result, "found", 1)}"

  keys = "${
    split(
      var.separator,
      local.found ? join(var.separator, keys(data.external.lookup.result)) : ""
    )
  }"

  values = "${
    split(
      var.separator,
      local.found ? join(var.separator, values(data.external.lookup.result)) : ""
    )
  }"

  result = "${
    zipmap(
      compact(local.keys),
      matchkeys(local.values, local.keys, compact(local.keys))
    )
  }"
}
