resource "yandex_storage_bucket" "website" {
  provider      = yandex.storage
  bucket        = "byzgaev-website-20250305"
  force_destroy = true
  acl           = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD", "PUT"]
    allowed_origins = ["*"]
    max_age_seconds = 3600
  }

  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }

  https {
    certificate_id = yandex_cm_certificate.website_cert.id
  }
}

output "website_bucket_name" {
  value = yandex_storage_bucket.website.bucket
}

output "website_endpoint" {
  value = yandex_storage_bucket.website.website_endpoint
}
