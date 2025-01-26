#!/bin/bash
case $1 in
    suspend) pilihan="suspend" ;;
    reboot) pilihan="reboot" ;;
    logout) pilihan="logout" ;;
    poweroff) pilihan="poweroff" ;;
esac

dothethings(){
    case $pilihan in
        suspend) exit 1 ;;
        reboot) reboot ;;
        logout) hyprctl dispatch exit ;;
        poweroff) poweroff ;;
        *) exit 1 ;;
    esac
}


CHOICE=$(printf "Yes\nNo" | rofi -config $HOME/.config/rofi/confirm.rasi -dmenu -no-case-sensitive)
case "$CHOICE" in
    Yes) dothethings ;;
    No) exit 1 ;;
    *) exit 1 ;;
esac
