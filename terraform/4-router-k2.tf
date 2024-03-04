# Router
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router
resource "google_compute_router" "router_k2_devops" {
  name    = "router-k2-devops"
  network = google_compute_network.vpc_k2_devops.name
}
