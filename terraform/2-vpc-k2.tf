# VPC

# Enable Google API
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"
}

# Create a VPC network
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
resource "google_compute_network" "vpc_k2_devops" {
  name = "vpc-k2-devops"
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
# Create an IP Address
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address
resource "google_compute_global_address" "private_ip_alloc_k2_devops" {
  name          = "private-ip-alloc-k2-devops"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc_k2_devops.id
}

# Create a private connection
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection
resource "google_service_networking_connection" "private_vpc_connection_k2_devops" {
  network                 = google_compute_network.vpc_k2_devops.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc_k2_devops.name]
}
