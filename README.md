# 🐧 Full Enterprise Linux Environment Deployment for Company

Welcome to a complete simulation of deploying and managing a secure Linux infrastructure for a mid-sized enterprise. This project was developed as part of the System Administration track and aims to automate, secure, and validate every step using real-world best practices.

> 👨‍💻 **Author:** Mahmoud Hamed  
> 🎓 **Supervised by:** ENG. Sondos Alsafy  
> 📄 **Track:** ITI – System Administration  
> 📁 **OS Used:** Rocky Linux  

---

## 🔍 Project Overview

This project automates the setup and management of an internal Linux environment using Bash scripting. It includes:

- 👥 Group-based access and user creation
- 🔐 File permissions and ACLs
- 💽 LVM and disk quota configuration
- 🧰 Apache Web Server setup
- 🔒 Security hardening (sudo, SSH, SELinux, firewalld)
- 📜 Automation (cron, at)
- 🧾 Troubleshooting using logs

---

## 📂 Repository Structure
linux-enterprise-project/ \
├── enterprise_setup_scripts/ # All Bash scripts per phase \
├── linux_task_output/ # Screenshots organized by task \
├── Enterprise_Linux_Deployment_Report.pdf \
├── Enterprise_Deployment_Checklist.pdf \
└── README.md 

---

## 📑 Project Phases & Features

### ⚙️ Phase 1: System Preparation & User Environment

- Hostname set to `intranet.technova.local`  
- Static IP: `192.168.153.10/24`  
- User groups: `dev_team`, `hr_team`, `it_team`, `sales_team`  
- Users assigned with secure passwords  
- Force password change on first login  

🖼️ *Screenshot Placeholder:*  
`linux_task_output/task1_Sys_Prep/force_pass_change.png`  
`linux_task_output/task1_Sys_Prep/groups_user_id.png`  
`linux_task_output/task1_Sys_Prep/hostname_static_ip.png`

---

### 🗂️ Phase 2: Directory & Permission Setup

- Created shared folders in `/srv`  
- Set ownership and group permissions (`chmod 2770`)  
- Applied ACLs:  
  - `frank`: full access  
  - `bob`: read-only to sales  
- Set sticky bit on `/srv/public_temp`  

🖼️ *Screenshot Placeholder:*  
`linux_task_output/task2_Dir_Perm_setup/making_Dirs.png`  
`linux_task_output/task2_Dir_Perm_setup/getfacl_dev.png`  
`linux_task_output/task2_Dir_Perm_setup/getfacl_hr.png`  
`linux_task_output/task2_Dir_Perm_setup/getfacl_it.png`  
`linux_task_output/task2_Dir_Perm_setup/getfacl_sales.png`

---

### 💾 Phase 3: LVM & Disk Quotas

- Created PV → VG → 4 LVs using `/dev/sda`  
- Mounted LVs to `/srv/DEPT`  
- Formatted with XFS and added to `/etc/fstab`  
- Applied disk quotas (100 MB soft / 150 MB hard) to HR & Sales  

🖼️ *Screenshot Placeholder:*  
`linux_task_output/task3_Storage_LVM_setup/pvs_vgs_lvs.png`  
`linux_task_output/task3_Storage_LVM_setup/show_mount.png`  
`linux_task_output/task3_Storage_LVM_setup/fstab_file.png`  
`linux_task_output/task3_Storage_LVM_setup/set_quota.png`

---

### 🛡️ Phase 4: Security Hardening

- `frank`: sudo access via `/etc/sudoers.d/frank`  
- SSH:  
  - Allowed only `it_team`  
  - Disabled root login  
  - Configured key-based auth for `frank`  
- SELinux: Enforced with Apache context  
- FirewallD: Allowed `SSH`, `HTTP`, and `ping`  

🖼️ *Screenshot Placeholder:*  
`linux_task_output/task4_Sec_Hardening/sudo_frank.png`  
`linux_task_output/task4_Sec_Hardening/allow_it_disable_root.png`  
`linux_task_output/task4_Sec_Hardening/sshkeygrn_frank.png`  
`linux_task_output/task4_Sec_Hardening/set_firewall.png`

---

### 🌐 Phase 5: Apache Web Server Setup

- Installed and enabled Apache (`httpd`)  
- Served a static HTML page  
- Applied correct SELinux contexts  
- Verified from browser: [http://192.168.100.10]  

🖼️ *Screenshot Placeholder:*  
`linux_task_output/task5_Web_portal/systemctl_httpd.png`  
`linux_task_output/task5_Web_portal/machine_ip.png`  
`linux_task_output/task5_Web_portal/show_hosting.png`  
`linux_task_output/task5_Web_portal/change_document.png`  
`linux_task_output/task5_Web_portal/added_ip.png`

---

### 🤖 Phase 6: Automation & Scripting

- `backup_dept.sh` runs daily at 1:00 AM (via cron)  
- Logs success/failure with `logger`  
- `at` job broadcasts save reminder at 17:00  

🖼️ *Screenshot Placeholder:*  
`linux_task_output/task6_Cron_Logs/backup_script.png`  
`linux_task_output/task6_Cron_Logs/cron_at.png`  
`linux_task_output/task6_Cron_Logs/words_atq.png`

---

### 🛠️ Phase 7: Troubleshooting & Logs

- Simulated `/etc/fstab` error → fixed in recovery mode  
- Checked `/var/log/secure` for SSH login attempts  
- Verified backup logs in `/var/log/messages`  

🖼️ *Screenshot Placeholder:*  
`linux_task_output/task7_troubleshooting/bob_ssh.png`  
`linux_task_output/task7_troubleshooting/bob_try_logs.png`  
`linux_task_output/task7_troubleshooting/fstab_mistake.png`  
`linux_task_output/task7_troubleshooting/fstab_fix.png`  
`linux_task_output/task7_troubleshooting/show_success_backup.png`

---

## 📸 Screenshots Folder Convention

All screenshots are organized under `linux_task_output/`, with a subfolder per task.  
linux_task_output/ \
├── task1_Sys_Prep/ \
├── task2_Dir_Perm_setup/ \
├── task3_Storage_LVM_setup/ \
├── task4_Sec_Hardening/ \
├── task5_Web_portal/ \
├── task6_Cron_Logs/ \
└── task7_troubleshooting/ \
`Linux` `System Administration` `Bash Scripting` `Security` `LVM` `DNS` `Apache` `SELinux` `Rocky Linux` `Automation`
