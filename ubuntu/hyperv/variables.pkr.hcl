variable "vhd_dir" {
  type        = string
  description = "Directory for storing VHDXs"
}

variable "hyperv_switch" {
  type        = string
  description = "Virtual switch"
  default     = "Default Switch" # Switch must be External, I think. 
}

variable "output_vhd_name" {
  type        = string
  description = "Default vhdx filename"
  default     = "universal.vhdx"
}

variable "username" {
  type        = string
  default     = "root"
}

variable "username" {
  type        = string
  default     = "123admin!@#"
}

variable "hostname" {
  type        = string
  default     = "ubuntu-golden"
}

variable "mac" {
  type        = string
  default     = "00:15:5D:81:01:01"
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
