terraform {
  source = "../../../modules/ansible-playbook/latest"
}
inputs = {
  //ansible_host = "vps-2c32857a.vps.ovh.ca,vps-b33e7b90.vps.ovh.net,vps-09bfb067.vps.ovh.ca,vps-66db3ad2.vps.ovh.net,vps-76305e27.vps.ovh.net,vps-4feba04a.vps.ovh.ca,vps-36809297.vps.ovh.net,vps-a8fb7297.vps.ovh.ca,vps-ceb9dd93.vps.ovh.ca,vps-d5b71bde.vps.ovh.ca"
  ansible_host = "vps-2c32857a.vps.ovh.ca"
  ansible_user = "ubuntu"
  ansible_ssh_private_key_file = "~/.ssh/id_rsa"
}