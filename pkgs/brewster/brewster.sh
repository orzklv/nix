#!/usr/bin/env bash

# Additional helper to manage brew
if [ -z "$1" ]; then
	echo "No argument supplied"
	exit 1
fi

if [ "$1" = "clean" ]; then
	brew leaves >brew.txt
elif [ "$1" = "detail" ]; then
	brew leaves | xargs -n1 brew desc >desc.txt
else
	echo "Invalid argument"
	exit 1
fi
