#!/bin/bash
set -e
WATCH=${WATCH:-/watch}
OUTPUT=${OUTPUT:-/output}
STORAGE=${STORAGE:-/storage}

run() {
  cd "$WATCH" || exit
  FILES=$(find . -type f -not -path '*/\.*'  | egrep '.*')
  cd ..
  echo "$FILES" | while read -r FILE
  do
    process "$FILE"
  done;
}

process() {
  file=$1
  filepath=${file:2}
  input="$WATCH"/"$filepath"
  destination="$STORAGE"/"${filepath%.*}"."$EXTENSION"
  cd "$STORAGE" && mkdir -p "$(dirname "$filepath")" && cd ..

  echo $(date +"%Y-%m-%d-%T")

  trap 'exit' INT
  ffmpeg \
    -hide_banner \
    -y \
    -loglevel warning \
    -i "$input" \
    -ar 8000
    -ac 1
    -c:a pcm_mulaw \
    "$destination"

  killall ffmpeg >/dev/null

  echo "Finished encoding $filepath"
  echo $(date +"%Y-%m-%d-%T")

  path=${filepath%/*}
  mv "$STORAGE"/"$path" "$OUTPUT"/"$path"
  rm -rf "$WATCH"/"$path"
}

processes=$(ps aux | grep -i "ffmpeg" | awk '{print $11}')
for i in $processes; do
  if [ "$i" == "ffmpeg" ] ;then
    echo 'Waiting for current econding to complete...'
    exit 0
  fi
done

run
