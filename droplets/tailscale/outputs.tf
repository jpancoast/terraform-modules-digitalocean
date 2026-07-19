
# Direct SSH over the public IP, using the private key that pairs with
# public_key_location (same path with the .pub suffix stripped).
output "ssh_command" {
  value = "ssh -o IdentitiesOnly=yes -i ${replace(var.public_key_location, ".pub", "")} ${var.ssh_user}@${digitalocean_droplet.tailscale.ipv4_address}"
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
