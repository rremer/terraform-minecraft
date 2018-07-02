variable "ssl_private_key_path" {
  type        = "string"
  default     = "~/.ssh/org-rremer-minecraft_key.pem"
}

variable "ssl_certificate_path" {
  type        = "string"
  default     = "~/.ssh/org-rremer-minecraft_certificate.pem"
}

variable "ssl_intermediary_path" {
  type        = "string"
  default     = "~/.ssh/org-rremer-minecraft_intermediary.pem"
}
