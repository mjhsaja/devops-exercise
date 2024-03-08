# Kubernetes
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "kel1-kubernetes" {
    name = "kel1-kubernetes"
    location = "${var.region}"
    initial_node_count = 1
    remove_default_node_pool = true
    network = google_compute_network.vpc-kel1.self_link
    subnetwork = google_compute_subnetwork.subnet_vpc_kel1.self_link
    logging_service = "none"
    monitoring_service = "none"
    networking_mode = "VPN_NATIVE"

    addons_config {
      horizontal_pod_autoscaling {
        disabled = true
      }

      http_load_balancing {
        disabled = true
      }
    }

    release_channel {
      channel = "REGULER"
    }

    ip_allocation_policy {
       cluster_secondary_range_name = google_compute_subnetwork.subnet_vpc_kel1.secondary_ip_range[0].range_name
       services_secondary_range_name = google_compute_subnetwork.subnet_vpc_kel1.secondary_ip_range[1].range_name
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