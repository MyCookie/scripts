#!/bin/bash

echo $(pwd)

mkdir x265

for f in *.mkv
do
    echo "Encoding $f"
    echo ""
    ffmpeg -i $f -c:v libx265 -x265-params crf=18 -c:a copy ./x265/$f
done

