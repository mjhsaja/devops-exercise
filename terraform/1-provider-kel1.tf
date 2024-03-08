# Init command
# gcloud config set project mashanz-software-engineering

# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = var.project_id
  region = var.region
  zone = var.zone
}

# https://terraform.io/language/settings/backends/gcs
# A backend defines where Terraform stores its state data files.
terraform {
  backend "gcs" {
    bucket = "onxp-terraform"
    prefix = "terraform/state"
  }

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.14.0"
    }
  }
}