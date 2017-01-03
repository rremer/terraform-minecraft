variable "devices" {
  type        = "list"
  default     = []
  description = "A list of devices to manage with LVM."
}

variable "volume_group_name" {
  type        = "string"
  default     = "tank"
  description = "The logical name of the LVM volume group."
}

variable "volume_mount_point" {
  type        = "string"
  default     = "/tank"
  description = "The mounted path to the formatted volume group."
}

variable "volume_format" {
  type        = "string"
  default     = "ext4"
  description = "Format of logical volume, must be supported by mkfs."
}

variable "module_name" {
  type        = "string"
  default     = "lvm"
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
