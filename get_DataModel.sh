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

# setup path
dir_path="$(pwd)/snapshot/${condition}"
file_path="${dir_path}/${condition}_DM.txt"

# get data model via dmcli
echo "dmcli eRT getv Device. 2>&1 | tee ${file_path}"
dmcli eRT getv Device. 2>&1 | tee ${file_path}
