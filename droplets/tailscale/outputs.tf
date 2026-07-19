
# Direct SSH over the public IP, using the local private key.
output "ssh_command" {
  value = "ssh -o IdentitiesOnly=yes -i ${var.ssh_private_key_location} ${var.ssh_user}@${digitalocean_droplet.tailscale.ipv4_address}"
}

# SSH over Tailscale by node name (Tailscale SSH is enabled on the droplet).
output "tailscale_ssh_command" {
  value = "tailscale ssh ${var.ssh_user}@${local.droplet_name}"
}

output "digitalocean_droplet_tailscale" {
  value = digitalocean_droplet.tailscale.id
}

output "digitalocean_project_resources_tailscale" {
  value = digitalocean_project_resources.tailscale.id
}
