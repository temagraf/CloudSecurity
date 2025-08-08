resource "yandex_cm_certificate" "website_cert" {
  name    = "website-cert"
  domains = ["byzgaev-website-20250305.website.yandexcloud.net"]

  managed {
    challenge_type = "HTTP"
  }
}

output "certificate_id" {
  value = yandex_cm_certificate.website_cert.id
}
