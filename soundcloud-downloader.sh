#!/bin/bash

# Script to download tracks/playlists/albums from Soundcloud using youtube-dl.
# It requires setting 'sc_oauth' variable to your Soundcloud oauth token, if
# you wish to download in high quality (Soundcloud Go+ account needed).
# Before using the script make sure both youtube-dl is installed, as well as
# ffmpeg and eyeD3. Recommended install methods are (for mac):
# 'brew install youtube-dl'
# 'brew install ffmpeg'
# 'pip3 install eyeD3'
# 
# To use the script simply make sure it is executable by running:
# 'chmod +x soundcloud-downloader.sh'
# and then running it whilst passing in a valid Souncloud link, like so:
# './soundcloud-downloader.sh https://soundcloud.com/taapionrecords/sarai'
#
# The script converts the high quality 256 AAC file Soundcloud provides into
# a 320 MP3 file. Because it is a lossy > lossy transcode there is mild loss
# of quality however the resulting file is still greater than the normal 128
# MP3 file that Soundcloud regularly streams out and as a result what other
# downloaders will provide.

sc_oauth=("Authorization:OAuth ")
dl="$1"

if [ -d "mp3s" ]; then
	true
else
	echo "No mp3s directory found, creating..."
	mkdir "mp3s"
fi

echo "Beginning download of tracks..."
youtube-dl -f http_aac_256 --add-header "${sc_oauth[@]}" --write-thumbnail "${dl}"

for f in *.aac;
do
	m4a_filename=$(echo "${f}" | sed 's/.aac$/.m4a/g')
	mv "${f}" "${m4a_filename}"
	for t in *.m4a;
	do
        	echo "Converting file to 320Kbps MP3"
		new_filename=$(echo "${t}" | sed 's/.m4a$/.mp3/g')
        	ffmpeg -i "${t}" -acodec libmp3lame -ab 320k "mp3s/${new_filename}"	
		echo "Attaching artwork to new file"
		cover_art=$(echo "${t}" | sed 's/.m4a$/.jpg/g')
		eyeD3 --add-image "${cover_art}":FRONT_COVER "mp3s/${new_filename}"
		rm "${t}" && rm "${cover_art}"
	done
done
