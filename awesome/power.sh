#!/bin/sh

ACTION=`zenity --width=90 --height=200 --list --radiolist --text="Select logout action" --title="Logout" --column "Choice" --column "Action" TRUE Shutdown FALSE Reboot FALSE LockScreen`

if [ -n "${ACTION}" ];then
  case $ACTION in
  Shutdown)
    zenity --question --text "Are you sure you want to halt?" && systemctl halt
    ;;
  Reboot)
    zenity --question --text "Are you sure you want to reboot?" && systemctl reboot
    ;;
  LockScreen)
    slock
    ;;
  esac
fi