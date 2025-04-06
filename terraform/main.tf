resource "proxmox_vm_qemu" "k8s_nodes" {
  count       = 3
  name        = "k8s-node-${count.index + 1}"
  target_node = var.proxmox_host
  os_type     = "cloud-init"
  clone       = var.template_name
  full_clone  = true
  vmid        = 200 + count.index + 1
  cores       = 2
  sockets     = 1
  memory      = 4096
  scsihw      = "virtio-scsi-pci"
  boot        = "order=scsi0"
  hotplug     = "disk,network,usb" # Enable hotplug for network, disk, and USB devices

  disk {
    size     = "20G"
    type     = "disk"
    slot     = "scsi1"
    storage  = var.storage
    iothread = false
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0" # Replace with your network bridge
  }

  ciuser     = var.ciuser
  cipassword = var.password
  sshkeys    = var.ssh_key
  ipconfig0  = "ip=192.168.127.20${count.index + 1}/24,gw=192.168.127.1" # IPs: 192.168.1.101, 102, 103
  onboot     = true                                                      # Ensure the VM starts on boot
  agent      = 1                                                         # QEMU agent for better VM management
}
