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

# GitHub secrets

data "github_repository" "terraform_repo" {
  name = "dns-config"
}

resource "github_actions_secret" "google" {
  repository      = data.github_repository.terraform_repo.name
  secret_name     = "GOOGLE_SA_JSON"
  plaintext_value = base64decode(google_service_account_key.github_actions.private_key)
}
