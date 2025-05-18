
locals {
  droplet_name    = format("%s-%s", var.droplet_name, var.droplet_region)
  do_ssh_key_name = format("%s-%s", var.droplet_name, var.droplet_region)
}
