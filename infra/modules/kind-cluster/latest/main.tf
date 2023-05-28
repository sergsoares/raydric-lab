terraform {
  required_providers {
    kind = {
      source = "tehcyx/kind"
      version = "0.0.17"
    }
  }
}

provider "kind" {}

variable "name" {
  default = "raydric-cluster"
}

resource "kind_cluster" "default" {
  name           = var.name
  wait_for_ready = true

  kind_config {
      kind        = "Cluster"
      api_version = "kind.x-k8s.io/v1alpha4"

      #https://kind.sigs.k8s.io/docs/user/configuration/#api-server
      networking {
        api_server_address = "0.0.0.0" # Allow connections outside the host.
        api_server_port = 6443 # Fix ApiServerPort
      }
      
      node {
          role = "control-plane"

          kubeadm_config_patches = [
              "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
          ]

          extra_port_mappings {
              container_port = 80
              host_port      = 80
          }

          extra_port_mappings {
              container_port = 443
              host_port      = 443
          }
      }
  }
}