#!/bin/bash

# Search recursively current directory for mkv files
# For each mkv look for corrisponding mp4 file
# If not found then attempt to remux, no decoding, no encoding to mp4 file container
#
# Useful for converting mkv h264 files to mp4 for playing on apple tv , PS3

# Usage ./mkv_to_mp4.sh FILEDIR
# Where FILEDIR is the top dir you want to search and convert

# save and change IFS 
OLDIFS=$IFS
IFS=$'\n'


FILEDIR=${1:-"."}

mkv_files=( $(find $FILEDIR -name '*.mkv' -type f) )
mp4_files=( $(find $FILEDIR -name '*.mp4' -type f) )

# restore it
IFS=$OLDIFS

i=0
for mkv_file in "${mkv_files[@]}"
do
  j=0
  found=0

  while (( !found && j < ${#mp4_files[@]}))
  do
    mp4_file=${mp4_files[j]}
    if [ "${mp4_file%.*}" == "${mkv_file%.*}" ]
    then
      let j++
      found=1
    fi
    let j++
  done

  if [ $found -eq 1 ]
  then
    echo "${mkv_file} skipping mp4 found here: ${mp4_file}"
  else
    echo "${mkv_file} remuxing"
    ffmpeg -v error -i "${mkv_file}" -codec copy "${mkv_file%.*}.mp4"
    if [ "$?" -ne 0 ] && [ -f "${mkv_file%.*}.mp4" ]
    then
      rm "${mkv_file%.*}.mp4"
    fi
  fi

done

