
provider "tailscale" {
  api_key = var.tailscale_api_token
  tailnet = var.tailscale_tailnet
}
