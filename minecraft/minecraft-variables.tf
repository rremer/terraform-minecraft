variable "minecraft_download_url" {
  type        = "string"
  default     = "https://media.forgecdn.net/files/2533/332/FTBRevelationServer_1.6.0.zip"
  description = "URL to download minecrafot server modpack."
}

variable "minecraft_min_ram" {
  type    = "string"
  default = "8g"
}

variable "minecraft_max_ram" {
  type    = "string"
  default = "8g"
}

variable "minecraft_install_script" {
  type    = "string"
  default = "FTBInstall.sh"
}

variable "minecraft_ftb_config_template" {
  type    = "string"
  default = "config/config.cfg.tmpl"
}

variable "minecraft_ftb_config_target" {
  type    = "string"
  default = "local/ftbutilities/config.cfg"
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

variable "minecraft_data_subdir" {
  type    = "string"
  default = "world"
}

variable "minecraft_data_symlink" {
  type    = "string"
  default = "/minecraft/world"
}
