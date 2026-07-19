
variable "droplet_region" {
  type = string
}

variable "droplet_size" {
  type = string
}

variable "droplet_image" {
  type        = string
  default     = "ubuntu-24-04-x64"
  description = "DigitalOcean image slug for the droplet. Defaults to the Ubuntu 24.04 LTS base OS image."
}

variable "public_key_location" {
  type = string
}

variable "ssh_private_key_location" {
  type        = string
  default     = "/Users/jpancoast/.ssh/droplet"
  description = "Local path to the private SSH key, used to build the ssh_command output."
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
