#!/bin/bash
#
# installation scripts for a minecraft service
#

set -e
set -u

# deps
yes | aptdcon --hide-terminal --install curl
yes | aptdcon --hide-terminal --install openjdk-8-jre-headless
yes | aptdcon --hide-terminal --install unzip

# add a service user
mkdir -p "${module_install_dir}"
adduser --system --no-create-home --home "${module_install_dir}" "${module_name}" || true
addgroup --system "${module_name}" || true
chown -R "${module_name}" "${module_install_dir}"

# create the service unit
cat << SVC-UNIT > "/etc/systemd/system/${module_name}.service"
[Unit]
Description=${module_name} server
After=network.target

[Service]
ExecStart=/bin/bash ${module_install_dir}/${minecraft_start_script}
Restart=on-failure

[Install]
WantedBy=multi-user.target
SVC-UNIT
systemctl daemon-reload

# download and unpack the server zip
curl "${minecraft_download_url}" -qso server.zip
unzip -q -o -d "${module_install_dir}" server.zip

# run the installer
bash "${module_install_dir}/${minecraft_install_script}"

# accept the eula
sed -i 's/false/true/g' "${module_install_dir}/${minecraft_eula}"

# assert settings
sed -i "s/MIN_RAM=.*/MIN_RAM=${minecraft_min_ram}/g" "${module_install_dir}/${minecraft_settings_script}"
grep "MIN_RAM=${minecraft_min_ram}" "${module_install_dir}/${minecraft_settings_script}" &>/dev/null
sed -i "s/MAX_RAM=.*/MAX_RAM=${minecraft_max_ram}/g" "${module_install_dir}/${minecraft_settings_script}"
grep "MAX_RAM=${minecraft_max_ram}" "${module_install_dir}/${minecraft_settings_script}" &>/dev/null

# overriding logging properties
mkdir -p "${module_install_dir}/config"
cat << LOG-PROPS > "${module_install_dir}/config/logging.properties"
log4j.rootLogger=INFO, stdout
log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.Target=System.out
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n
LOG-PROPS

# put the world on a non-root/bootable volume
mkdir -p ${minecraft_data_symlink}
rm "${module_install_dir}/${minecraft_data_subdir}" || true
ln -s ${minecraft_data_symlink} "${module_install_dir}/${minecraft_data_subdir}"

# start the server once to unpack the rest of the configs
chown -R "${module_name}" "${module_install_dir}"
systemctl start ${module_name} 
