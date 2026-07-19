
resource "digitalocean_ssh_key" "tailscale" {
  name       = local.do_ssh_key_name
  public_key = file(var.public_key_location)
}

resource "digitalocean_droplet" "tailscale" {
  image             = var.droplet_image
  name              = local.droplet_name
  region            = var.droplet_region
  size              = var.droplet_size
  ssh_keys          = [digitalocean_ssh_key.tailscale.fingerprint]
  graceful_shutdown = var.graceful_shutdown

  user_data = <<-EOF
    #!/bin/bash
    export DEBIAN_FRONTEND=noninteractive
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
    apt update
    sleep 5
    echo Running Upgrade!
    DEBIAN_FRONTEND=noninteractive apt upgrade -y
    sleep 5
    apt install tailscale -y
    sleep 5
    apt update
    DEBIAN_FRONTEND=noninteractive apt upgrade -y
    echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.conf
    echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.conf
    sysctl -p /etc/sysctl.conf
    NETDEV=$(ip -o route get 8.8.8.8 | cut -f 5 -d " ")
    sudo ethtool -K $NETDEV rx-udp-gro-forwarding on rx-gro-list off
    tailscale up --advertise-exit-node --auth-key=${tailscale_tailnet_key.tailscale.key}
    tailscale set --ssh
  EOF
}

resource "digitalocean_project_resources" "tailscale" {
  project = data.digitalocean_project.tailscale.id

  resources = [
    digitalocean_droplet.tailscale.urn
  ]
}

# Generate a Tailscale auth key used by the droplet to join the tailnet on boot.
resource "tailscale_tailnet_key" "tailscale" {
  reusable      = false
  ephemeral     = false
  preauthorized = true
  # Must still be valid when the droplet finishes its apt upgrade/install and
  # first runs `tailscale up` (several minutes after this key is created), so
  # give it a wide margin. 1 hour.
  expiry      = 3600
  description = "auth key for ${local.droplet_name} exit node"
}
