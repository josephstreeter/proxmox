output "k8s_node_ips" {
  value = proxmox_vm_qemu.k8s_nodes[*].ipconfig0
  description = "IP addresses assigned to the K8s nodes"
}