#!/bin/bash
LOCKFILE=/tmp/engage-DP2
if [[ ! -e $LOCKFILE ]]
then
	touch $LOCKFILE && xrandr --output DP-2 --auto --primary
else
	( sleep 2 && rm $LOCKFILE ) &
fi
