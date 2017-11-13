output "result" {
  description = "(Boolean) Lookup outcome"
  value       = "${lookup(data.external.lookup.result, "found")}"
}
