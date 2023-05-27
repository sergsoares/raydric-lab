terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host     = "ssh://${var.ssh_user}@${ssh_host}:${ssh_port}"
  ssh_opts = ["-o", "StrictHostKeyChecking=no"]
}

variable "k0s_image" {
  default = "k0sproject/k0s:v1.24.14-k0s.0@sha256:cee720b360ca40091c2ab8461136b480c88f1dd51618ace00fbf7eaa6c29d47f"
}

resource "docker_volume" "shared_volume" {
  name = "k0s"
}

resource "docker_container" "cluster" {
  name = "k0s"
  hostname = "k0s"
  image = var.k0s_image

  volumes {
   volume_name = docker_volume.shared_volume.name
   container_path = "/var/lib/k0s"
  }

  ports {
    internal = 80
    external = 80
  }
  
  ports {
    internal = 6443
    external = 6443
  }

  privileged = true
}