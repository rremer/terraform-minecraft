variable "module_name" {
  type        = "string"
  default     = "minecraft"
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

variable "module_install_basedir" {
  type        = "string"
  default     = "/var/lib"
  description = "The root path to construct an installation directory from."
}

variable "minecraft_min_ram" {
  type    = "string"
  default = "6g"
}

variable "dpkg_timeout_s" {
  type        = "string"
  default     = "120"
  description = "Time to wait until dpkg lock is lifted."
}

variable "minecraft_max_ram" {
  type    = "string"
  default = "6g"
}

variable "minecraft_install_script" {
  type    = "string"
  default = "FTBInstall.sh"
}

variable "minecraft_local_config" {
  type    = "string"
  default = "local/ftbu/config.json"
}

variable "minecraft_start_script" {
  type    = "string"
  default = "ServerStart.sh"
}

variable "minecraft_settings_script" {
  type    = "string"
  default = "settings.sh"
}

variable "minecraft_eula" {
  type    = "string"
  default = "eula.txt"
}

variable "minecraft_backup_enabled" {
  type        = "string"
  default     = "true"
  description = "Bool to remove any minecraft mods for data backup."
}

variable "minecraft_data_subdir" {
  type    = "string"
  default = "world"
}

variable "minecraft_data_symlink" {
  type        = "string"
  default     = "/minecraft/world"
  description = "Path to symlink the local world data to."
}

variable "minecraft_download_url" {
  type    = "string"
  default = "http://ftb.cursecdn.com/FTB2/modpacks/FTBInfinityLite110/1_4_1/FTBInfinityLite110Server.zip"
}

variable "minecraft_property_file" {
  type    = "string"
  default = "server.properties"
}

variable "minecraft_property_motd" {
  type    = "string"
  default = ""
}

variable "minecraft_property_difficulty" {
  type    = "string"
  default = "3"
}

variable "minecraft_port" {
  type        = "string"
  default     = "25565"
  description = "The minecraft server port."
}
