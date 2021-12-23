#!/bin/bash
#
# start the server
#

set -o nounset
set -o errexit

data_path="/var/lib/${module_name}"
mkdir -p "${data_path}/data"

podman run -i \
  --cap-add=sys_nice \
  --stop-timeout 120 \
  -p ${server_port}:25565 \
  -v ${data_path}/data:${container_persistent_data_path} \
  ${container_image_tag}
