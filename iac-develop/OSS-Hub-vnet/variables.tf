variable "location" {
  description = "The location where the hub VNet will be created."
  type        = string
}

variable "default_tags" {
  description = "Common tags for resources."
  type        = map(string)
} 