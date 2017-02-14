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

newfname() {
  # Generate file name for subtitle file

  local subfile="${1}"
  local medianame="${2%.*}"
  local subext="${subfile##*.}"
  local newfilename="${medianame}.${language}.${subext}"
  echo "${newfilename}"
}

prefix="$1"

shopt -s nullglob
declare -a srt_files
srt_files=( *.srt )

for srtfile in *.srt; do
  offset="0"
  while [[ ${srtfile:$offset:5} =~ .{5} ]]; do
    [[ ${srtfile:$offset:5} =~ ([0-9]{2}).([0-9]{2}) ]] && {
      season=${BASH_REMATCH[1]}
      episode=${BASH_REMATCH[2]}
      break
    }
    offset=$((offset + 1))
  done
  [[ $season && $episode ]] && {
    echo season $season episode $episode
  }

  for vidfile in *.${prefix}; do
    ::
  done
done
