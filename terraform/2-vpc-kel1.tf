# VPC

# Enable Google API
#resource "google_project_service" "compute" {
#  service = "compute.googleapis.com"
#}

#resource "google_project_service" "container" {
#  service = "container.googleapis.com"
#}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
resource "google_compute_network" "vpc-kel1" {
  name = "vpc-kel1"
  routing_mode = "REGIONAL"
  auto_create_subnetworks = false
  mtu = 1460
  delete_default_routes_on_create = false

  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}

# VPC Peering to Google Service
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address
resource "google_compute_global_address" "private_ip_address_support_kel1" {
  name          = "private-ip-address-support-kel1"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc-kel1.id
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection
resource "google_service_networking_connection" "private_vpc_connection_support_kel1" {
  network                 = google_compute_network.vpc-kel1.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address_support_kel1.name]
}
