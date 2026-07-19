
data "digitalocean_images" "ubuntu_lts" {
  filter {
    key    = "distribution"
    values = ["Ubuntu"]
  }
  # Restrict to base OS distribution images so Marketplace one-click app images
  # (e.g. "WordPress on Ubuntu") are excluded.
  filter {
    key    = "type"
    values = ["distribution"]
  }
  # Keep to LTS releases only (names look like "24.04 (LTS) x64").
  filter {
    key      = "name"
    values   = ["\\(LTS\\) x64$"]
    match_by = "re"
  }
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

data "digitalocean_project" "tailscale" {
  name = var.project_name
}
