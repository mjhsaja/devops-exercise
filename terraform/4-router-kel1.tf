# Router
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router

resource "google_compute_router" "kel1-router" {
    name = "kel1-router"
    region = var.region
    network = google_compute_network.vpc-kel1.name
}