variable "project" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "asia-northeast1"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "asia-northeast1-a"
}

variable "public_ssh_key_path" {
  description = "Path to your public SSH key"
  type        = string
  default     = "ssh/id_rsa.pub"
}
