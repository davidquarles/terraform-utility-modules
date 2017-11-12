variable "map" {
  description = "Nested map from which to extract `var.path`"
  type        = "map"
}

variable "path" {
  description = <<-EOF
    Path to extract, using jq path/filter notation, e.g. `.foo[-1].bar` --
    must match 0 or 1 flat maps (use complex expressions at your own risk)
  EOF

  type = "string"
}

variable "separator" {
  default     = "^:--:^"
  description = "separator used when converting maps from/to strings"
}
