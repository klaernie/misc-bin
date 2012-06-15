#!/bin/bash -x

ssh=true
case "`hostname`" in
	mainframe)
			vpn=false
			ssh=false
		;;
	eliza)
			if host vpn.ak-online.be 2>&1 >/dev/null
			then
				vpn=false
			else
				vpn=true
			fi
		;;
	sapdeb2|mia)
			vpn=true
		;;
esac

if [[ "$vpn" = "true" ]]
then
	gnome-terminal -t mutt -e "ssh mainframe-vpn -t 'screen -c .screenrc.mutt -S mutt -dRR'"
else
	if [[ "$ssh" = "true" ]]
	then
		gnome-terminal -t mutt -e "ssh mainframe     -t 'screen -c .screenrc.mutt -S mutt -dRR'"
	else
		gnome-terminal -t mutt -e "screen -c .screenrc.mutt -S mutt -dRR"
	fi
fi
