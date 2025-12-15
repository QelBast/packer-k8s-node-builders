packer {
  required_plugins {
    hyperv = {
      source  = "github.com/hashicorp/hyperv"
      version = " >= 1.1.5"
    }
  }
}

###########################
# 2) VM BUILD (HYPER-V)   #
###########################
source "hyperv-iso" "ubuntu" {
  iso_url             = "https://releases.ubuntu.com/24.04/ubuntu-24.04.3-live-server-amd64.iso"
  iso_checksum        = "sha256:c3514bf0056180d09376462a7a1b4f213c1d6e8ea67fae5c25099c6fd3d8274b"
  generation          = 2

  communicator        = "ssh"

  mac_address = var.mac
  ssh_username        = var.username
  ssh_password = var.password
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