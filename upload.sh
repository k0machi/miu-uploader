#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
if [[ $# -gt 1 ]]; then
    for file in $@; do
        URL=$(curl -s -F meowfile_remote=@$file -F private_key=dc9dfc92a3ed606e83092f4e43793496 https://i.komachi.sh/getfile/ | jq .file -r)
        echo "${file#.+\/} uploaded to $URL"
    done
elif [[ -n $1 ]]; then
    URL=$(curl -F meowfile_remote=@$1 -F private_key=dc9dfc92a3ed606e83092f4e43793496 https://i.komachi.sh/getfile/ | jq .file -r)
    echo $URL | xclip -selection clipboard
else
    echo "No files to upload"
fi
