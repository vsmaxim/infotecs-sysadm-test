#!/bin/bash
#
# Outputs free and used ip's in subnet

IP_PATTERN="([0-9]{1,3}\.){3}[0-9]{1,3}"
MAC_PATTERN="([A-Z0-9]{2}:){5}[A-Z0-9]{2}"

# grep only IPs and MACs from nmap
lines=($(sudo nmap -sn -v $1 | egrep -e "(${IP_PATTERN})|(${MAC_PATTERN})" -o))
free=()
used=()

prevIp=${lines[0]}
prevLine=${prevIp}
for line in ${lines[@]:1}; do
	if [[ ${line} =~ ${MAC_PATTERN} ]]; then 
		if [[ ${prevLine} =~ ${IP_PATTERN} ]]; then 
			used+=("${prevIp} ${line}")
		else
			used+=("${prevIp} DUP!!")
		fi
	else
		if [[ ${prevLine} =~ ${IP_PATTERN} ]]; then 
			free+=("${prevIp}")
		fi
		prevIp=${line}
	fi
	prevLine=${line}
done

echo "Used:" 
for (( i=0; i<${#used[@]}; i++ )); do
	echo "${used[${i}]}"	
done

echo "Free:"
for (( i=0; i<${#free[@]}; i++ )); do
	echo "${free[${i}]}"
done
