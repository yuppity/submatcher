#!/usr/bin/env bash

TDIR="test_dir/processed"
TESTS="tests"

declare -a test_files
test_files+=( "Community - 02x19 - Critical Film Studies.720p.WEB-DL.HoodBag.English.C.orig.Addic7ed.com.srt" )
test_files+=( "Community - 03x01 - Biology 101.720p.WEB-DL.HoodBag.English.C.orig.Addic7ed.com.srt" )
test_files+=( "Community - 03x02 - Biology 101.720p.WEB-DL.HoodBag.English.C.orig.Addic7ed.com.srt" )
test_files+=( "Community - 03x10 - Biology 101.720p.WEB-DL.HoodBag.English.C.orig.Addic7ed.com.srt" )
test_files+=( "Community.303.Biology 101.720p.WEB-DL.HoodBag.English.C.orig.Addic7ed.com.srt" )
test_files+=( "Community S03E02 1080p WEB-DL AAC2.0 AVC-TrollHD.en.srt" )
test_files+=( "Community S03E01 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
test_files+=( "Community S03E02 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
test_files+=( "Community S03E03 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
test_files+=( "Community S03E10 1080p WEB-DL AAC2.0 AVC-TrollHD.mkv" )
test_files+=( "Community S03E11 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
test_files+=( "Community S03E18 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
test_files+=( "Community S03E19 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
test_files+=( "Community S03E20 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
test_files+=( "Community S03E21 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
test_files+=( "Zoo S01E05 Some episode.srt")
test_files+=( "flhd-zoos01e05-1080p.mkv" )

declare -a expected_files
expected_files+=( "Community - 02x19 - Critical Film Studies.720p.WEB-DL.HoodBag.English.C.orig.Addic7ed.com.srt" )
expected_files+=( "Community - 03x02 - Biology 101.720p.WEB-DL.HoodBag.English.C.orig.Addic7ed.com.srt" )
expected_files+=( "Community.303.Biology 101.720p.WEB-DL.HoodBag.English.C.orig.Addic7ed.com.srt" )
expected_files+=( "Community S03E01 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
expected_files+=( "Community S03E01 1080p WEB-DL AAC2.0 AVC-TrollHD.en.srt" )
expected_files+=( "Community S03E02 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
expected_files+=( "Community S03E02 1080p WEB-DL AAC2.0 AVC-TrollHD.en.srt" )
expected_files+=( "Community S03E03 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
expected_files+=( "Community S03E10 1080p WEB-DL AAC2.0 AVC-TrollHD.mkv" )
expected_files+=( "Community S03E10 1080p WEB-DL AAC2.0 AVC-TrollHD.en.srt" )
expected_files+=( "Community S03E11 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
expected_files+=( "Community S03E18 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
expected_files+=( "Community S03E19 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
expected_files+=( "Community S03E20 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
expected_files+=( "Community S03E21 1080p WEB-DL AAC2.0 AVC-TrollHD.mp4" )
expected_files+=( "flhd-zoos01e05-1080p.mkv" )
expected_files+=( "flhd-zoos01e05-1080p.en.srt" )
