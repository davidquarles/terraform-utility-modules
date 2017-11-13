variable "input" {
  description = "JSON-encoded complex type"
  type        = "string"
}

variable "path" {
  description = "Path to extract, using jq path/filter notation, e.g. `.foo[-1].bar`"
  type        = "string"
}
