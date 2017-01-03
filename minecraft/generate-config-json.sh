#!/bin/bash
#
# Override default generated configuration
#

mkdir -p "$(dirname ${minecraft_local_config_path})"

cat << CFG-JSON > "${minecraft_local_config_path}"
{
  "backups": {
    "backups_to_keep": 12,
    "display_file_size": true,
    "enabled": ${minecraft_backup_enabled},
    "compression_level": 1,
    "backup_timer": 2.0,
    "folder": "",
    "use_separate_thread": true
  },
  "world": {
    "temp": {
      "max_loaded_chunks": 64,
      "max_claimed_chunks": 1000
    },
    "chunk_loading": true,
    "locked_in_dimensions": [
      1,
      0,
      -1
    ],
    "locked_in_claimed_chunks": false,
    "blocked_entities": [],
    "chunk_claiming": true,
    "safe_spawn": false,
    "spawn_area_in_sp": false
  },
  "general": {
    "auto_restart": false,
    "chat": {
      "substitutes": [
        {
          "shrug": {
            "text": "??\\_(???)_/??"
          }
        }
      ],
      "substitute_prefix": "!",
      "enable_links": true
    },
    "restart_timer": 12.0,
    "server_info": {
      "difficulty": true,
      "mode": true
    },
    "ranks": {
      "enabled": false
    }
  },
  "commands": {
    "chunks": true,
    "trash_can": true,
    "js": true,
    "warp": true,
    "tpl": true,
    "inv": true,
    "back": true,
    "server_info": true,
    "spawn": true,
    "home": true,
    "kickme": true
  },
  "webapi": {
    "port": 4509,
    "output_map": false,
    "enabled": false
  },
  "login": {
    "motd": [],
    "enable_motd": true,
    "enable_starting_items": true,
    "starting_items": []
  }
}
CFG-JSON
