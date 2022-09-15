#!/bin/bash

# help message
function HELP(){
	echo "usage: $(basename $0) <rdklogs dir name>"
}

# argument check
if [[ $# != 1 ]];then
	HELP
	exit 1
fi

# argument assignment
dst_dir_path="$(pwd)/$1"
src_dir_path="/rdklogs/logs"

# create folder 
if [[ -d ${dst_dir_path} ]];then
	read -p "overwrite ${dst_dir_path}? (y/n)"
	if [[ ${REPLY} == "y" ]];then
		echo "rm ${dst_dir_path} -rf"
		rm ${dst_dir_path} -rf
	fi
fi

echo "mkdir ${dst_dir_path}"
mkdir ${dst_dir_path}

# import tftp macro functions
source tftp_macro_function.sh

# copy rdk logs 
echo "cp ${src_dir_path}/* ${dst_dir_path}"
cp ${src_dir_path}/* ${dst_dir_path}

# push to tftpd
echo "tftp_push ${dst_dir_path}/*"
tftp_push ${dst_dir_path}/*
