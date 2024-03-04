# NAT
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat
resource "google_compute_router_nat" "natgw_k2_devops" {
  name                               = "natgw_k2_devops"
  router                             = google_compute_router.router_k2_devops.name
  region                             = google_compute_router.router_k2_devops.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  nat_ips = [ google_compute_address.addr_nat_k2_devops.*.self_link ]

  subnetwork {
    name                    = google_compute_subnetwork.subnet_vpc_k2_devops.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

}

# Reserve Static IP Address for NAT
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address

resource "google_compute_address" "addr_nat_k2_devops" {
  name = "addr-nat-k2-devops"
  address = "EXTERNAL"
  network_tier = "STANDARD"
  region = var.region_k2

  depends_on = [ google.google_project_service.compute ]
}