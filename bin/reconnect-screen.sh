#!/bin/bash
if [[ $# -ne 1 ]]; then
	echo "incorrect amount of parameters specified"
	sleep 5
	exit
fi

if [[ -n "$DISPLAY" ]]; then
	screen -S "$1" -X setenv DISPLAY "$DISPLAY"
fi
if [[ -n "$SSH_AUTH_SOCK" ]]; then
	screen -S "$1" -X setenv SSH_AUTH_SOCK "$SSH_AUTH_SOCK"
fi

exec screen -RD -S "$1"
