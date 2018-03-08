resource "google_compute_disk" "persistent" {
  name  = "${var.global_app_name}-persistent"
  zone  = "${data.google_compute_zones.available.names.0}"
  size  = "5"
}
