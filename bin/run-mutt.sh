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
				vpn=true
			else
				vpn=false
			fi
		;;
	sapdeb2|mia)
			vpn=true
		;;
esac

xterm=$(readlink /etc/alternatives/x-terminal-emulator)
case "$xterm" in
 /usr/bin/urxvt)
	exec_line="urxvt -title mutt -e"
	;;
 /usr/bin/gnome-terminal.wrapper)
	exec_line="gnome-terminal -t mutt -x"
	;;
esac

if [[ -z "$DISPLAY" ]]
then
	unset exec_line
fi

if [[ "$vpn" = "true" ]]
then
	$exec_line ssh mainframe-vpn -t 'screen -c .screenrc.mutt -S mutt -dRR'
else
	if [[ "$ssh" = "true" ]]
	then
		$exec_line ssh mainframe -t 'screen -c .screenrc.mutt -S mutt -dRR'
	else
		$exec_line screen -c .screenrc.mutt -S mutt -dRR
	fi
fi
