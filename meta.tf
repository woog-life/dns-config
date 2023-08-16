# Put all records for organizational services (not meant for customers) in here

resource "cloudflare_record" "youtrack_domain" {
  zone_id = var.zone_id
  name    = "jira.${var.base_domain}"
  type    = "CNAME"
  value   = var.youtrack_domain
  proxied = false
  comment = "Managed by Terraform"
}

resource "cloudflare_record" "github_challenge" {
  zone_id = var.zone_id
  name    = "_github-challenge-woog-life.${var.base_domain}"
  type    = "TXT"
  value   = "3ffc4de610"
  proxied = false
  comment = "Managed by Terraform"
}
