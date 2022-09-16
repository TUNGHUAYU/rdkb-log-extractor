#!/bin/bash

# help message
function HELP(){
	echo "usage: $(basename $0) <condition>"
}

# argument check
if [[ $# != 1 ]];then
	HELP
	exit 1
fi

# argument assignment
condition=$1
dst_dir_path="$(pwd)/snapshot/${condition}/${condition}_rdklogs"
src_dir_path="/rdklogs/logs"

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

# copy rdk logs 
echo "cp ${src_dir_path}/* ${dst_dir_path}"
cp ${src_dir_path}/* ${dst_dir_path}
