resource "cloudflare_record" "fastmail_mx1" {
  zone_id  = var.zone_id
  name     = "@"
  type     = "MX"
  value    = "in1-smtp.messagingengine.com"
  priority = 10
  proxied  = false
  comment  = "Managed by Terraform"
}

resource "cloudflare_record" "fastmail_mx2" {
  zone_id  = var.zone_id
  name     = "@"
  type     = "MX"
  value    = "in2-smtp.messagingengine.com"
  priority = 20
  proxied  = false
  comment  = "Managed by Terraform"
}

resource "cloudflare_record" "fastmail_dkim1" {
  zone_id = var.zone_id
  name    = "fm1._domainkey.${var.base_domain}"
  type    = "CNAME"
  value   = "fm1.${var.base_domain}.dkim.fmhosted.com"
  proxied = false
  comment = "Managed by Terraform"
}

resource "cloudflare_record" "fastmail_dkim2" {
  zone_id = var.zone_id
  name    = "fm2._domainkey.${var.base_domain}"
  type    = "CNAME"
  value   = "fm2.${var.base_domain}.dkim.fmhosted.com"
  proxied = false
  comment = "Managed by Terraform"
}

resource "cloudflare_record" "fastmail_dkim3" {
  zone_id = var.zone_id
  name    = "fm3._domainkey.${var.base_domain}"
  type    = "CNAME"
  value   = "fm3.${var.base_domain}.dkim.fmhosted.com"
  proxied = false
  comment = "Managed by Terraform"
}

resource "cloudflare_record" "fastmail_spf" {
  zone_id = var.zone_id
  name    = "@"
  type    = "TXT"
  value   = "v=spf1 include:spf.messagingengine.com ?all"
  proxied = false
  comment = "Managed by Terraform"
}
