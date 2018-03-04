variable "compute_instance_size" {
  type        = "string"
  default     = "n1-standard-4"
  description = "The compute server size/flavor."
}

variable "compute_image_name" {
  type        = "string"
  default     = "ubuntu"
  description = "The friendly name for the boot image."
}

variable "compute_image_family" {
  type        = "string"
  default     = "ubuntu-1604-lts"
  description = "The search token for a bootable image."
}

variable "compute_image_project" {
  type        = "string"
  default     = "ubuntu-os-cloud"
  description = "The project owning the compute image."
}

variable "compute_region" {
  type        = "string"
  default     = "us-west1"
  description = "The deployment availability zone."
}
