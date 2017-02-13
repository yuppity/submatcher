#!/bin/bash

set -eo pipefail
[[ $DEBUG ]] && set -x

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

#Community - 03x01 - Biology 101.720p.WEB-DL.HoodBag.English.C.orig.Addic7ed.com.srt
#Community S03E01 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4
#Community S03E02 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4
##perl -pe 's/.*?([0-9]{2}).?([0-9]{2}).*/\1\2/p;'

