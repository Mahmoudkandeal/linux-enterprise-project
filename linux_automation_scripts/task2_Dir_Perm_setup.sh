#!/bin/bash

#### 1-we make the directories
for dept in dev hr it sales ; do
    mkdir -p /srv/$dept
    echo "Created /srv/$dept"
done

echo "Task 1 completed successfully"


#### 2-we set owner and permissions
chown  root:dev_team /srv/dev 
chmod 2770 /srv/dev

chown  root:dev_team /srv/hr 
chmod 2770 /srv/hr

chown  root:dev_team /srv/it 
chmod 2770 /srv/it

chown  root:dev_team /srv/sales 
chmod 2770 /srv/sales

echo "Task 2 completed successfully" 

#### 3-Creating ACLs
## For frank (IT Manager)
setfacl -m u:frank:rwX /srv/dev
setfacl -m u:frank:rwX /srv/hr
setfacl -m u:frank:rwX /srv/it 
setfacl -m u:frank:rwX /srv/sales

## For bob to /srv/sales(HR auditing)
setfacl -m u:bob:r-X /srv/sales

echo "Task 3 completed successfully" 


#### 4-Creating shared folder && sticky permission 
mkdir  -p /srv/public_temp 
chmod 1777 /srv/public_temp

echo "Task 4 completed successfully"
