# [Recommendation] Service Account for Node Pool
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account

resource "google_service_account" "sa_pool_gke_k2_devops" {
  account_id   = "sapoolgkek2devops"
  display_name = "ServiceAccount - Pool GKE K2 Devops"
}

# Node Pool
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool

resource "google_container_node_pool" "pool_gke_k2_devops" {
  name = "pool-gke-k2-devops"
  cluster = google_container_cluster.gke_k2_devops.id
  node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  node_locations = [ var.zone_k2 ]

  management {
    auto_repair = true
    auto_upgrade = true
  }
  
  node_config {
    preemptible = true
    machine_type = "e2-micro"
    image_type = "COS_CONTAINERD"
    disk_size_gb = 50
    disk_type = "pd-balanced"
    service_account = google_service_account.sa_pool_gke_k2_devops.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

}