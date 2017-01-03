variable "module_name" {
  type        = "string"
  default     = "ntp"
  description = "The name of this module."
}

variable "module_properties" {
  type        = "string"
  default     = "module.properties"
  description = "Path to configuration properties for this module."
}

variable "module_install_log" {
  type        = "string"
  default     = "install.log"
  description = "Filename of the installation log for this service's configuration."
}

variable "remote_resource_dir" {
  type        = "string"
  default     = "/usr/share/terraform"
  description = "Base path to configuration scripts."
}

variable "connection_user" {
  type        = "string"
  description = "SSH username."
}

variable "connection_host" {
  type        = "string"
  description = "SSH remote host (IP or name)."
}

variable "connection_private_key" {
  sensitive   = true
  type        = "string"
  description = "SSH RSA private key material. Not a path to a file."
}

variable "connection_port" {
  type        = "string"
  default     = "22"
  description = "SSH remote port."
}

variable "dpkg_timeout_s" {
  type        = "string"
  default     = "120"
  description = "Time to wait until dpkg lock is lifted."
}

variable "ntp_timezone" {
  type        = "string"
  default     = "America/Los_Angeles"
  description = "The timezone to set the system clock to."
}

variable "ntp_peers" {
  type = "list"

  default = ["0.amazon.pool.ntp.org",
    "1.amazon.pool.ntp.org",
    "2.amazon.pool.ntp.org",
    "3.amazon.pool.ntp.org",
  ]

  description = "Space-delimited list of ntp peer servers."
}
