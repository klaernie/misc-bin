#!/bin/bash -x
if [[ "`hostname`" = "mainframe" ]]
then
	gnome-terminal -t mutt -e mutt
else
	if host vpn.ak-online.be 2>&1 >/dev/null 
	then
		gnome-terminal -t mutt -e "ssh mainframe-vpn -t screen mutt"
	else
		gnome-terminal -t mutt -e "ssh mainframe -t screen mutt"
	fi
fi
