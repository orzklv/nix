#!/bin/bash

# my $DEV_SPACE is ~/Developer, set your own $DEV_SPACE and add it to
# your ~/.zshrc or ~/.bashrc file to let this script detect it
# check if $DEV_SPACE is set, if not, set it to the current directory
if [ -z "$DEV_SPACE" ]; then
  DEV_SPACE="$(pwd)";
fi

# change current directory to DEV_SPACE
cd "DEV_SPACE" || (echo "Dev Space doesn't exist, please set your own \$DEV_SPACE" &&exit 1);

# loop through project folders in current path and ...
for folder in $(/usr/bin/find . -type d -maxdepth 1); do
  # if package.json exists, delete node_modules folder
  if [ -f "$folder/package.json" ]; then
    echo "Deleting node_modules folder in $folder"
    rm -rf "$folder/node_modules"
  # if cargo.toml exists, delete target folder
  elif [ -f "$folder/Cargo.toml" ]; then
    echo "Deleting target folder in $folder"
    rm -rf "$folder/target"
  fi
done