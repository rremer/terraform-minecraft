#!/bin/bash
#
# adopt some volumes and expose them as a logical group
#

# the terraform trigger converted the device list to be space-separated
# first assert all these devices have no mounted volumes
for device in ${devices}; do
  umount "${device}"
done

# manage all the physical volumes with lvm
pvcreate -y ${devices}

# create a volume group with all the devices
vgcreate -y "${volume_group_name}" ${devices}

# create a logical volume and use all the space in the volume group
lvcreate --name "${volume_group_name}" --extents 100%FREE "${volume_group_name}"

# format the logical volume
mkfs.${volume_format} "/dev/${volume_group_name}/${volume_group_name}"

# e.g. make /tank and mount /dev/tank/tank to tank
umount "${volume_mount_point}" || true
mkdir -p "${volume_mount_point}"
mount "/dev/${volume_group_name}/${volume_group_name}" "${volume_mount_point}"

# this script is idempotent, assert that the final volume mount exists
mount | grep "${volume_mount_point}" || exit 1
