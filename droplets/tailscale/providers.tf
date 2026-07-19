
provider "tailscale" {
  api_key = var.tailscale_api_token
  # "-" resolves to the default tailnet of the authenticated API key. The API
  # identifies a tailnet by org name, not the MagicDNS name (tailXXXX.ts.net).
  tailnet = "-"
}
