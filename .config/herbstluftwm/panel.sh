#!/bin/bash

hc() {
	herbstclient "$@"
}

pids=( )
# reserve some space for the panel on monitor 0
hc pad 0 36 "" ""
# start the panel itself and remember its pid
xfce4-panel -d --sm-client-disable &
#vala-panel
pids+=( $! )
# or start another panel:
# mypanel &
# pids+=( $! )
# wait until the panels should be stopped
herbstclient -w '(quit_panel|reload)'
# stopp all started panels
kill ${pids[@]}
