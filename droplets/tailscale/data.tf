
data "digitalocean_image" "ubuntu" {
  slug = "ubuntu-24-10-x64"
}

data "digitalocean_regions" "available" {
  filter {
    key    = "available"
    values = ["true"]
  }
}

data "local_file" "tailscale_key" {
  depends_on = [null_resource.generate_tailscale_key]
  filename   = "/tmp/tailscale_key.txt"
}
