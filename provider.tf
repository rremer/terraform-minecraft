provider "google" {
  region      = "${var.compute_region}"
  project     = "${var.provider_project_id}"
  credentials = "${file("${var.provider_credentials_path}")}"
}

terraform {
  version = "= 0.11.13"
}
