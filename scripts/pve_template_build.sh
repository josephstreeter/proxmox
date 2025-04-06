#! /bin/bash
# https://github.com/UntouchedWagons/Ubuntu-CloudInit-Docs/tree/main

IMAGE=jammy-server-cloudimg-amd64-disk-kvm.img
TEMPLATE="ubuntu-2404-template"
STORAGE=local-zfs
BALLOON=4096
MEMORY=2048
VMID=9001
password="iw2slep!"
USERNAME="hades"

pushd /var/lib/vz/template/iso/ || exit

#qemu-img resize $IMAGE +10G || { echo "Failed to resize image"; exit 1; }

echo "############################################"
echo "Creating template $TEMPLATE with VMID $VMID"
echo "###########################################"

qm create $VMID \
    --name $TEMPLATE \
    --ostype l26 \
    --memory $MEMORY \
    --balloon $BALLOON \
    --agent 1 \
    --machine q35 \
    --cpu host \
    --socket 1 \
    --cores 2 \
    --vga serial0 \
    --serial0 socket  \
    --net0 virtio,bridge=vmbr0 || { echo "Failed to import disk"; exit 1; }
    #--efidisk0 $STORAGE:0,pre-enrolled-keys=0 \
    #--bios ovmf \
    # --scsi0 $STORAGE:vm-$VMID-disk-0,discard=on \

echo "###################################"
echo "Importing disk $IMAGE to VMID $VMID"
echo "###################################"

qm importdisk $VMID $IMAGE $STORAGE || { echo "Failed to import disk"; exit 1; }

echo "################"
echo "Setting up $VMID"
echo "################"

qm set $VMID --scsihw virtio-scsi-pci --scsi0 $STORAGE:vm-$VMID-disk-0
qm set $VMID --boot order=scsi0
qm set $VMID --scsi1 $STORAGE:cloudinit
qm set $VMID --ide2 $STORAGE:cloudinit --description "Ubuntu 24.04 CloudInit Template"

cat << EOF | tee /var/lib/vz/snippets/vendor.yaml
#cloud-config
runcmd:
    - apt update
    - apt install -y qemu-guest-agent
    - systemctl start qemu-guest-agent
    - reboot
# Taken from https://forum.proxmox.com/threads/combining-custom-cloud-init-with-auto-generated.59008/page-3#post-428772
EOF

echo ""
echo "Setting up cloud-init"
echo ""

qm set $VMID --cicustom "vendor=local:snippets/vendor.yaml"
qm set $VMID --tags ubuntu-template,24.04,cloudinit
qm set $VMID --ciuser $USERNAME
qm set $VMID --cipassword $password #$(openssl passwd -6 $CLEARTEXT_PASSWORD)
qm set $VMID --sshkeys ~/.ssh/authorized_keys
qm set $VMID --ipconfig0 ip=dhcp

popd || exit
