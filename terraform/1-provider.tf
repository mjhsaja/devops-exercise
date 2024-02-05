# Init command
# gcloud config set project pmrms-362603
# gcloud container clusters get-credentials primary --region=asia-southeast2-a

# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = var.project_id
  region = var.region
}

# https://terraform.io/language/settings/backends/gcs
terraform {
  backend "gcs" {
    bucket = "#"
    prefix = "terraform/state"
  }

  required_providers {
    google = {
        source = "hashicorp/google"
        version = "5.14.0"
    }
  }
}