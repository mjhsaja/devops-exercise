# Subnet
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
# kubernetes yg punya IP:
# 1. NOdes
# 2. Pods
# 3. Service 

resource "google_compute_subnetwork" "subnet_vpc_kel1" {
  name = "subnet-vpc-kel1"
  # IP untuk Nodes
  ip_cidr_range = "10.0.0.0/18"
  region = var.region
  network = google_compute_network.vpc-kel1.id
  private_ip_google_access = true
  
  # IP untuk Pods
  secondary_ip_range {
    range_name    = "k8s-pods-ip-range"
    ip_cidr_range = "10.48.0.0/14"
  }
  
  # IP untuk services
  secondary_ip_range {
    range_name    = "k8s-services-ip-range"
    ip_cidr_range = "10.52.0.0/20"
  }
}