#!/bin/bash


while true; do
    check=$(playerctl status)
    if [[ "$check" == Playing ]]; then
        echo "{\"text\": \"\", \"class\": \"play\"}" | jq --unbuffered --compact-output .
    else
        echo "{\"text\": \"\", \"class\": \"stop\"}" | jq --unbuffered --compact-output .
    fi
done
