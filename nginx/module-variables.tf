variable "module_name" {
  type        = "string"
  default     = "nginx"
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

variable "module_install_basedir" {
  type        = "string"
  default     = "/var/lib"
  description = "The root path to construct an installation directory from."
}

variable "module_resource_dir" {
  type        = "string"
  default     = "/usr/share/terraform"
  description = "Base path to configuration scripts."
}

variable "module_dpkg_timeout_s" {
  type        = "string"
  default     = "120"
  description = "Time to wait until dpkg lock is lifted."
}
