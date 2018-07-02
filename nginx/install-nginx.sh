#!/bin/bash
#
# installation scripts for an nginx service
#

set -o errexit
set -o nounset

# deps
yes | aptdcon --hide-terminal --install openssl
yes | aptdcon --hide-terminal --install nginx

chown -R "${module_name}" "${nginx_config_https_certificates_directory}"

systemctl start ${module_name}
