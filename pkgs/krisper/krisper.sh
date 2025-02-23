#!/usr/bin/env bash

# krisp-patcher $(find ~/.config/discord/ -name "discord_krisp.node" -path "*/modules/discord_krisp/*")

find ~/.config/discord/ -name "discord_krisp.node" -path "*/modules/discord_krisp/*" -print0 | while IFS= read -r -d '' file; do
  krisp-patcher "$file"
done
