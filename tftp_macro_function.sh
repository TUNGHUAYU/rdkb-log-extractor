read -p "Please key in the tftp server ip: " tftp_server_ip
echo "tftp_server_ip: ${tftp_server_ip}"

function tftp_fetch(){
	if [[ $# -ne 1 ]];then
		echo "syntax error"
		echo "fetch <filename>"
		return 1
	else
		filename=$1
	fi

	echo "fetching ..."
	echo "tftp -g -r ${filename}" ${tftp_server_ip}
	tftp -g -r ${filename} ${tftp_server_ip}
	echo "finish"	
}

function tftp_push(){
	
	file_paths=$@
	prev_path=$(pwd)

	for file_path in ${file_paths}
	do

		dir_path=$(dirname ${file_path})
		file_name=$(basename ${file_path})
		
		echo "move to ${dir_path}"
		cd ${dir_path}

		echo "pushing ${file_path} ..."
		echo "tftp -p -l ${file_name} ${tftp_server_ip}"
		tftp -p -l ${file_name} ${tftp_server_ip}
		echo "done"
	done

	echo "go back ${prev_path}"
	cd ${prev_path}

}


