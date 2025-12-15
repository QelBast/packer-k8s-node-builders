variable "iso_dir" {
  type        = string
  description = "Path to ISO directory"
}

variable "vhd_dir" {
  type        = string
  description = "Directory for storing VHDXs"
}

variable "hyperv_switch" {
  type        = string
  description = "Virtual switch"
  default     = "Default Switch"
}

variable "output_vhd_name" {
  type        = string
  description = "Default vhdx filename"
  default     = "universal.vhdx"
}

variable "role" {
  type        = string
  default     = "worker"
}

variable "hostname" {
  type        = string
  default     = "nixos-golden"
}

variable "mac" {
  type        = string
  default     = "00:15:5D:81:01:01"
}

variable "ssh_pubkey" {
  type        = string
  description = "Public SSH key"
  default     = "keys/id_ed25519.pub"
}

variable "ssh_privkey_path" {
  type        = string
  description = "Relative path to private SSH key (inside packer dir), e.g. keys/id_ed25519"
  default     = "keys/id_ed25519"
}

variable "new_root_pass" {
  type        = string
  description = "New root user password after installation"
}

variable "packer_cpus" {
  type        = number
  description = "CPUs alloc"
  default     = 4
}

variable "packer_memory" {
  type        = number
  description = "RAM alloc"
  default     = 4096
}

variable "packer_disk" {
  type        = number
  description = "ROM alloc"
  default     = 32768
}
