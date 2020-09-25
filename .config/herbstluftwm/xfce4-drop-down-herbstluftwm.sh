#!/bin/zsh

launch(){
  xfce4-terminal --drop-down
#  sleep 1s
}
getPID(){
  pgrep xfce4-terminal
}

makeFloating() {
    echo "makeFloating $HEX_WINID"
    herbstclient set_attr clients.0x$1.floating true
}

DROP_DOWN_PID_FILE=/tmp/xfce4-terminal-drop-down-pid

if [[ -f $DROP_DOWN_PID_FILE ]]; then
  echo reading from file
  launch
  while IFS= read -r HEX_WINID; do
    makeFloating $HEX_WINID
    echo $?
  done < $DROP_DOWN_PID_FILE || true
  exit
fi

#(
#  flock -n 9 || exit 1
  
  PID=$(getPID)
  if [[ -z "${PID}" ]]; then  
    WINIDS_BEFORE=$(xdotool search --name "Terminal")
    launch
    PID=$(getPID)
  else
    WINIDS_BEFORE=$(xdotool search --all --pid "${PID}" --name "Terminal")
    launch
  fi
  WINIDS_AFTER=$(xdotool search --all --pid "${PID}" --name "Terminal")
  if [[ "$WINIDS_BEFORE" == "$WINIDS_AFTER" ]]; then
    echo "same"
    echo "before: $WINIDS_BEFORE"
    echo "after: $WINIDS_AFTER"   
    exit 1
  fi

  echo "before: $WINIDS_BEFORE"
  echo "after: $WINIDS_AFTER"
  NEW_WINIDS=$(diff <(echo $WINIDS_BEFORE | sort | uniq ) <(echo $WINIDS_AFTER | sort | uniq ) | grep \> | cut -d' ' -f2)
  echo "new ids: $NEW_WINIDS"
  # Loop through each line of NEW_WINIDS and try to set to floating
  while IFS= read -r WINID; do
    HEX_WINID=$(printf '%x\n' $WINID)
    makeFloating $HEX_WINID
    echo $?
    echo $HEX_WINID >> $DROP_DOWN_PID_FILE 
  done <<< "$NEW_WINIDS" || true
  chmod 400 $DROP_DOWN_PID_FILE
#) 9>/tmp/xfce4-drop-down-herbstluftwm

