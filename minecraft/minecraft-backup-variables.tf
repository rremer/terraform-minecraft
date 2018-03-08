variable "minecraft_backup_enabled" {
  type        = "string"
  default     = "true"
  description = "Bool to remove any minecraft mods for data backup."
}

variable "minecraft_backup_hours_interval_float" {
  type        = "string"
  default     = "0.5"
  description = "Float of hourly interval to backup."
}

variable "minecraft_backup_keep_int" {
  type        = "string"
  default     = "96"
  description = "Integer of backups to keep."
}

variable "minecraft_backup_compression" {
  type        = "string"
  default     = "9"
  description = "Compression ratio, 0 to disable, 9 for max."
}

variable "minecraft_backup_silent" {
  type        = "string"
  default     = "true"
  description = "Bool to display backup information in chat."
}

variable "minecraft_backup_data_dir" {
  type        = "string"
  default     = "/minecraft/backups"
  description = "Path to a directory to store backups."
}
