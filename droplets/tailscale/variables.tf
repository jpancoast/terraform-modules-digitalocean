
variable "droplet_region" {
  type = string
}

variable "droplet_size" {
  type = string
}

variable "public_key_location" {
  type = string
}

variable "project_name" {
  type        = string
  description = "Name of the existing DigitalOcean project (created by the do-projects stack) to attach the droplet to."
}

variable "droplet_name" {
  type    = string
  default = "tailscale"
}

variable "ssh_user" {
  type    = string
  default = "root"
}

variable "graceful_shutdown" {
  type    = bool
  default = true
}

variable "tailscale_api_token" {
  type        = string
  description = "The Tailscale API token"
  sensitive   = true
}
