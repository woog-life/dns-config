terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "BjoernPetersen"

    workspaces {
      name = "woog-dns-config"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

variable "cloudflare_token" {
  type      = string
  sensitive = true
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

variable "base_domain" {
  type    = string
  default = "woog.life"
}

variable "youtrack_domain" {
  type    = string
  default = "wooglife.myjetbrains.com"
}

variable "zone_id" {
  type    = string
  default = "8055e836af458509652d2e6ded7765bd"
}

resource "cloudflare_record" "www_cname" {
  zone_id = var.zone_id
  name    = "www"
  type    = "CNAME"
  value   = var.base_domain
  proxied = true
}

variable "kubernetes_ip" {
  type = string
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
