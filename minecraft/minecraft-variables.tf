variable "minecraft_download_url" {
  type        = "string"
  default     = "https://media.forgecdn.net/files/2533/332/FTBRevelationServer_1.6.0.zip"
  description = "URL to download minecrafot server modpack."
}

variable "minecraft_start_script" {
  type    = "string"
  default = "start_server.sh"
}

variable "minecraft_start_properties" {
  type    = "string"
  default = "start_server.properties"
}

variable "minecraft_eula" {
  type    = "string"
  default = "eula.txt"
}
