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
        else
            echo "{\"text\": \"——————————————————————————————————————————————————\", \"class\": \"normal\"}" | jq --unbuffered --compact-output .

            sleep 1
        fi
    done
}

image(){
    while true; do
        artUrl=$(playerctl metadata | grep artUrl | awk '{print $3}' | sed 's|file://||')
        cache="/tmp/mediacache"
        thumbnail="/tmp/mediathumbnail"
        magick $artUrl -thumbnail 500x500^ -gravity center -extent 500x500 $cache

        if [[ "$thumbnail" != "$cache" ]]; then
            cp -rf $cache $thumbnail
        fi
        # cp -rf $artUrl /tmp/mediathumbnail
        sleep 5
    done
}

title(){
    while true; do
        status=$(playerctl status)
        if [[ "$status" == Playing ]]; then
            title=$(playerctl metadata | grep title | grep -oP 'title\s+\K.*')
            echo "{\"text\": \"${title}\", \"class\": \"normal\"}" | jq --unbuffered --compact-output .
        else
            title="Nothin'"
            echo "{\"text\": \"${title}\", \"class\": \"normal\"}" | jq --unbuffered --compact-output .
        fi 
    done
}

metadata(){
    while true; do
        status=$(playerctl status)
        if [[ "$status" == Playing ]]; then
            artist=$(playerctl metadata | grep artist | grep -oP 'artist\s+\K.*')
            title=$(playerctl metadata | grep title | grep -oP 'title\s+\K.*')
            text="You're Listening to..."

            case $1 in
                title)
                    echo "{\"text\": \"${title}\", \"class\": \"normal\"}" | jq --unbuffered --compact-output .
                    ;;
                artist)
                    echo "{\"text\": \"${artist}\", \"class\": \"normal\"}" | jq --unbuffered --compact-output .
                    ;;
                text)
                    echo "{\"text\": \"${text}\", \"class\": \"normal\"}" | jq --unbuffered --compact-output .
                    ;;
            esac
        else
            artist="Unknown"
            title="Nothin'"
            text="You're listening?"

            case $1 in
                title)
                    echo "{\"text\": \"${title}\", \"class\": \"normal\"}" | jq --unbuffered --compact-output .
                    ;;
                artist)
                    echo "{\"text\": \"${artist}\", \"class\": \"normal\"}" | jq --unbuffered --compact-output .
                    ;;
                text)
                    echo "{\"text\": \"${text}\", \"class\": \"normal\"}" | jq --unbuffered --compact-output .
                    ;;
            esac
        fi
        sleep 1
    done
}

case $1 in
    percentage) percentage ;;
    title) title ;;
    artist)
        metadata artist
        ;;
    text)
        metadata text
        ;;
    image) image ;;
esac
