variable "java_download_url" {
  type        = "string"
  default     = "https://cdn.azul.com/zulu/bin/zulu8.38.0.13-ca-jre8.0.212-linux_x64.tar.gz"
  description = "URL to a Java Runtime Environment package."
}

variable "java_install_directory" {
  type        = "string"
  default     = "/var/lib/java"
  description = "Path to a directory to install java into."
}

variable "java_min_ram" {
  type    = "string"
  default = "8g"
}

variable "java_max_ram" {
  type    = "string"
  default = "8g"
}
