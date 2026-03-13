#!/bin/sh

if [ -z "$1" ]; then
	exit 1
fi

curl -sL -o /dev/null -w '%{url_effective}\n' "$1"
