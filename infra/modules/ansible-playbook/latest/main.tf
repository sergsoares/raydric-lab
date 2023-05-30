variable "ansible_host" {
  default = ""
}

variable "ansible_ssh_private_key_file" {
  type = string
  default = "~/.ssh/id_rsa"
}

variable "ansible_user" {
  default = "ubuntu"
}

variable "playbook" {
  default = "./playbook.yml"
}


resource "null_resource" "ansible" {
  # https://ilhicas.com/2019/08/17/Terraform-local-exec-run-always.html
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.ansible_host}, ${var.playbook} --extra-vars 'ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.ansible_ssh_private_key_file}'"
  }
}
