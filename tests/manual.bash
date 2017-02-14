#!/usr/bin/env bash

declare -a test_files
test_files+=( "Community - 02x19 - Critical Film Studies.720p.WEB-DL.HoodBag.English.C.orig.Addic7ed.com.srt" )
test_files+=( "Community - 03x01 - Biology 101.720p.WEB-DL.HoodBag.English.C.orig.Addic7ed.com.srt" )
test_files+=( "Community.303.Biology 101.720p.WEB-DL.HoodBag.English.C.orig.Addic7ed.com.srt" )
test_files+=( "Community S03E01 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
test_files+=( "Community S03E03 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
test_files+=( "Community S03E10 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
test_files+=( "Community S03E11 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
test_files+=( "Community S03E18 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
test_files+=( "Community S03E19 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
test_files+=( "Community S03E20 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
test_files+=( "Community S03E21 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )

mkdir test_dir
for testfile in "${test_files[@]}"; do
  touch "test_dir/${testfile}"
done
