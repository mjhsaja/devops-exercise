# [Recommendation] Service Account for Node Pool
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "kubernetes-kel1-sa" {
  account_id = "kubernetes-kel1-sa"
}

# Node Pool
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "kel1-node-pool" {
    name = "kel1-node-pool"
    cluster = google_container_cluster.kel1-kubernetes.id
    location = "${var.region}-a"
    node_count = 1

    autoscaling {
      min_node_count = 1
      max_node_count = 1
      location_policy = "BALANCED"
    }

    management {
      auto_repair = true
      auto_upgrade = true
    }

    node_config {
      preemptible = true
      machine_type = "e2.micro"
      disk_size_gb = 20
      disk_type = "pd-balanced"

      service_account = google_service_account.kubernetes-kel1-sa.email
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
    }
}