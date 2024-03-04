# DB Instance
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance

resource "google_sql_database_instance" "db_instance_k2_devops" {
    name = "db_instance_k2_devops"
    database_version = "POSTGRES_15"
    region = var.region_k2

    depends_on = [google_service_networking_connection.private_vpc_connection_k2_devops]
    
    settings {
        tier = "db-g1-small"
        edition = "ENTERPRISE"
        disk_size = 10
        disk_type = "PD_HDD"
        ip_configuration {
            ipv4_enabled = false
            private_network = google_compute_network.vpc_k2_devops
            enable_private_path_for_google_cloud_services = true
        }
    }

}

# Database
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database

resource "google_sql_database" "db_k2_devops" {
  name     = "db_k2_devops"
  instance = google_sql_database_instance.db_instance_k2_devops.name
}

# Create DB User
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user

resource "google_sql_user" "db_user_k2_devops" {
  name     = "me"
  instance = google_sql_database_instance.db_instance_k2_devops.name
  password = "PassUserDbK2"
}

# [Recommendation] Create Service Account for CloudSQL
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account

resource "google_service_account" "sa_db_k2_devops" {
  account_id   = "sadbk2devops"
  display_name = "ServiceAccount - DB K2 Devops"
}

# [Recommendation] Add Permission to Service Account
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
