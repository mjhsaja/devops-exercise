# NAT
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat
resource "google_compute_router_nat" "natgw_k2_devops" {
  name                               = "natgw_k2_devops"
  router                             = google_compute_router.router_k2_devops.name
  region                             = google_compute_router.router_k2_devops.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

# Reserve Static IP Address for NAT
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address