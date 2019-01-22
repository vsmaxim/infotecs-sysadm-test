#!/usr/bin/env bash
# 
# Perform backups with pg_dump.

log_message() {
	timestamp="$(date +[%Y-%m-%d\ %H:%M:%S])"
	echo "${timestamp} $1" | tee -a "$2"
}


if [[ ! "$1" ]]; then
	echo "Usage: backup-sql /path/to/configs.config" >&2
	exit 1
fi

if test -f $1; then
	. $1 
else
	echo "Configuration file not found at $1, exiting..." >&2
	exit 1
fi

date_timestamp="$(date +%Y.%m.%d_%H%M%S)"
# Keeping there "/" after BACKUP_PATH, as there wasn't mentioned about trailing slash in path
# if we need trailing slash support in configs, then we need to strip it from BACKUP_PATH
file="${BACKUP_PATH}/${BACKUP_PREFIX}${date_timestamp}.tar"
log_file="${BACKUP_PATH}/${BACKUP_PREFIX}${date_timestamp}.log"

log_message "Backup started with pg_dump..." $log_file
error=$(mktemp)
trap "rm -rf ${error}" EXIT
if pg_dump -h ${DB_HOST} -d ${DB_BASE} -U ${DB_USER} -w -F tar -f ${file} 2> "$error"; then
	lzip ${file}
else
	# Removing file, because pg_dump is creating it in case of fail
	rm ${file}
	while read errmsg; do
		log_message "$errmsg" $log_file
	done < "$error"
	exit 1
fi
log_message "Backup finished!" $log_file

files=( $(ls -tr ${BACKUP_PATH}/*.tar.lz) )
files_count=${#files[@]}
if [[ $files_count -gt $BACKUP_COUNT ]]; then
	log_message "Excess files found, removing them..." $log_file
	difference=$(($files_count - $BACKUP_COUNT))
	for file in ${files[@]:0:$difference}
	do
		log_message "Removing $file" $log_file
		rm $file
	done
fi
