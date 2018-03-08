variable "minecraft_property_file_template" {
  type    = "string"
  default = "config/server.properties.tmpl"
}

variable "minecraft_property_file_target" {
  type    = "string"
  default = "server.properties"
}

variable "minecraft_property_motd" {
  type    = "string"
  default = ""
}

variable "minecraft_property_difficulty" {
  type        = "string"
  default     = "3"
  description = "0 for peaceful, 3 for hard."
}

variable "minecraft_property_allow_flight" {
  type        = "string"
  default     = "true"
  description = "Bool to enable flight enforcement (contrary to mod support)."
}

variable "minecraft_property_port" {
  type        = "string"
  default     = "25565"
  description = "The minecraft server port."
}

variable "minecraft_property_gamemode" {
  type        = "string"
  default     = "0"
  description = "0 for survival, 1 creative, 2 adventure, 3 spectator."
}

variable "minecraft_property_level_seed" {
  type        = "string"
  default     = ""
  description = "Seed value for world generation, blank for random."
}

variable "minecraft_property_compression_threshold_bytes" {
  type        = "string"
  default     = "256"
  description = "Bytes after which packets should be compressed."
}

variable "minecraft_property_level_type" {
  type        = "string"
  default     = "DEFAULT"
  description = "String of world generation type."
}
