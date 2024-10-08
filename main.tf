terraform {
  required_version = "1.7.4"

  backend "gcs" {
    bucket = "bjoernpetersen-terraform-state"
    prefix = "woog-dns-config"
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.40.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.2.0"
    }
    google = {
      version = "~> 6.0.0"
    }
  }
}

provider "cloudflare" {}

variable "base_domain" {
  type    = string
  default = "woog.life"
}

variable "zone_id" {
  type    = string
  default = "8055e836af458509652d2e6ded7765bd"
}

variable "kubernetes_ip" {
  type = string
}

