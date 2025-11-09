#!/usr/bin/env bash

curl --request GET -skRL \
     --url 'https://download.spotify.com/Spotify.dmg' \
     -o ~/Downloads/Compressed/dmg/Spotify.dmg
hdiutil attach ~/Downloads/Compressed/dmg/Spotify.dmg
ditto /Volumes/Spotify/Spotify.app /Applications/Spotify.app
hdiutil detach /Volumes/Spotify
# rm ~/Downloads/Compressed/dmg/Spotify.dmg
