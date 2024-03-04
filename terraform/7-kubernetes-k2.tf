# Kubernetes
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster

resource "google_container_cluster" "gke_k2_devops" {
    name = "gke-k2-devops"
    location = var.zone_k2
    remove_default_node_pool = true
    initial_node_count       = 1
    network = google_compute_network.vpc_k2_devops.id
    subnetwork = google_compute_subnetwork.subnet_vpc_k2_devops
    
    ip_allocation_policy {
      cluster_secondary_range_name = "k8s-pods-ip-range"
      services_secondary_range_name = "k8s-services-ip-range"
    }
}