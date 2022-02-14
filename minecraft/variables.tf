variable "ports_udp" {
  type        = list(number)
  description = "The UDP ports to serve on."
  default     = [25565]
}

variable "ports_tcp" {
  type        = list(number)
  description = "The TCP ports to serve on."
  default     = [25565]
}

variable "container_image_tag" {
  type        = string
  description = "The container image to run."
  default     = "docker.io/rremer/minecraft-modpack-almond:1.18.1-2"
}

variable "container_persistent_data_path" {
  type        = string
  description = "The path inside var.container_image_tag to persist as a volume on the VM disk."
  default     = "/minecraft-modpack-almond/.minecraft/world"
}

variable "container_persistent_backup_path" {
  type        = string
  description = "The path inside var.container_image_tag to persist as a backup volume on the VM disk."
  default     = "/minecraft-modpack-almond/.minecraft/backup"
}

variable "blocked_by" {
  type        = string
  description = "A string to block execution by via terraform graph dependency waits."
  default     = ""
}
