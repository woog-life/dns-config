# GCP access

resource "google_project_service" "services" {
  for_each = toset([
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    "storage.googleapis.com",
  ])
  service = each.key
}

resource "google_service_account" "github_actions_access" {
  account_id   = "github-actions-ci-woog-dns"
  display_name = "GitHub Actions"
}

resource "google_project_iam_member" "github_actions_roles" {
  for_each = toset([
    "roles/iam.securityReviewer",
    "roles/iam.serviceAccountViewer",
    "roles/storage.objectAdmin",
  ])
  project = google_service_account.github_actions_access.project
  role    = each.key
  member  = google_service_account.github_actions_access.member
}

resource "google_service_account_key" "github_actions" {
  service_account_id = google_service_account.github_actions_access.account_id
}

# Cloudflare access

data "cloudflare_api_token_permission_groups" "all" {}

resource "cloudflare_api_token" "github_actions" {
  name = "GitHub Actions woog-dns"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.zone["DNS Write"],
      data.cloudflare_api_token_permission_groups.all.zone["Zone Read"],
      data.cloudflare_api_token_permission_groups.all.user["API Tokens Read"],
    ]
    resources = {
      "com.cloudflare.api.account.zone.${var.zone_id}" = "*",
      "com.cloudflare.api.user.a2f5f7a2a192da0c6afa7efe597d7a8d" : "*"
    }
  }
}

# GitHub secrets

data "github_repository" "terraform_repo" {
  name = "dns-config"
}

resource "github_actions_secret" "google" {
  repository      = data.github_repository.terraform_repo.name
  secret_name     = "GOOGLE_SA_JSON"
  plaintext_value = base64decode(google_service_account_key.github_actions.private_key)
}

resource "github_actions_secret" "cloudflare" {
  repository      = data.github_repository.terraform_repo.name
  secret_name     = "CLOUDFLARE_TOKEN"
  plaintext_value = cloudflare_api_token.github_actions.value
}
