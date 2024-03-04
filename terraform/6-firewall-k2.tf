# Firewall
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall

resource "google_compute_firewall" "fw_k2_devops" {
    name = "fw-k2-devops"
    network = google_compute_network.vpc_k2_devops.name

    allow {
      protocol = "tcp"
      ports = ["28015","22"]
    }

    target_tags = ["tags-fw-k2-devops"]
}