# Proxmox Terraform

This document will cover the use of Terraform to clone VMs in Proxmox.

## Authentication

1. Create user for terraform to use for authentication.
2. Assign the permissions required by the user.
3. Create API token:
    - User: Select the user to be associated with the API token.
    - Token ID: Create a name for the token.
    - Privilege Separation: Uncheck to allow the API token to have the same permissions as the user.
4. Copy the API token secret.
