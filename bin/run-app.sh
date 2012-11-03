#!/bin/bash -x

if [[ "$0" =~ run-([a-z]+).sh ]]
then 
	APP=${BASH_REMATCH[1]}
else
	APP=mutt
fi


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

if [[ -z "$DISPLAY" ]]
then
	unset exec_line
else
	xterm=$(readlink /etc/alternatives/x-terminal-emulator)
	case "$xterm" in
	 /usr/bin/urxvt)
		exec_line="urxvt -title $APP -e"
		;;
	 /usr/bin/gnome-terminal.wrapper)
		exec_line="gnome-terminal -t $APP -x"
		;;
	esac
fi

if [[ "$vpn" = "true" ]]
then
	$exec_line ssh mainframe-vpn -t "screen -c .screenrc.$APP -S $APP -dRR"
else
	if [[ "$ssh" = "true" ]]
	then
		$exec_line ssh mainframe -t "screen -c .screenrc.$APP -S $APP -dRR"
	else
		$exec_line screen -c .screenrc.$APP -S $APP -dRR
	fi
fi
