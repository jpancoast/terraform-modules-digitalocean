
data "digitalocean_images" "ubuntu_lts" {
  filter {
    key    = "distribution"
    values = ["Ubuntu"]
  }
  #  filter {
  #    key    = "type"
  #    values = ["distribution"]
  #  }
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

data "digitalocean_project" "tailscale" {
  name = var.project_name
}
