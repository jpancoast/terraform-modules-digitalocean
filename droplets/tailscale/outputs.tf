
output "start_tailscale" {
  value = "ssh -o IdentitiesOnly=yes -i <private_key_location> ${var.ssh_user}@${digitalocean_droplet.tailscale.ipv4_address}"
}

output "digitalocean_project_tailscale" {
  value = digitalocean_project.tailscale.id
}

output "digitalocean_droplet_tailscale" {
  value = digitalocean_droplet.tailscale.id
}

output "digitalocean_project_resources_tailscale" {
  value = digitalocean_project_resources.tailscale.id
}
