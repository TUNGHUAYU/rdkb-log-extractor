#!/bin/bash

# help message
function HELP(){
	echo "usage: $(basename $0) <condition>"
	echo "collect data model (DM) and rdklogs"
}

# check argument
if [[ $# != 1 ]]; then
	HELP
	exit 1
fi

# assign variable value
condition=$1
dst_dir_path="$(pwd)/snapshot/${condition}"

# create folder 
if [[ -d ${dst_dir_path} ]];then
	read -p "overwrite ${dst_dir_path}? (y/n)"
	if [[ ${REPLY} == "y" ]];then
		echo "rm ${dst_dir_path} -rf"
		rm ${dst_dir_path} -rf
	else 
		exit 0
	fi
fi

echo "mkdir ${dst_dir_path}"
mkdir -p ${dst_dir_path}

# main process
bash get_DataModel.sh "${condition}"
bash get_rdklogs.sh "${condition}"

cd ${dst_dir_path%/*}
cp "/version.txt" "${condition}"

cd ${condition}
cp "/nvram/dnsmasq.leases" "dnsmasq.leases"
ip neighbour show > "ip_neighbour_show.txt"
iw dev wl0 station dump > "dev_wl0_station_dump.txt"
iw dev wl1 station dump > "dev_wl1_station_dump.txt"
arp > "arp.txt"

# compress the files to zip
cd ..
tar czvf "${condition}_snapshot.tar.gz" "${condition}"

# tftp push
tftp_push ${condition}_snapshot.tar.gz

# go back old pwd
echo "move back ${OLDPWD}"
cd ${OLDPWD}


