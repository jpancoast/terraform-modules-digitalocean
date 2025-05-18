
output "start_tailscale" {
  value = "ssh -o IdentitiesOnly=yes -i ${var.private_key_location} ${var.ssh_user}@${digitalocean_droplet.tailscale.ipv4_address}"
}
