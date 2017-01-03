#!/bin/bash
#
# Override default generated properties
#

mkdir -p "$(dirname ${minecraft_property_file_path})"

cat << SVR-PROPS > "${minecraft_property_file_path}"
#Minecraft server properties
#Wed Dec 21 20:46:02 PST 2016
max-tick-time=60000
generator-settings=
force-gamemode=false
allow-nether=true
gamemode=0
enable-query=false
player-idle-timeout=0
difficulty=${minecraft_property_difficulty}
spawn-monsters=true
op-permission-level=4
announce-player-achievements=true
pvp=true
snooper-enabled=true
level-type=DEFAULT
hardcore=false
enable-command-block=false
max-players=20
network-compression-threshold=256
resource-pack-sha1=
max-world-size=29999984
server-port=${minecraft_port}
server-ip=
spawn-npcs=true
allow-flight=false
level-name=${minecraft_data_subdir}
view-distance=10
resource-pack=
spawn-animals=true
white-list=false
generate-structures=true
online-mode=true
max-build-height=256
level-seed=
use-native-transport=true
enable-rcon=false
motd=${minecraft_property_motd}
SVR-PROPS
