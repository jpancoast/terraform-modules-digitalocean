
variable "droplet_region" {
  type = string
}

variable "droplet_size" {
  type = string
}

variable "public_key_location" {
  type = string
}

variable "project_environment" {
  type = string
}

variable "project_name" {
  type = string
}

variable "project_description" {
  type = string
}

variable "project_purpose" {
  type = string
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
