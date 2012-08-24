#!/bin/sh

echo ===================================
echo == Provisioning the NAS with OMV ==
echo ===================================

mke2fs -F /dev/md0 && \
mkdir -p /tmp/root && \
mount -t ext2 -o noatime /dev/md0 /tmp/root && \
tar -C /tmp/root -xzf /usb_drive/rootimg.tgz && \
dd if=/usb_drive/vmlinuz.uim of=/dev/sda bs=512 seek=1290 && \
dd if=/usb_drive/initrd.uim of=/dev/sda bs=512 seek=16674
umount /tmp/root
/usb_drive/sync
sleep 6
echo "1" > /sys/class/nasled/power_off
