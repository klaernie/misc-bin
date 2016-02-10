#!/bin/bash
if [[ $# -ne 1 ]]; then
	echo "incorrect amount of parameters specified"
	sleep 5
	exit
fi

if [[ -n "$DISPLAY" ]]; then
	echo "setting \$DISPLAY to $DISPLAY"
	screen -S "$1" -X setenv DISPLAY "$DISPLAY"
	echo "done"
fi
if [[ -n "$SSH_AUTH_SOCK" ]]; then
	echo "setting \$SSH_AUTH_SOCK to $SSH_AUTH_SOCK"
	screen -S "$1" -X setenv SSH_AUTH_SOCK "$SSH_AUTH_SOCK"
	echo "done"
fi

exec screen -RD -S "$1"
