#!/bin/bash
chromium &
if [ `hostname` == "sapdeb2" ]
then
	LTS &
	css &
	remmina &
	mspidgin &
else
	synS &
	pidgin &
fi
