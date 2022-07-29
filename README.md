# Soundcloud Downloader

Bash script to download tracks/playlists/albums from Soundcloud in high quality (256 AAC), converting this to 320 MP3 and attaching the album artwork.

## Pre-requisites
- [Homebrew](https://brew.sh/)
- youtube-dl
    - Can install with `brew install youtube-dl` on macOS.
- ffmpeg
    - Can install with `brew install ffmpeg` on macOS.
- eyeD3
    - `pip3 install eyeD3`

It requires setting 'sc_oauth' variable to your Soundcloud oauth token as well.
To get your `oauth` token open the developer tools on your browser whilst on Soundcloud and look at the Cookies (under the Storage tab in Firefox, Application in Chrome) and find the `oauth_token` value and copy it. Paste this value after the `Authorization:OAuth` that is aleady in the `sc_oauth` variable at the top of the script.

## Usage
 
To use the script simply make sure it is executable by running:

`chmod +x soundcloud-downloader.sh`

and then running it whilst passing in a valid Souncloud link, like so:

`./soundcloud-downloader.sh https://soundcloud.com/taapionrecords/sarai`

The script converts the high quality 256 AAC file Soundcloud provides into
a 320 MP3 file. Because it is a lossy > lossy transcode there is mild loss
of quality however the resulting file is still greater than the normal 128
MP3 file that Soundcloud regularly streams out and as a result what other
downloaders will provide.