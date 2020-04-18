#!/bin/bash
set -eo pipefail

usage() {
    MSG=$(
        cat <<USAGE
usage: miupload file1 [file2] [file3] ...

USAGE
    )
    if [ -t 0 ]; then
        printf "%s" "$MSG"
    else
        zenity --info --title "MIU Client" \
            --text="Upload a file to Miu by either opening it with this program or drag and dropping it onto the application icon" \
            --width 256
    fi
}

upload() {
    local file="$1"
    curl -sS -F meowfile_remote=@"$file" -F private_key="$TOKEN" https://i.komachi.sh/getfile/ | jq .file -r
}

TOKEN=$(cat ~/.miukey || printf "err")
IFS=$'\n\t'
if [[ $# -gt 1 ]]; then
    for file in "$@"; do
        if [[ ! -e "$file" ]]; then
            echo "File not found: $file"
            continue
        fi

        URL=$(upload "$file")

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
    URL=$(upload "$1")
    if [[ -n "$DISPLAY" ]]; then
        printf "%s" "$URL" | xclip -selection clipboard
        notify-send "File Uploaded" "$URL"
    else
        printf '%s\n' "$URL"
    fi
else
    usage
fi
