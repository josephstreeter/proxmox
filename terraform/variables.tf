variable "proxmox_api_url" {
  type        = string
  description = "URL of the Proxmox API"
}

variable "proxmox_api_token_id" {
  type        = string
  description = "Proxmox API token ID"
  sensitive   = true
}

variable "proxmox_api_token_secret" {
  type        = string
  description = "Proxmox API token secret"
  sensitive   = true
}

variable "proxmox_host" {
  type        = string
  default     = "pve"  # Replace with your Proxmox node name
  description = "Target Proxmox node for VM deployment"
}

variable "template_name" {
  type        = string
  default     = "ubuntu-2404-cloudinit-template"  # Replace with your Ubuntu 24.04 template name
  description = "Name of the Ubuntu 24.04 cloud-init template"
}

variable "ssh_key" {
  type        = string
  description = "SSH public key for VM access"
  #default     = "ssh-rsa YOUR_SSH_PUBLIC_KEY_HERE"
}

variable "ciuser" {
  type        = string
  description = "Local user for cloud-init configuration"
  default     = "ubuntu"  # Replace with your desired username
}

variable "password" {
  type        = string
  description = "local user password for VM access"
}

variable "storage" {
  type        = string
  default     = "local-zfs"
  description = "Name of the Proxmox storage for VM disks"
}