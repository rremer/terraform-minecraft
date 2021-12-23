data "http" "public_ipv4" {
  url = var.connection_public_ipv4_api_url
}

resource "google_compute_firewall" "app" {
  name     = "${module.this.module_name}-app"
  network  = "default"
  priority = 100

  allow {
    protocol = "udp"
    ports    = module.this.ports_udp
  }

  allow {
    protocol = "tcp"
    ports    = module.this.ports_tcp
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [module.this.module_name]
}

resource "google_compute_firewall" "ssh" {
  name     = "${module.this.module_name}-ssh"
  network  = "default"
  priority = 100

  allow {
    protocol = "tcp"
    ports    = [22]
  }

  source_ranges = [trimspace(data.http.public_ipv4.body)]
  target_tags   = [module.this.module_name]
}

resource "google_compute_firewall" "ping" {
  name     = "${module.this.module_name}-ping"
  network  = "default"
  priority = 100

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [module.this.module_name]
}

resource "google_compute_firewall" "default" {
  name     = "${module.this.module_name}-default-deny"
  network  = "default"
  priority = 900

  deny {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [module.this.module_name]
}

