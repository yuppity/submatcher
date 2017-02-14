#!/usr/bin/env bash

set -eo pipefail
[[ $DEBUG ]] && set -x

get_se() {
  # Extract season and episode numbers

  [[ ${1} =~ ${2} ]] && {
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

declare -a patterns
# Define patterns in pairs of 'length' and 'pattern'. Where
# 'length' is the number of chars to test at once and 'pattern'
# the actual pattern to test those 'length' chars against.
patterns+=( "5" "([0-9]{2}).([0-9]{2})" )

if [[ "$0" == "$BASH_SOURCE" ]]; then

shopt -s nullglob
declare -a srt_files      ; srt_files=( *.srt )
declare -a vid_files      ; vid_files=( *.mp4 *.mkv )
declare -a matched_subs

for srtfile in "${srt_files[@]}"; do
  poffset=0; offset=0; season=; episode=;
  matched=${#matched_subs[@]}

  echo "Checking: ${srtfile}"
  while [[ $poffset -lt ${#patterns[@]} ]]; do

    while [[ ${srtfile:$offset:5} =~ .{${patterns[$poffset]}} ]]; do
      get_se "${srtfile:$offset:5}" "${patterns[$((poffset + 1))]}" && break
      offset=$((offset + 1))
    done

    [[ $season && $episode ]] && {
      echo "... Resolved to Season ${season}, Episode ${episode}"

      for vidfile in "${vid_files[@]}"; do
        match_media $season $episode "${vidfile}" && \
          echo "... Match: ${vidfile}" && \
          matched_subs+=( "${srtfile}" ) && \
          matched_subs+=( "$(newfname "${srtfile}" "${vidfile}")" ) && \
          break 2
      done
    }

    poffset=$((poffset + 2))
  done

  [[ ${#matched_subs[@]} -eq $matched ]] && echo "... No match"
done

offset=0
while [[ $offset -lt ${#matched_subs[@]} ]]; do
  mv "${matched_subs[$offset]}" "${matched_subs[$((offset + 1))]}"
  offset=$((offset + 2))
done

fi
