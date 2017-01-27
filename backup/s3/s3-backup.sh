#!/bin/bash
#
# Backup a directory to s3
#


set -u

DIRECTORY="${1}"
S3_BUCKET="s3://${2}/"
CFG_PATH="${3}"
KEEP_DAYS="${4}"
LIMIT_KBS="${5}"
BACKUP_TMP_DIR=${6:-'/tmp'}

keep_seconds=$(expr ${KEEP_DAYS} \* 86400)

date_now=$(date +%s)
backup_ext='.tgz'
backup="${BACKUP_TMP_DIR}/${date_now}${backup_ext}"
del_seconds=$(expr ${date_now} - ${keep_seconds})

# reusable s3cmd invocation
s3cmd_cmd="$(which s3cmd) --config=${CFG_PATH} --no-progress"

trap cleanup EXIT
cleanup(){
     rm -f "${backup}"
}

test -d "${DIRECTORY}"
mkdir -p "${BACKUP_TMP_DIR}"
tar -czf "${backup}" "${DIRECTORY}"
trickle -s -u ${LIMIT_KBS} ${s3cmd_cmd} put ${backup} ${S3_BUCKET}

# if we keep backups forever, exit here
if [ ${keep_seconds} -lt 0 ]; then exit 0; fi

# list all existing backups and get seconds since the epoch mappings
declare -A s3_backups
for tgz in $(${s3cmd_cmd} ls ${S3_BUCKET} | rev | cut -d ' ' -f 1 | rev); do
     tgz_date="$(echo ${tgz} | sed "s/${backup_ext}//g")"
     s3_backups[${tgz_date}]=${tgz}
done

# iterate through the dated backups and delete old ones
for epoch_s in ${!s3_backups[@]}; do
     if [ ${epoch_s} -lt ${keep_seconds} ]; then
          ${s3cmd_cmd} del "${S3_BUCKET}${s3_backups[${epoch_s}]}"
     fi
done
