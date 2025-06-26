#!/bin/bash
set -e  # Exit immediately if any command fails

######## Storage & LVM Setup

## 1. Create the necessary mount directories
mkdir -p /srv/dev /srv/hr /srv/it /srv/sales

## 2. Create Physical Volume (PV), Volume Group (VG), and Logical Volumes (LVs)
pvcreate /dev/sda
vgcreate -ff vg_deptdata /dev/sda
lvcreate -n lv_dev -L 1G vg_deptdata
lvcreate -n lv_hr -L 500M vg_deptdata
lvcreate -n lv_it -L 1G vg_deptdata
lvcreate -n lv_sales -L 1G vg_deptdata

## 3. Format each logical volume with XFS filesystem
mkfs.xfs -f /dev/vg_deptdata/lv_dev
mkfs.xfs -f /dev/vg_deptdata/lv_hr
mkfs.xfs -f /dev/vg_deptdata/lv_it
mkfs.xfs -f /dev/vg_deptdata/lv_sales

## 4. Mount each logical volume to its directory
mount /dev/vg_deptdata/lv_dev /srv/dev
mount /dev/vg_deptdata/lv_hr /srv/hr
mount /dev/vg_deptdata/lv_it /srv/it
mount /dev/vg_deptdata/lv_sales /srv/sales

echo "LVM setup completed."

## 5. Add entries to /etc/fstab to make mounts permanent and enable user quota
{
  echo "/dev/vg_deptdata/lv_dev   /srv/dev   xfs   defaults        0 0"
  echo "/dev/vg_deptdata/lv_it    /srv/it    xfs   defaults        0 0"
  echo "/dev/vg_deptdata/lv_hr    /srv/hr    xfs   defaults,uquota 0 2"
  echo "/dev/vg_deptdata/lv_sales /srv/sales xfs   defaults,uquota 0 2"
} >> /etc/fstab

## Remount quota-enabled volumes to apply the changes
umount /srv/hr || true
umount /srv/sales || true
mount /srv/hr
mount /srv/sales

## 1.Create a test file for each user to activate tracking and ownership
touch /srv/hr/bobfile
chown bob:hr_team /srv/hr/bobfile
echo "trigger quota" > /srv/hr/bobfile

touch /srv/sales/davefile
chown dave:sales_team /srv/sales/davefile
echo "trigger quota" > /srv/hr/bobfil

## 2.Enable user quota on both /srv/hr and /srv/sales

quotaon /srv/hr
quotaon /srv/sales

## 3.Set quota limits:
##    - Soft limit: 100MB (102400 KB)
##    - Hard limit: 150MB (153600 KB)
setquota -u bob 102400 153600 0 0 /srv/hr
setquota -u dave 102400 153600 0 0 /srv/sales

