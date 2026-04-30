variable "do_token" {
    description = "Day la token cua dung de truy cap vao DigitalOcean API"
}

variable "ssh_key" {
    description = "Day la khoa SSH de truy cap vao may chu"
}

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.84.1"
    }
  }
}

provider "digitalocean" {
  # Configuration options
  token = var.do_token
}

# Create a new Web Droplet in the nyc2 region
resource "digitalocean_droplet" "setup" {
  image   = "ubuntu-24-04-x64"
  name    = "terraform-vps"
  region  = "sgp1"
  size    = "s-2vcpu-4gb"
  ssh_keys = [var.ssh_key]
}

output "output_name" {
    value = {
        ipVps = digitalocean_droplet.setup.ipv4_address
    }
}