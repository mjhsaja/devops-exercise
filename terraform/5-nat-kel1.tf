# NAT
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat
resource "google_compute_router_nat" "kel1-nat" {
  name = "kel1-nat"
  router = google_compute_router.kel1-router.name
  region =  var.region

  nat_ip_allocate_option = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  nat_ips = [google_compute_address.kel1-nat-address.self_link]

  subnetwork {
    name = google_compute_subnetwork.subnet_vpc_kel1.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

# Reserve Static IP Address for NAT
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address
resource "google_compute_address" "kel1-nat-address" {
    name = "kel1-nat-address"
    address_type = "EXTERNAL"
    network_tier = "PREMIUM"

    depends_on = [ google_project_service.compute ]
}