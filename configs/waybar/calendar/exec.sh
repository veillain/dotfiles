#!/bin/bash
today=$(date +%d)

case $1 in
    month )
        bulanini=$(date +%B,\ %Y)
        echo $bulanini
        ;;
    #Sunday
    sunday ) tgl=$($HOME/.local/bin/calendar | awk '{print $1}' | grep $today); TEXT="Su" ;;
    su1 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==2 {print $1}') ;;
    su2 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==3 {print $1}') ;;
    su3 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==4 {print $1}') ;;
    su4 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==5 {print $1}') ;;
    su5 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==6 {print $1}') ;;
    #Monday
    monday ) tgl=$($HOME/.local/bin/calendar | awk '{print $2}' | grep $today); TEXT="Mo" ;;
    mo1 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==2 {print $2}') ;;
    mo2 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==3 {print $2}') ;;
    mo3 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==4 {print $2}') ;;
    mo4 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==5 {print $2}') ;;
    mo5 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==6 {print $2}') ;;
    #Tuesday
    tuesday ) tgl=$($HOME/.local/bin/calendar | awk '{print $3}' | grep $today); TEXT="Tu" ;;
    tu1 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==2 {print $3}') ;;
    tu2 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==3 {print $3}') ;;
    tu3 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==4 {print $3}') ;;
    tu4 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==5 {print $3}') ;;
    tu5 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==6 {print $3}') ;;
    # Wednesday
    wednesday ) tgl=$($HOME/.local/bin/calendar | awk '{print $4}' | grep $today); TEXT="We" ;;
    we1 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==2 {print $4}') ;;
    we2 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==3 {print $4}') ;;
    we3 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==4 {print $4}') ;;
    we4 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==5 {print $4}') ;;
    we5 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==6 {print $4}') ;;
    # Thursday
    thursday ) tgl=$($HOME/.local/bin/calendar | awk '{print $5}' | grep $today); TEXT="Th" ;;
    th1 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==2 {print $5}') ;;
    th2 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==3 {print $5}') ;;
    th3 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==4 {print $5}') ;;
    th4 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==5 {print $5}') ;;
    th5 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==6 {print $5}') ;;
    # Friday
    friday ) tgl=$($HOME/.local/bin/calendar | awk '{print $6}' | grep $today); TEXT="Fr" ;;
    fr1 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==2 {print $6}') ;;
    fr2 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==3 {print $6}') ;;
    fr3 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==4 {print $6}') ;;
    fr4 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==5 {print $6}') ;;
    fr5 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==6 {print $6}') ;;
    # Saturday
    saturday ) tgl=$($HOME/.local/bin/calendar | awk '{print $7}' | grep $today); TEXT="Sa" ;;
    sa1 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==2 {print $7}') ;;
    sa2 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==3 {print $7}') ;;
    sa3 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==4 {print $7}') ;;
    sa4 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==5 {print $7}') ;;
    sa5 ) tgl=$($HOME/.local/bin/calendar | awk 'NR==6 {print $7}') ;;
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
            [0-9])
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
        esac
    else
        case $tgl in
            [0-9])
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
        esac
    fi
fi