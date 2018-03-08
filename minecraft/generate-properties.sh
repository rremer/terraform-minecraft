#!/bin/bash
#
# Override default generated properties
#

set -e
set -u

# dumb property prefix iterator from environment to replace
# tokens in a file
replace_props(){
  prop_file="${1}"
  prop_prefix='minecraft_'

  while IFS='=' read -r key val; do
    if [ $(echo "${key}" | grep -c "${prop_prefix}") -eq 1 ]; then
      sed -i "s%${key}%${val}%g" "${prop_file}"
    fi
  done < <(env)
}

mkdir -p "$(dirname ${minecraft_property_file_target_path})"
cp "${minecraft_property_file_template}" "${minecraft_property_file_target_path}"
replace_props "${minecraft_property_file_target_path}"
chown ${module_name} "${minecraft_property_file_target_path}"
chmod 0444 "${minecraft_property_file_target_path}"


mkdir -p "$(dirname ${minecraft_ftb_config_target_path})"
cp "${minecraft_ftb_config_template}" "${minecraft_ftb_config_target_path}"
replace_props "${minecraft_ftb_config_target_path}"
chown ${module_name} "${minecraft_ftb_config_target_path}"
chmod 0444 "${minecraft_ftb_config_target_path}"
