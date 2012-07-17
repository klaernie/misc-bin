#!/bin/bash
chromium &
synS &
if [ `hostname` == "sapdeb2" ]
then
	LTS &
	css &
	remmina &
	mspidgin &
else
	pidgin &
fi
