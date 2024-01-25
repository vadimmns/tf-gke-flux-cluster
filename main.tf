module "gke_cluster" {
  source           = "github.com/vadimmns/google-gke-cluster"
  GOOGLE_REGION    = var.GOOGLE_REGION
  GOOGLE_PROJECT   = var.GOOGLE_PROJECT
  GKE_NUM_NODES    = 2
  GKE_CLUSTER_NAME = var.GKE_CLUSTER_NAME
  GKE_POOL_NAME    = var.GKE_POOL_NAME
}

resource "null_resource" "gke-get-credential" {
  depends_on = [module.gke_cluster]
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.GKE_CLUSTER_NAME} --zone ${var.GOOGLE_REGION} --project ${var.GOOGLE_PROJECT}"
  }
}

module "github_repository" {
  source                   = "github.com/den-vasyliev/tf-github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  repository_visibility    = var.repository_visibility
  public_key_openssh_title = "flux"
}

module "tls_private_key" {
  source = "github.com/den-vasyliev/tf-hashicorp-tls-keys"
}

resource "flux_bootstrap_git" "this" {
  path       = var.target_path
  depends_on = [module.github_repository, module.gke_cluster, module.tls_private_key, null_resource.gke-get-credential]
}

