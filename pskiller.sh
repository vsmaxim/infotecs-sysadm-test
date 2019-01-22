#!/bin/bash
#
# Kills processes from sudo via ssh

exec 3< ${2} 
read username <&3
read password <&3
read killingUsername <&3
read killingPassword <&3
exec 3<&-

for host in ${@:3}; do
	sshpass -p ${password} ssh -o "StrictHostKeyChecking no" -T ${username}@${host} << EOF
if [[ -z "${killingUsername}" ]]; then
	echo ${password} | sudo -S kill \$(pgrep ${1}) || sudo -S kill -9 \$(pgrep ${1})
else
	echo Hexxxx > ~/test.txt
	echo ${killingPassword} | sudo -S -u ${killingUsername} kill \$(pgrep ${1}) || sudo -S -u ${killingUsername} kill -9 \$(pgrep ${1})
fi
EOF
done
