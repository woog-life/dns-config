terraform {
  required_version = "1.7.4"

  backend "gcs" {
    bucket = "bjoernpetersen-terraform-state"
    prefix = "woog-dns-config"
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
    google = {
      version = "~> 5.14.0"
    }
  }
}

provider "cloudflare" {}

provider "github" {
  owner = "woog-life"
}

provider "google" {
  project = "personal-bjoernpetersen"
  region  = "europe-west3"
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

variable "kubernetes_ip" {
  type = string
}

