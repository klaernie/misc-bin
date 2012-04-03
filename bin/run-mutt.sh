#!/bin/bash -x
if [[ "`hostname`" = "mainframe" ]]
then
	gnome-terminal -t mutt -e mutt
else
	gnome-terminal -t mutt -e "ssh mainframe-vpn -t screen mutt"
fi
