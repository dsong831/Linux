#!/bin/bash

directory="${HOME}/bin/example_script/diary"

if [ ! -d "$directory" ]; then
    mkdir -p "$directory"
fi

diaryfile="${directory}/$(date '+%Y-%m-%d').txt"

if [ ! -e "$diaryfile" ]; then
    date '+%Y/%m/%d' >> "$diaryfile"
fi

vim "$diaryfile"