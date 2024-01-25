module "gke-workload-identity" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  use_existing_k8s_sa = true
  name = "kustomize-controller"
  namespace = "flux-system"
  project_id = var.GOOGLE_PROJECT
  cluster_name = var.GKE_CLUSTER_NAME
  location = var.GOOGLE_REGION
  annotate_k8s_sa = true
  roles = ["roles/cloudkms.cryptoKeyEncrypterDecrypter"]
  module_depends_on = [flux_bootstrap_git.this]
}

module "kms" {
  source             = "github.com/den-vasyliev/terraform-google-kms"
  project_id         = var.GOOGLE_PROJECT
  location           = "global"
  keyring            = "sops-flux"
  keys               = ["sops-key-flux"]
  prevent_destroy    =  false
}