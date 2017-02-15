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

  [[ ${mediafile} =~ ${season}[eEx]${episode} ]] && echo "$mediafile" && return 0 || return 1
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
declare -a media_exts     ; media_exts=( "mp4" "mkv" "avi" )
declare -a srt_files      ; srt_files=( *.srt )
declare -a vid_files      ; for ext in "${media_exts[@]}"; do vid_files+=( *.${ext} ); done
declare -a matched_subs   # Keep track of matched subs and their new filenames
declare -a existing_subs  # For subtitles that already match a media file
declare -a media_to_skip  # Media files that already have a matching sub file

# Find media files that already have properly named subtitles and
# store their names
for vidfile in "${vid_files[@]}"; do
  potential_subfile="${vidfile%.*}.${language}.srt"
  [[ -e "${potential_subfile}" ]] && \
    existing_subs+=( "${potential_subfile}" ) && \
    media_to_skip+=( "${vidfile}" )
done

for srtfile in "${srt_files[@]}"; do
  poffset=0; offset=0; season=; episode=;
  matched=${#matched_subs[@]}

  # Skip subtitle if it's one of the existing ones
  for existing_sub in "${existing_subs[@]}"; do
    [[ "${existing_sub}" == "${srtfile}" ]] && continue 2
  done

  echo "Checking: ${srtfile}"
  while [[ $poffset -lt ${#patterns[@]} ]]; do

    # Try to extract season and episode numbers
    # Note: get_se doesn't echo back but saves to $season and $episode
    patlength=${patterns[$poffset]}
    while [[ ${srtfile:$offset:$patlength} =~ .{$patlength} ]]; do
      get_se "${srtfile:$offset:$patlength}" "${patterns[$((poffset + 1))]}" && break
      offset=$((offset + 1))
    done

    [[ $season && $episode ]] && {
      echo "... Resolved to Season ${season}, Episode ${episode}"

      for vidfile in "${vid_files[@]}"; do

        # Skip media file if it already had a properly
        # named subtitle file
        for skips in "${media_to_skip[@]}"; do
          [[ "${skip}" == "${vidfile}" ]] && break 2
        done

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

# The rename part
offset=0; renames=0; skips=0;
while [[ $offset -lt ${#matched_subs[@]} ]]; do
  newname="${matched_subs[$((offset + 1))]}"
  [[ -e "${newname}" ]] && skips=$((skips + 1)) || {
    mv "${matched_subs[$offset]}" "${newname}"
    renames=$((renames + 1))
  }
  offset=$((offset + 2))
done
printf "Renames: %d  Skips: %d\n" $renames $skips

fi
