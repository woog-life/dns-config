resource "cloudflare_record" "www_cname" {
  zone_id = var.zone_id
  name    = "www"
  type    = "CNAME"
  value   = var.base_domain
  proxied = true
}

resource "cloudflare_record" "base_domain_a" {
  zone_id = var.zone_id
  name    = var.base_domain
  type    = "A"
  value   = var.kubernetes_ip
  proxied = true
}

resource "cloudflare_record" "api_domain_a" {
  zone_id = var.zone_id
  name    = "api.${var.base_domain}"
  type    = "A"
  value   = var.kubernetes_ip
  proxied = true
}

resource "cloudflare_record" "vpm_domain_a" {
  zone_id = var.zone_id
  name    = "vpm.${var.base_domain}"
  type    = "A"
  value   = var.kubernetes_ip
  proxied = true
}

resource "cloudflare_record" "next_domain_a" {
  zone_id = var.zone_id
  name    = "next.${var.base_domain}"
  type    = "A"
  value   = var.kubernetes_ip
  proxied = true
}

resource "cloudflare_record" "youtrack_domain" {
  zone_id = var.zone_id
  name    = "jira.${var.base_domain}"
  type    = "CNAME"
  value   = var.youtrack_domain
  proxied = false
}

resource "cloudflare_record" "data_domain_a" {
  zone_id = var.zone_id
  name    = "data.${var.base_domain}"
  type    = "A"
  value   = var.kubernetes_ip
  proxied = true
}

resource "cloudflare_record" "frontend" {
  name    = "xn--gi8h6v.${var.base_domain}"
  type    = "A"
  zone_id = var.zone_id
  value   = var.kubernetes_ip
  proxied = false
}

