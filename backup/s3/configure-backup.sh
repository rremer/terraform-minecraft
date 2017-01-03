#!/bin/bash
#
# Configure an s3-backup service
#

set -e
set -u
set -o pipefail

test -n "${backup_user}"
test -n "${s3_bucket}"
test -n "${s3_access_key_id}"
test -n "${s3_access_secret}"
test ${interval_minutes} -ge 1
test ${keep_days} -gt -2
test -f "${backup_script_path}"

adduser --system --no-create-home --home "${backup_user}" || true
addgroup --system "${backup_user}" || true

# deps
yes | aptdcon --hide-terminal --install s3cmd || true
yes | aptdcon --hide-terminal --install trickle || true

# configure s3cmd
mkdir -p "$(dirname ${s3_config_path})"
cat << S3CMD-CFG > "${s3_config_path}"
[default]
access_key = ${s3_access_key_id}
bucket_location = US
cloudfront_host = cloudfront.amazonaws.com
default_mime_type = binary/octet-stream
delete_removed = False
dry_run = False
enable_multipart = True
encoding = UTF-8
encrypt = False
follow_symlinks = False
force = False
get_continue = False
gpg_command = /usr/bin/gpg
gpg_decrypt = %(gpg_command)s -d --verbose --no-use-agent --batch --yes --passphrase-fd %(passphrase_fd)s -o %(output_file)s %(input_file)s
gpg_encrypt = %(gpg_command)s -c --verbose --no-use-agent --batch --yes --passphrase-fd %(passphrase_fd)s -o %(output_file)s %(input_file)s
gpg_passphrase = 
guess_mime_type = True
host_base = s3.amazonaws.com
host_bucket = %(bucket)s.s3.amazonaws.com
human_readable_sizes = False
invalidate_on_cf = False
list_md5 = False
log_target_prefix = 
mime_type = 
multipart_chunk_size_mb = 15
preserve_attrs = True
progress_meter = True
proxy_host = 
proxy_port = 0
recursive = False
recv_chunk = 4096
reduced_redundancy = False
secret_key = ${s3_access_secret}
send_chunk = 4096
simpledb_host = sdb.amazonaws.com
skip_existing = False
socket_timeout = 300
urlencoding_mode = normal
use_https = False
verbosity = WARNING
website_endpoint = http://%(bucket)s.s3-website-%(location)s.amazonaws.com/
website_error = 
website_index = index.html
S3CMD-CFG
chown ${backup_user}:${backup_user} "${s3_config_path}"
chmod 0600 "${s3_config_path}"

cat << S3CMD-CRON > /etc/cron.d/s3-backup
*/${interval_minutes} * * * * ${backup_user} $(which bash) ${backup_script_path} ${backup_directory} ${s3_bucket} ${s3_config_path} ${keep_days} ${backup_rate_limit_kbs}
S3CMD-CRON
