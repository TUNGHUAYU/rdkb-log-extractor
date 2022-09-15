#!/bin/bash

# help message
function HELP(){
	echo "usage: $(basename $0) <data_model filename>"
}

# argument check
if [[ $# != 1 ]];then
	HELP
	exit 1
fi

# argument assignment
file_name=$1

# import tftp macro functions
source tftp_macro_function.sh

# setup path
dir_path=$(pwd)
file_path="${dir_path}/${file_name}"

# get data model via dmcli
echo "dmcli eRT getv Device. 2>&1 | tee ${file_path}"
dmcli eRT getv Device. 2>&1 | tee ${file_path}

# push to tftpd
echo "tftp_push ${file_path}"
tftp_push ${file_path}

