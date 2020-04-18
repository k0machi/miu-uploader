#!/bin/bash
set -eo pipefail
TOKEN=$(cat ~/.miukey || printf "err")
IFS=$'\n\t'
if [[ $# > 1 ]]; then
    for file in "$@"; do
        if [[ ! -e $file ]]; then
            echo "File not found: $file"
            continue
        fi
        URL=$(curl -s -F meowfile_remote=@$file -F private_key=$TOKEN https://i.komachi.sh/getfile/ | jq .file -r)
        if [[ -n "$DISPLAY" ]]; then
            notify-send "File Uploaded" "$URL"
        else
            echo "${file#.+\/} uploaded to $URL"
        fi
        
    done
elif [[ -n "$1" ]]; then
    if [[ ! -e "$1" ]]; then
        echo "File not found: $1"
        exit
    fi
    URL=$(curl -sS -F meowfile_remote=@"$1" -F private_key=$TOKEN https://i.komachi.sh/getfile/ | jq .file -r)
    if [[ -n "$DISPLAY" ]]; then
        printf "$URL" | xclip -selection clipboard
        notify-send "File Uploaded" "$URL"
    else
        printf "$URL\n"
    fi
else
    echo "No files to upload"
fi
