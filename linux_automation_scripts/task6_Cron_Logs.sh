#!/bin/bash
set -e 
###### Cron jobs && Logs ######

#### 1-Archiving script 
cat << 'EOF' > /usr/local/bin/backup_dept.sh 
#!/bin/bash
set -e 
mkdir -p /backups 
Today=$(date +%F)
for Dept in dev hr it sales; do 
    Source="/srv/$Dept"
    Dest="/backups/${Dept}_${Today}.tar.gz"
    
    tar -czf "$Dest" "$Source" 2>/dev/null && \
    logger "Backup complete for $Dept" || \
    logger "Backup failed for $Dept"
done
EOF
chmod +x /usr/local/bin/backup_dept.sh

#### 2-Making Cron job to run the backup_script
Cron_job="0 1 * * * /usr/local/bin/backup_dept.sh"
crontab -l 2>/dev/null | grep -q "$Cron_job" || \
( crontab -l 2>/dev/null; echo "$Cron_job" ) | crontab -

#### 3-Make sure atd is running 
systemctl enable --now atd

#### 4-Run the at job
echo 'wall "System maintenance will occur tonight at 1:00 AM. Save your work!!"' | at 17:00


echo "Phase 6 completed successfully"
