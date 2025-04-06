terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc7"
    }
  }
}

# provider "proxmox" {
#   pm_api_url          = "https://192.168.127.101:8006/api2/json"
#   pm_api_token_id     = "hades@pve!terraform_id"
#   pm_api_token_secret = "adcfb047-4bd0-4638-ab11-caa83091ac38"
#   pm_tls_insecure     = true
# }

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url           # e.g., "https://your-proxmox-host:8006/api2/json"
  pm_api_token_id     = var.proxmox_api_token_id      # e.g., "user@pve!token-name"
  pm_api_token_secret = var.proxmox_api_token_secret  # Your API token secret
  pm_tls_insecure     = true                          # Set to true if using self-signed certificates
}