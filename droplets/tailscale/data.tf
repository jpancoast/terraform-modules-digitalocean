
data "digitalocean_images" "ubuntu_lts" {
  filter {
    key    = "distribution"
    values = ["Ubuntu"]
  }
  filter {
    key    = "type"
    values = ["distribution"]
  }
  #  filter {
  #    key      = "name"
  #    values   = ["\\(LTS\\) x64$"]
  #    match_by = "re"
  #  }
  sort {
    key       = "created"
    direction = "desc"
  }
}

data "digitalocean_regions" "available" {
  filter {
    key    = "available"
    values = ["true"]
  }
}

data "local_file" "tailscale_key" {
  depends_on = [null_resource.generate_tailscale_key]
  filename   = "./tailscale_key.txt"
}
