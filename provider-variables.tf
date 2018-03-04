variable "provider_credentials_path" {
  type        = "string"
  default     = "~/.config/google-cloud-compute/minecraft.json"
  description = "Path to credentials file for provider auth."
}

variable "provider_project_id" {
  type        = "string"
  default     = "minecraft-197021"
  description = "The project ID."
}
