
# SSH over Tailscale by node name (Tailscale SSH is enabled on the droplet).
output "tailscale_ssh_command" {
  value = "tailscale ssh ${var.ssh_user}@${local.droplet_name}"
}

# Delete this node from the tailnet (e.g. the stale entry left after replacing
# the droplet). The `tailscale` CLI can only log out the local node, so removing
# a remote/orphaned node is done via the API. Requires a Tailscale API token
# exported as $TAILSCALE_API_TOKEN and `jq` installed.
output "remove_tailscale_node_command" {
  value = <<-EOT
    curl -s -u "$TAILSCALE_API_TOKEN:" https://api.tailscale.com/api/v2/tailnet/-/devices | jq -r '.devices[] | select(.hostname=="${local.droplet_name}") | .id' | xargs -r -I{} curl -s -u "$TAILSCALE_API_TOKEN:" -X DELETE https://api.tailscale.com/api/v2/device/{}
  EOT
}

output "digitalocean_droplet_tailscale" {
  value = digitalocean_droplet.tailscale.id
}

output "digitalocean_project_resources_tailscale" {
  value = digitalocean_project_resources.tailscale.id
}
