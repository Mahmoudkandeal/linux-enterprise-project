#!/bin/bash
##### Security Hardening #####

## 1-Conf sudo access 
touch /etc/sudoers.d/frank 
echo "frank ALL=(ALL) NOPASSWD:\
/usr/sbin/useradd, \
/usr/sbin/userdel,\
/usr/sbin/usermod, \
/usr/bin/yum, \
/usr/bin/dnf" > /etc/sudoers.d/frank
chmod 440 /etc/sudoers.d/frank

## 2-Conf SSH access 
echo "AllowGroups it_team" >> /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
systemctl restart sshd.service

## 3-Apply SELinux 
mkdir -p /var/www/html/intranet
semanage fcontext -a -t httpd_sys_content_t "/var/www/html/intranet(/.*)?" 

## 4-Conf firewall
firewall-cmd --add-service=ssh --permanent 
firewall-cmd  --add-service=http --permanent
firewall-cmd --permanent --remove-icmp-block=echo-request
firewall-cmd --reload
