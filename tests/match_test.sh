#!/usr/bin/env bash

source submatcher.bash

declare -a attempts
#   1. Name of subtitle file
#   2. Name of media file
#   3. Season nr the script should detect
#   4. Episode nr the script should detect
#   5. Expected exit code from the match function (0 = match, 1 = no match)
attempts+=(
  "Community - 02x19 - Critical Film Studies.720p.WEB-DL.HoodBag.English.C.orig.Addic7ed.com.srt"
  "Community S03E02 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4"
  "02" "19" 1
)
attempts+=(
  "Community - 03x10 - Biology 101.720p.WEB-DL.HoodBag.English.C.orig.Addic7ed.com.srt"
  "Community S03E10 1080p WEB-DL AAC2.0 AVC-TrollHD.mkv"
  "03" "10" 0
)
attempts+=(
  "Some.Random.TV.Show.S03E06.Episode.Title.720p.WEB-DL.srt"
  "Another.Random.Show.03x06.1080p.mkv"
  "03" "06" 0
)

fails=0; testnr=0; passes=0; skip=0; count=0
while [[ $skip -lt ${#attempts[@]} ]]; do
  season=; episode=; count=$((count + 1))

  isubtitle=$((skip))   ; imedia=$((skip + 1))
  iseason=$((skip + 2)) ; iepisode=$((skip + 3))
  iresult=$((skip + 4)) ; skip=$((skip + 5))

  echo "Testing ${attempts[$isubtitle]}"
  echo "against ${attempts[$imedia]}"

  { # Test season and episode extraction
  testnr=$((testnr + 1))
  echo "... Testing season/episode extraction"

  poffset=0; offset=0
  srtfile="${attempts[$isubtitle]}"
  while [[ $poffset -lt ${#patterns[@]} ]]; do
    patlength=${patterns[$poffset]}
    while [[ ${srtfile:$offset:$patlength} =~ .{$patlength} ]]; do
      get_se "${srtfile:$offset:$patlength}" "${patterns[$((poffset + 1))]}" && \
        break
      offset=$((offset + 1))
    done
    poffset=$((poffset + 2))
  done

  [[ "$season" == "${attempts[$iseason]}" && \
    "$episode" == "${attempts[$iepisode]}" ]] && {
      echo "... Result: passed"; passes=$((passes + 1))
    } || {
      echo "... Result: failed"; fails=$((fails + 1))
    }
  } # End of season and episode extraction tests

  { # Test matching function
  testnr=$((testnr + 1))
  echo "... Testing for correct match"
  match_media $season $episode "${attempts[$imedia]}" && res=0 || res=1
  [[ $res -eq ${attempts[$iresult]} ]] && {
    echo "... Result: passed"; passes=$((passes + 1))
  } || {
    echo "... Result: failed"; fails=$((fails + 1))
  }
  echo ""
  } # End of mathching function tests
 
done

printf "\nTests %d  Failed %d\n" $testnr $fails

[[ $fails -eq 0 ]] && exit 0 || exit 1
