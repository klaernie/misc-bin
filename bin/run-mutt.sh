#!/bin/bash -x
if [[ "`hostname`" = "mainframe" ]]
then
	gnome-terminal -t mutt -e '/bin/zsh -i -c mutt'
else
	if host vpn.ak-online.be 2>&1 >/dev/null 
	then
		gnome-terminal -t mutt -e "ssh mainframe-vpn -t screen /bin/zsh -i -c mutt"
	else
		if [[ "`hostname`" = "sapdeb2" ]]
		then
			gnome-terminal -t mutt -e "ssh mainframe-vpn -v -t screen /bin/zsh -i -c mutt"
		else
			gnome-terminal -t mutt -e "ssh mainframe -t screen /bin/zsh -i -c mutt"
		fi
	fi
fi
