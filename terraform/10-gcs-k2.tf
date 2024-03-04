# GCS

resource "google_storage_bucket" "gcs_k2_devops" {
  name = "gcs-k2-devops"
  location = var.region_k2
  storage_class = "STANDARD"
  public_access_prevention = "enforced"
  
  lifecycle_rule {
    condition {
      age = 7
      matches_prefix = ["archive/"]
    }
    action {
      type = "SetStorageClass"
      storage_class = "COLDLINE"
    }
  }
}

resource "google_storage_bucket_object" "uploads_k2" {
    name = "uploads/"
    bucket = "gcs-k2-devops"
    content = " "
}

resource "google_storage_bucket_object" "archives_k2" {
  name = "archive/"
  bucket = "gcs-k2-devops"
  content = " "
}
