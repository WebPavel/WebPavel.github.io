---
layout: post
title: "install Spotify offline on macOS"
date: 2025-11-09
excerpt: "How to install Spotify offline on macOS."
tags: [ Spotify, offline installation, macOS ]
comments: true
---


# install Spotify offline on macOS

"How to install Spotify offline on macOS", I have been troubled by this problem for a long time, util today when I read this [article](
https://community.spotify.com/t5/Desktop-Mac/Download-for-Mac/td-p/693196) .

```shell

#!/usr/bin/env bash

curl --request GET -skRL \
     --url 'https://download.spotify.com/Spotify.dmg' \
     -o ~/Downloads/Compressed/dmg/Spotify.dmg
hdiutil attach ~/Downloads/Compressed/dmg/Spotify.dmg
ditto /Volumes/Spotify/Spotify.app /Applications/Spotify.app
hdiutil detach /Volumes/Spotify
# rm ~/Downloads/Compressed/dmg/Spotify.dmg

```
