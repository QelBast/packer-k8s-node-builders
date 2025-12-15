packer {
  required_plugins {
    hyperv = {
      source  = "github.com/hashicorp/hyperv"
      version = " >= 1.1.5"
    }
  }
}

locals {
  vm_ip = "null"
}
######################################
# 1) PRE-BUILD STEP: render template #
######################################
#build {
#  name = "prepare_http"
#  sources = [
#    
#  ]
#  provisioner "shell-local" {#
#    inline = [
#      "echo '${replace(templatefile("../http/user-data.tmpl", { "ssh_pubkey" = var.ssh_pubkey }))}' > ../http/user-data"
#    ]
#  }
#}
#source "null" "get-ip" {
#  communicator = "none"
#}
#build {
#  name = "prepare_host"
#  sources = ["sources.null.get-ip"]
#  provisioner "shell-local" {
#    inline = [
#      vm_ip = trimspace("Get-VMNetworkAdapter -VMName <name> | select -ExpandProperty IPAddresses | Select -First 1"),
#    ]
#  }
#}

###########################
# 2) VM BUILD (HYPER-V)   #
###########################
source "hyperv-iso" "ubuntu" {
  iso_url             = "https://releases.ubuntu.com/24.04/ubuntu-24.04.3-live-server-amd64.iso"
  iso_checksum        = "none"#"https://dl-cdn.alpinelinux.org/alpine/v3.22/releases/x86_64/alpine-standard-3.22.2-x86_64.iso.sha256"
  generation          = 2

  communicator        = "ssh"

  mac_address = var.mac
  ssh_username        = "qelb"
  ssh_password = "root"
  ssh_private_key_file = var.ssh_privkey_path
  ssh_timeout       = "45m"
  guest_additions_mode = "disable"
  enable_secure_boot = false
  cpus                = var.packer_cpus
  memory              = var.packer_memory
  disk_size           = var.packer_disk

  switch_name         = var.hyperv_switch

  boot_wait           = "5s"
  http_directory      = "../http"
  vm_name             = var.hostname
  output_directory = "${var.vhd_dir}/${var.hostname}"

  boot_command = [
    "<esc><wait>",
    "<esc><wait>",
    "c<wait>",
    "linux /casper/vmlinuz quiet autoinstall 'ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/' ---<enter>",
    "initrd /casper/initrd<enter>",
    "boot<enter>",
  ]

  shutdown_command = "sudo shutdown -P now"
}

build {
  name = "ubuntu-universal-image"
  sources = [
    "source.hyperv-iso.ubuntu"
  ]
  
  post-processors {
    post-processor "manifest" {
      output = "packer-manifest.json"
    }
  }
}