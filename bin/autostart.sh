#!/bin/bash
chromium &
if [ `hostname` == "sapdeb2" ]
then
	LTS &
	css &
	remmina &
	mspidgin &
	VBoxManage startvm SAP-Windows&
else
	synS &
	pidgin &
fi
