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
      version = "~> 2.0"
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

variable "proxy_records" {
  type    = bool
}

variable "base_domain" {
  type    = string
  default = "woog.life"
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
  proxied = var.proxy_records
}

variable "kubernetes_ip" {
  type = string
}

resource "cloudflare_record" "base_domain_a" {
  zone_id = var.zone_id
  name    = var.base_domain
  type    = "A"
  value   = var.kubernetes_ip
  proxied = var.proxy_records
}

resource "cloudflare_record" "api_domain_a" {
  zone_id = var.zone_id
  name    = "api.${var.base_domain}"
  type    = "A"
  value   = var.kubernetes_ip
  proxied = var.proxy_records
}
