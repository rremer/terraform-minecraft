variable "module_name" {
  type        = "string"
  default     = "backup"
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

variable "backup_directory" {
  type        = "string"
  description = "Full path to backup."
}

variable "backup_user" {
  type        = "string"
  default     = "root"
  description = "User to execute backup as."
}

variable "backup_rate_limit_kbs" {
  type        = "string"
  default     = "1000"
  description = "KB/s to rate-limit backup uploads to."
}

variable "s3_config_path" {
  type        = "string"
  default     = "/etc/backup.s3cfg"
  description = "Full path to an s3cfg file."
}

variable "interval_minutes" {
  type        = "string"
  default     = "15"
  description = "Interval between backups."
}

variable "dpkg_timeout_s" {
  type        = "string"
  default     = "120"
  description = "Time to wait until dpkg lock is lifted."
}

variable "keep_days" {
  type        = "string"
  default     = "7"
  description = "Expiry for backups in days, -1 to keep forever."
}

variable "module_install_basedir" {
  type        = "string"
  default     = "/var/lib"
  description = "Base path to install this backup service."
}

variable "backup_endpoint" {
  type        = "string"
  description = "The name of the bucket to backup to."
}

variable "bucket_acl" {
  type        = "string"
  default     = "public-read"
  description = "Default access control list configuration for the s3 bucket."
}
