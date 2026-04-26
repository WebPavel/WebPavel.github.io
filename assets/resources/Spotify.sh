#!/usr/bin/env bash

curl --request GET -skRL \
     --url 'https://download.scdn.co/SpotifyARM64.dmg' \
     -o ~/Downloads/Compressed/dmg/SpotifyARM64.dmg
hdiutil attach ~/Downloads/Compressed/dmg/SpotifyARM64.dmg
ditto /Volumes/Spotify/Spotify.app /Applications/Spotify.app
hdiutil detach /Volumes/Spotify
# rm ~/Downloads/Compressed/dmg/SpotifyARM64.dmg
