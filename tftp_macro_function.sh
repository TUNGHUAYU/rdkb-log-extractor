
# set tftp_server_ip if it doesn't exist
if [[ -z ${tftp_server_ip} ]];then
	read -p "Please key in the tftp server ip: " tftp_server_ip
	export tftp_server_ip=${tftp_server_ip}
	echo "export variable tftp_server_ip -> ${tftp_server_ip}"
fi

# define function if they doesn't exist
function tftp_fetch(){

	file_paths=$@

	for file_path in ${file_paths}
	do

		echo "fetching ${file_path} ..."
		echo "tftp -g -r ${file_name} ${tftp_server_ip}"
		tftp -g -r ${file_path} ${tftp_server_ip}
		echo "done"
	done

}

export -f tftp_fetch
echo "export function tftp_fetch"


function tftp_push(){

	file_paths=$@

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

	echo "go back ${OLDPWD}"
	cd ${OLDPWD}

}
export -f tftp_push
echo "export function tftp_push"
