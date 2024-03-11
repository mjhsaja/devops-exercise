# Firewall
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall

resource "google_compute_firewall" "fw-ssh-kel1" {
  name = "fw-ssh-kel1"
  network = google_compute_network.vpc-kel1.name

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  target_tags = ["tags-fw-ssh-kel1"]  
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "fw-http-kel1" {
  name = "fw-http-kel1"
  network = google_compute_network.vpc-kel1.name

  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["tags-fw-http-kel1"]
}