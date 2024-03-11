# DB Instance
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
resource "google_sql_database_instance" "kel1-sql" {
    name = "kel1-sql"
    region = var.region
    database_version = "POSTGRES_15"

    depends_on = [ google_service_networking_connection.private_vpc_connection_support_kel1 ]

    settings {
      tier = "db-f1-micro"
      availability_type = "ZONAL"
      disk_autoresize = true
      disk_size = 10
      disk_type = "PD_SSD"

      backup_configuration {
        enabled = true
        location = var.region
        transaction_log_retention_days = 7

        backup_retention_settings {
          retained_backups = 7
        }
      }

      ip_configuration {
        ipv4_enabled = true
        private_network = google_compute_network.vpc-kel1.id

        authorized_networks {
          name = "public"
          value = "0.0.0.0/0"
        }
      }

      # bug?
      deletion_protection_enabled = false

      insights_config {
        query_insights_enabled = true
      }  
    }

    deletion_protection = false
}

# Database
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database

resource "google_sql_database" "kel1-production" {
    name = "kel1-production"
    instance = google_sql_database_instance.kel1-sql.name
}


# Create DB User
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user

resource "google_sql_user" "kel1-user" {
   name = "kel1"
   password = "kel1secrete"
   instance = google_sql_database_instance.kel1-sql.name
}

# [Recommendation] Create Service Account for CloudSQL
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account


# [Recommendation] Add Permission to Service Account
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
