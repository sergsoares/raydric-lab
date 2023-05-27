terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

variable "k3s_image" {
  default = "rancher/k3s:v1.24.10-k3s1"
}

resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    cluster_instance_ids = "k3s"
  }


  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "sudo docker run --privileged --name k3s-server-1 --hostname k3s-server-1 -p 6443:6443 -d rancher/k3s:v1.24.10-k3s1 server",
    ]
    
    connection {
      type = "ssh"
      user = "ubuntu"
      # private_key = file("/Users/sergsoares-personal/.ssh/id_rsa")
      agent = true
      host = "HOST"
      timeout = "20s"
    }
  }
}

# resource "docker_volume" "shared_volume" {
#   name = "k3s"
# }

# resource "docker_container" "cluster" {
#   name = "k3s"
#   hostname = "k3s"
#   image = var.k3s_image
#   command = ["server"]
#   privileged = true

#   # volumes {
#   #  volume_name = docker_volume.shared_volume.name
#   #  container_path = "/var/lib/k3s"
#   # }

#   ports {
#     internal = 80
#     external = 80
#   }
  
#   ports {
#     internal = 443
#     external = 443
#   }

#   ports {
#     internal = 6443
#     external = 6443
#   }
  
#   # lifecycle {
#   #   prevent_destroy = true
#   # }
# }

# # output "name" {
# #   value = docker_container.cluster