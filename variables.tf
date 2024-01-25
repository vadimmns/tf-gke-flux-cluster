variable "GOOGLE_PROJECT" {
  type        = string
  default = "flux-sdrvstudent"
  description = "GCP project to use"
}

variable "GOOGLE_REGION" {
  type        = string
  default     = "us-central1-c"
  description = "GCP region to use"
}

variable "GITHUB_OWNER" {
  type        = string
  default     = "vadimmns"
  description = "GitHub owner repository to use"
}

variable "GITHUB_TOKEN" {
  type        = string
  description = "GitHub personal access token"
}

variable "FLUX_GITHUB_REPO" {
  type        = string
  default     = "flux-gitops"
  description = "Flux GitOps repository"
}

variable "FLUX_GITHUB_TARGET_PATH" {
  type        = string
  default     = "clusters"
  description = "Flux manifests subdirectory"
}

variable "GKE_MACHINE_TYPE" {
  type        = string
  default     = "g1-small"
  description = "machine type"
}

variable "GKE_CLUSTER_NAME" {
  type        = string
  default     = "flux"
  description = "GKE cluster name"
}

variable "GKE_POOL_NAME" {
  type        = string
  default     = "flux"
  description = "GKE pool name"
}

variable "target_path" {
  type        = string
  default     = "clusters"
  description = "Flux manifests subdirectory"
}

variable "repository_visibility" {
  type        = string
  default     = "private"
  description = "The visibility of the GitOps repository"
}

