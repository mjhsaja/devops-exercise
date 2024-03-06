# Kubernetes
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster

resource "google_container_cluster" "gke_k2_devops" {
    name = "gke-k2-devops"
    location = var.zone_k2
    remove_default_node_pool = true
    initial_node_count       = 1
    network = google_compute_network.vpc_k2_devops.id
    subnetwork = google_compute_subnetwork.subnet_vpc_k2_devops.self_link
    networking_mode = "VPC_NATIVE"
    logging_service = "none"
    monitoring_service = "none"
    
    addons_config {
      http_load_balancing {
        disabled = true
      }
      horizontal_pod_autoscaling {
        disabled = true
      }
    }

    release_channel {
      channel = "REGULAR"
    }
    
    ip_allocation_policy {
      cluster_secondary_range_name = "k8s-pods-ip-range"
      services_secondary_range_name = "k8s-services-ip-range"
    }

    private_cluster_config {
      enable_private_nodes = true
      enable_private_endpoint = false
      master_ipv4_cidr_block = "172.24.0.0/28"
    }

    workload_identity_config {
      workload_pool = "${var.project_id}.svc.id.goog"
    }
}