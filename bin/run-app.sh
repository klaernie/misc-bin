#!/bin/bash -x

if [[ "$0" =~ run-([a-z]+).sh ]]
then
	APP=${BASH_REMATCH[1]}
else
	APP=mutt
fi


ssh=true
case "`hostname`" in
	debs)
			vpn=false
			ssh=false
		;;
	mainframe)
			vpn=false
			ssh=true
		;;
	sapdeb2|eliza)
			if host vpn.ak-online.be 2>&1 >/dev/null
			then
				vpn=true
			else
				vpn=false
			fi
		;;
	mia)
			vpn=true
		;;
	ls2621|ls2622|spwdfvml1218|spwdfvml1219)
			vpn=false
			ssh=false
		;;
esac

if [[ -z "$DISPLAY" ]]
then
	unset exec_line
else
	xterm=$(readlink /etc/alternatives/x-terminal-emulator)
	case "$xterm" in
		/usr/bin/urxvt)
			exec_line="urxvt -name $APP -e"
			;;
		/usr/bin/gnome-terminal.wrapper)
			exec_line="gnome-terminal -t $APP -x"
			;;
	esac
fi

if [[ "$vpn" = "true" ]]
then
	which notify-send >/dev/null 2>&1 && notify-send -t 2000 "$APP:" "starting via VPN"
	exec $exec_line ssh debs.ak-online.be -t "screen -c .screenrc.$APP -S $APP -dRR $@"
else
	if [[ "$ssh" = "true" ]]
	then
		which notify-send >/dev/null 2>&1 && notify-send -t 2000 "$APP:" "starting via plain SSH"
		exec $exec_line ssh debs.ak-online.be -t "screen -c .screenrc.$APP -S $APP -dRR $@"
	else
		which notify-send >/dev/null 2>&1 && notify-send -t 2000 "$APP:" "running directly"
		exec $exec_line screen -c .screenrc.$APP -S $APP -dRR $@
	fi
fi
