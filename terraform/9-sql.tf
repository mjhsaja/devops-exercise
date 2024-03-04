# DB Instance
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
resource "google_sql_database_instance" "onxp-sql" {
  name             = "onxp-sql"
  region           = var.region
  database_version = "MYSQL_8_0"

  depends_on = [google_service_networking_connection.private_vpc_connection_support]

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
      private_network = google_compute_network.main.id

      authorized_networks {
        name = "public"
        value = "0.0.0.0/0"
      }
    }

    deletion_protection_enabled = true

    insights_config {
      query_insights_enabled = true
    }
  }
}

# Database
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database

resource "google_sql_database" "onxp-production" {
  name = "onxp-production"
  instance = google_sql_database_instance.onxp-sql.name
}


# Create DB User
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user

resource "google_sql_user" "onxp-user" {
  name = "onxp"
  password = "onxpsecret"
  instance = google_sql_database_instance.onxp-sql.name
}


# [Recommendation] Create Service Account for CloudSQL
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account


# [Recommendation] Add Permission to Service Account
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
