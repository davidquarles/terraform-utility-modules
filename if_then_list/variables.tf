variable if {
  description = "Boolean to check<br>Supported patterns: y|n, true|false, 0|1"
}

variable then {
  description = "List to return when true"
  type        = "list"
}

variable else {
  description = "List to return when false"
  type        = "list"
}

variable separator {
  description = "Optional separator"
  default     = "^:--:^"
}

variable facts {
  default     = {}
  description = "map<string, bool> which will extend the internal truth table"
  type        = "map"
}
