#!/bin/bash

set -eo pipefail
[[ $DEBUG ]] && set -x

get_se() {
  # Extract season and episode numbers

  [[ ${1} =~ ([0-9]{2}).([0-9]{2}) ]] && {
    season=${BASH_REMATCH[1]}
    episode=${BASH_REMATCH[2]}
  } || {
    return 1
  }
}

match_media() {
  # Attempt to match subtitle file to a media file

  local season=$1
  local episode=$2
  local mediafile="${3}"

  [[ ${mediafile} =~ ${season}.${episode} ]] && return 0 || return 1
}

newfname() {
  # Generate file name for subtitle file

  local subfile="${1}"
  local medianame="${2%.*}"
  local subext="${subfile##*.}"
  local newfilename="${medianame}.${language}.${subext}"
  echo "${newfilename}"
}

language=${SUBLANG:-en}

if [[ "$0" == "$BASH_SOURCE" ]]; then

shopt -s nullglob
declare -a srt_files      ; srt_files=( *.srt )
declare -a vid_files      ; vid_files=( *.mp4 *.mkv )

for srtfile in "${srt_files[@]}"; do
  offset=0; season=; episode=;

  echo "Checking: ${srtfile}"
  while [[ ${srtfile:$offset:5} =~ .{5} ]]; do
    get_se "${srtfile:$offset:5}" && break
    offset=$((offset + 1))
  done
  [[ $season && $episode ]] && {
    echo "... Resolved to Season ${season}, Episode ${episode}"

    for vidfile in "${vid_files[@]}"; do
      match_media $season $episode "${vidfile}" && \
        echo "... Match: ${vidfile}" && \
        break
    done
  } || {
    echo "... No match."
  }
done

fi
