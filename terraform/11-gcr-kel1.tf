# GCR

resource "google_service_account" "gcr-kel1-sa" {
  account_id = "gcr-kel1-sa"
}

resource "google_project_iam_member" "gcr-kel1-iam" {
  project = var.project_id
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.gcr-kel1-sa.email}"
}

resource "google_project_iam_member" "gcr-kel1-artifact-iam" {
  project = var.project_id
  role = "roles/artifactregistry.admin"
  member = "serviceAccount:${google_service_account.gcr-kel1-sa.email}"
}

resource "google_project_iam_member" "gcr-kel1-artifact-uploader-iam" {
  project = var.project_id
  role = "roles/artifactregistry.repoAdmin"
  member = "serviceAccount:${google_service_account.gcr-kel1-sa.email}"
}

resource "google_artifact_registry_repository" "kel1-repo" {
  location      = "us-central1"
  repository_id = "kel1-repo"
  format        = "DOCKER"
}