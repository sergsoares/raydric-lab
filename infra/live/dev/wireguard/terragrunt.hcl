terraform {
  source = "../../../modules/ansible-playbook/latest"
}
inputs = {
  ansible_host = "wireguard.sergsoares.com"
  ansible_user = "ubuntu"
  ansible_ssh_private_key_file = "~/.ssh/id_rsa"
}