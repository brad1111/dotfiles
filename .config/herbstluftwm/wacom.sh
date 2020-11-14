#!/usr/bin/env bash

# if xsetwacom is installed
if ! command -v xsetwacom &> /dev/null; then
    echo "couldn't find xsetwacom"
    exit 1
fi

#get stylus
STYLUS=$(xsetwacom --list devices | grep stylus | cut -f1 | sed -e 's/[t ]*$//')

if [[ -z "$STYLUS" ]]; then
    echo "couldn't find stylus"
    exit 1
fi

xsetwacom --set "$STYLUS" Button 2 Pan
