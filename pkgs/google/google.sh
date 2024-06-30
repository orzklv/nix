#!/usr/bin/env bash

# If no argument is supplied, exit
if [ -z "$1" ]; then
	echo "No argument supplied"
	exit 1
fi

# Search for the argument
echo "Searching for \"$*\""
search_string="$*"
xdg-open "https://www.google.com/search?q=$search_string"
