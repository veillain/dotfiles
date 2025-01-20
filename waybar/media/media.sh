#!/bin/bash

percentage (){
    pacman="󰮯"
    fullDot="━"
    eatenDot="—"
    progressBarLength=50

    while true; do
        status=$(playerctl status)
        if [[ "$status" == Playing ]]; then
            raw_duration=$(playerctl metadata | grep length | awk '{print $3}')
            total_duration=$((${raw_duration}/1000000))
            minute=$((${total_duration}/60))
            hitung=$(echo "scale=2; $total_duration / 60" | bc)
            current_position=$(playerctl position | cut -d'.' -f1)
            percentage=$((${current_position}*100/${total_duration}))

            progressBar=""
            for ((i=0; i<progressBarLength; i++)); do
                if [ $i -lt $((percentage*progressBarLength/100)) ]; then
                    progressBar+="$eatenDot"
                elif [ $i -eq $((percentage*progressBarLength/100)) ]; then
                    progressBar+="$pacman"
                else
                    progressBar+="$fullDot"
                fi
            done

            echo "{\"text\": \"${progressBar}\", \"class\": \"normal\"}" | jq --unbuffered --compact-output .

            sleep 1
        fi
    done
}

image(){
    while true; do
        artUrl=$(playerctl metadata | grep artUrl | awk '{print $3}' | sed 's|file://||')
        rm /tmp/mediathumbnail; magick $artUrl -thumbnail 500x500^ -gravity center -extent 500x500 /tmp/mediathumbnail
        # cp -rf $artUrl /tmp/mediathumbnail
        sleep 5
    done
}

metadata(){
    artist=$(playerctl metadata | grep artist | grep -oP 'artist\s+\K.*')
    title=$(playerctl metadata | grep title | grep -oP 'title\s+\K.*')
}

case $1 in
    percentage) percentage ;;
    title)
        metadata; echo "$title"; image
        ;;
    artist)
        metadata; echo "$artist"
        ;;
    image) image ;;
esac
