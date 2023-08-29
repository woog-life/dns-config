resource "cloudflare_record" "www_cname" {
  zone_id = var.zone_id
  name    = "www"
  type    = "CNAME"
  value   = var.base_domain
  proxied = true
  comment = "Managed by Terraform"
}

resource "cloudflare_record" "base_domain_a" {
  zone_id = var.zone_id
  name    = var.base_domain
  type    = "A"
  value   = var.kubernetes_ip
  proxied = true
  comment = "Managed by Terraform"
}

resource "cloudflare_record" "api_domain_a" {
  zone_id = var.zone_id
  name    = "api.${var.base_domain}"
  type    = "A"
  value   = var.kubernetes_ip
  proxied = true
  comment = "Managed by Terraform"
}

resource "cloudflare_record" "future_domain_a" {
  zone_id = var.zone_id
  name    = "future.${var.base_domain}"
  type    = "A"
  value   = var.kubernetes_ip
  proxied = true
  comment = "Managed by Terraform"
}

resource "cloudflare_record" "data_domain_a" {
  zone_id = var.zone_id
  name    = "data.${var.base_domain}"
  type    = "A"
  value   = var.kubernetes_ip
  proxied = true
  comment = "Managed by Terraform"
}
