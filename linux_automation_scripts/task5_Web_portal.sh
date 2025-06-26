#!/bin/bash
set -e
#######  Internal Web Portal #######
#### 1-Install httpd
dnf install -y httpd -y 
systemctl enable --now httpd

#### 2-Make small website

# Copy website files from shared folder (adjust the path if needed)
cp -r /mnt/hgfs/website/* /var/www/html/website/

#### 3-Fix SELinux context
semanage fcontext -a -t httpd_sys_content_t "/var/www/html/website(/.*)?"
restorecon -Rv /var/www/html/website

#### 4-Restart the service
systemctl restart httpd

#### 5-Add second ip 
ip addr add 192.168.100.10/24 dev ens160
systemctl restart  NetworkManager
