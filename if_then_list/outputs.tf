output result {
  description = "Resulting list"
  value       = "${local.result}"
}

locals {
  facts {
    "0"     = 0
    "false" = 0
    "n"     = 0
    "1"     = 1
    "true"  = 1
    "y"     = 1
  }

  then_string = "${join(var.separator, var.then)}"
  else_string = "${join(var.separator, var.else)}"

  result_string = "${
    lookup(merge(local.facts, var.facts), var.if, 0)
      ? local.then_string
      : local.else_string
  }"

  result = "${split(var.separator, local.result_string)}"
}
