locals {
  filter = <<-EOF
    .input
      | fromjson
      | {
        found: (
          try (getpath(path(${var.path}))) and 1 // false
        ) | tostring
      }
  EOF
}

data "external" "lookup" {
  program = [
    "jq",
    "${local.filter}",
  ]

  query {
    input = "${var.input}"
  }
}

locals {
  found = "${lookup(data.external.lookup.result, "found", 1)}"
}
