########################Task_1##########################
#####System Prepration and User Environment 
#!/bin/bash

####1-Changing the hostname 
hostnamectl  set-hostname  intranet.technova.local.


####2-Set static ip 
nmcli connection modify ens160 \
ipv4.addresses 192.168.153.10/24 \
ipv4.dns 8.8.8.8 \
ipv4.gateway 192.168.153.2 \
ipv4.method manual \
connection.autoconnect yes 

nmcli connection up ens160

systemctl restart NetworkManager

####3-Creating 4 department groups 

groupadd dev_team && groupadd hr_team && groupadd it_team && groupadd sales_team 


####4-Creating users & Asign them to groups & Create password ,Force password change

declare -A users_groups=(
	[alice]=dev_team
	[bob]=hr_team
	[carol]=it_team
	[dave]=sales_team
	[erin]=dev_team
	[frank]=it_team
)

for user in "${!users_groups[@]}"; do 
	group="${users_groups[$user]}"
	useradd -m -s /bin/bash -g "$group" "$user"
	echo "$user:1234" | chpasswd 
	passwd --expire "$user"
	echo "User $user created" 
done 
