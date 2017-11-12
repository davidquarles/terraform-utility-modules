output "result" {
  description = "Lookup output -- if `var.path` does not exist in `var.map`, this will be an empty map"
  value       = "${local.result}"
}

output "found" {
  description = "(Boolean) Lookup outcome"
  value       = "${local.found}"
}
