# Subnet
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "subnet_vpc_k2_devops" {
  name = "subnet-vpc-k2-devops"
  ip_cidr_range = "10.0.0.0/18"
  region = var.region_k2
  network = google_compute_network.vpc_k2_devops.id
  private_ip_google_access = true
  
  secondary_ip_range {
    range_name    = "k8s-pods-ip-range"
    ip_cidr_range = "10.48.0.0/14"
  }
  
  secondary_ip_range {
    range_name    = "k8s-services-ip-range"
    ip_cidr_range = "10.52.0.0/20"
  }
}