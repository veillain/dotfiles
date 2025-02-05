#!/bin/bash
today=$(date +%d | grep -o '[1-9].*')
dismonth=$(date +%m)

case $1 in
    month )
        boolan=$(date +%B)
        tahoon=$(date +%Y)
        echo -e "$boolan $tahoon"
        ;;
    #Sunday
    sunday ) tgl=$($HOME/.config/waybar/calendar/calendar | awk '{print $1}' | grep -x $today); TEXT="Su" ;;
    su1 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==2 {print $1}') ;;
    su2 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==3 {print $1}') ;;
    su3 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==4 {print $1}') ;;
    su4 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==5 {print $1}') ;;
    su5 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==6 {print $1}') ;;
    #Monday
    monday ) tgl=$($HOME/.config/waybar/calendar/calendar | awk '{print $2}' | grep -x $today); TEXT="Mo" ;;
    mo1 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==2 {print $2}') ;;
    mo2 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==3 {print $2}') ;;
    mo3 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==4 {print $2}') ;;
    mo4 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==5 {print $2}') ;;
    mo5 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==6 {print $2}') ;;
    #Tuesday
    tuesday ) tgl=$($HOME/.config/waybar/calendar/calendar | awk '{print $3}' | grep -x $today); TEXT="Tu" ;;
    tu1 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==2 {print $3}') ;;
    tu2 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==3 {print $3}') ;;
    tu3 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==4 {print $3}') ;;
    tu4 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==5 {print $3}') ;;
    tu5 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==6 {print $3}') ;;
    # Wednesday
    wednesday ) tgl=$($HOME/.config/waybar/calendar/calendar | awk '{print $4}' | grep -x $today); TEXT="We" ;;
    we1 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==2 {print $4}') ;;
    we2 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==3 {print $4}') ;;
    we3 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==4 {print $4}') ;;
    we4 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==5 {print $4}') ;;
    we5 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==6 {print $4}') ;;
    # Thursday
    thursday ) tgl=$($HOME/.config/waybar/calendar/calendar | awk '{print $5}' | grep -x $today); TEXT="Th" ;;
    th1 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==2 {print $5}') ;;
    th2 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==3 {print $5}') ;;
    th3 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==4 {print $5}') ;;
    th4 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==5 {print $5}') ;;
    th5 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==6 {print $5}') ;;
    # Friday
    friday ) tgl=$($HOME/.config/waybar/calendar/calendar | awk '{print $6}' | grep -x $today); TEXT="Fr" ;;
    fr1 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==2 {print $6}') ;;
    fr2 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==3 {print $6}') ;;
    fr3 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==4 {print $6}') ;;
    fr4 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==5 {print $6}') ;;
    fr5 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==6 {print $6}') ;;
    # Saturday
    saturday ) tgl=$($HOME/.config/waybar/calendar/calendar | awk '{print $7}' | grep -x $today); TEXT="Sa" ;;
    sa1 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==2 {print $7}') ;;
    sa2 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==3 {print $7}') ;;
    sa3 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==4 {print $7}') ;;
    sa4 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==5 {print $7}') ;;
    sa5 ) tgl=$($HOME/.config/waybar/calendar/calendar | awk 'NR==6 {print $7}') ;;
    *)
        id=$(ps -ef | grep '[w]aybar -c' | grep calendar | awk '{print $2}')
        kill $id || waybar -c $HOME/.config/waybar/calendar/config.jsonc -s $HOME/.config/waybar/calendar/style.css
esac

if [[ "$1" == *day* ]]; then
    if [[ "$tgl" != "$today" ]]; then
        while true; do
            echo "{\"text\": \"${TEXT}\", \"class\": \"not-today\"}" | jq --unbuffered --compact-output .
            sleep 5
        done
    else
        while true; do
            echo "{\"text\": \"${TEXT}\", \"class\": \"today\"}" | jq --unbuffered --compact-output .
            sleep 5
        done
    fi
fi
if [[ "$1" != "month" ]]; then
    if [[ "$tgl" != "$today" ]]; then
        case $tgl in
            [1-9])
                while true; do
                    echo "{\"text\": \" ${tgl}\", \"class\": \"not-today\"}" | jq --unbuffered --compact-output .
                    sleep 5
                done
                ;;
            [0-9][0-9])
                while true; do
                    echo "{\"text\": \"${tgl}\", \"class\": \"not-today\"}" | jq --unbuffered --compact-output .
                    sleep 5
                done
                ;;
            *)
                while true; do
                    echo "{\"text\": \"${tgl}\", \"class\": \"last-month\"}" | jq --unbuffered --compact-output .
                    sleep 5
                done
                ;;
        esac
    else
        case $tgl in
            [1-9])
                while true; do
                    echo "{\"text\": \" ${tgl}\", \"class\": \"today\"}" | jq --unbuffered --compact-output .
                    sleep 5
                done
                ;;
            [0-9][0-9])
                while true; do
                    echo "{\"text\": \"${tgl}\", \"class\": \"today\"}" | jq --unbuffered --compact-output .
                    sleep 5
                done
                ;;
            *)
                while true; do
                    echo "{\"text\": \"${tgl}\", \"class\": \"last-month\"}" | jq --unbuffered --compact-output .
                    sleep 5
                done
                ;;
        esac
    fi
fi
