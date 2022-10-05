#!/bin/bash

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
        read -p "Enter track title: " track_title
        eyeD3 --title "${track_title}" "mp3s/${new_filename}"
        read -p "Enter artist name: " artist_name
        eyeD3 --artist "${artist_name}" "mp3s/${new_filename}"
        read -p "Enter album name: " album_name
        eyeD3 --album "${album_name}" "mp3s/${new_filename}"
        read -p "Enter album artist: " album_artist
        eyeD3 --album-artist "${album_artist}" "mp3s/${new_filename}"
        eyeD3 --rename '$title - $artist' "mp3s/${new_filename}"
	done
done
