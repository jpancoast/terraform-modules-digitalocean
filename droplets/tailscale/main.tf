
resource "digitalocean_project" "tailscale" {
  name        = var.project_name
  description = var.project_description
  purpose     = var.project_purpose
  environment = var.project_environment
}

#resource "digitalocean_ssh_key" "tailscale" {
#  name       = local.do_ssh_key_name
#  public_key = file(var.public_key_location)
#}

resource "digitalocean_droplet" "tailscale" {
  image  = data.digitalocean_image.ubuntu.slug
  name   = local.droplet_name
  region = var.droplet_region
  size   = var.droplet_size
  #  ssh_keys          = [digitalocean_ssh_key.tailscale.fingerprint]
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
    tailscale up --advertise-exit-node --auth-key=${data.local_file.tailscale_key.content}
    tailscale set --ssh
  EOF
}

resource "digitalocean_project_resources" "tailscale" {
  project = digitalocean_project.tailscale.id
  resources = [
    digitalocean_droplet.tailscale.urn
  ]
}

# Make the shell script executable
resource "null_resource" "make_script_executable" {
  provisioner "local-exec" {
    command = "chmod +x ${path.module}/gen_tailscale_auth_key.sh"
  }
}

# Generate Tailscale API key
resource "null_resource" "generate_tailscale_key" {
  depends_on = [null_resource.make_script_executable]

  provisioner "local-exec" {
    command = "${path.module}/en_tailscale_auth_key.sh | jq .'key' | tr -d '\"'"
  }

  # Store the output in a local file
  provisioner "local-exec" {
    command = "${path.module}/gen_tailscale_auth_key.sh | jq .'key' | tr -d '\"' > /tmp/tailscale_key.txt"
  }
}
