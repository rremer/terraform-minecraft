variable "minecraft_download_url" {
  type        = "string"
  default     = "https://media.forgecdn.net/files/2533/332/FTBRevelationServer_1.6.0.zip"
  description = "URL to download minecrafot server modpack."
}

variable "minecraft_install_script" {
  type    = "string"
  default = "FTBInstall.sh"
}

variable "minecraft_start_script" {
  type    = "string"
  default = "server_start.sh"
}

variable "minecraft_start_properties" {
  type    = "string"
  default = "server_start.properties"
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
