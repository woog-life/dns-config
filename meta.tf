# Put all records for organizational services (not meant for customers) in here

resource "cloudflare_record" "github_challenge" {
  zone_id = var.zone_id
  name    = "_github-challenge-woog-life.${var.base_domain}"
  type    = "TXT"
  content = "3ffc4de610"
  proxied = false
  comment = "Managed by Terraform"
}
