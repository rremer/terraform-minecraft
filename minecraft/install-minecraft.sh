#!/bin/bash
#
# installation scripts for a minecraft service
#

set -e
set -u

# deps
yes | aptdcon --hide-terminal --install curl
yes | aptdcon --hide-terminal --install unzip

# add a service user
rm -r "${module_install_dir}" || true
mkdir -p "${module_install_dir}"
mkdir -p "${minecraft_backup_data_dir}"
adduser --system --no-create-home --home "${module_install_dir}" "${module_name}" || true
addgroup --system "${module_name}" || true
chown -R "${module_name}" "${module_install_dir}"
chown -R "${module_name}" "${minecraft_backup_data_dir}"

# create the service unit
cat << SVC-UNIT > "/etc/systemd/system/${module_name}.service"
[Unit]
Description=${module_name} server
After=network.target

[Service]
ExecStart=/bin/bash ${module_install_dir}/${minecraft_start_script} ${minecraft_start_properties}
Restart=on-failure

[Install]
WantedBy=multi-user.target
SVC-UNIT
systemctl daemon-reload

# download and unpack the server zip
curl "${minecraft_download_url}" -qso server.zip
unzip -q -o -d "${module_install_dir}" server.zip

# start the server once to unpack the rest of the configs
chown -R "${module_name}" "${module_install_dir}"
systemctl start ${module_name} 
