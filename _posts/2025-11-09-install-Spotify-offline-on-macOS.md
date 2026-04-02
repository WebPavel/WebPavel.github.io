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
https://community.spotify.com/t5/Desktop-Mac/Download-for-Mac/td-p/693196).

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

*Important*:

> Since Spotify now officially supports Apple Silicon architecture, the approach described above has been deprecated, and the latest approach can be found in this article [macOS personal configuration](/_posts/2026-03-24-macOS-personal-configuration.md).

## Reference

- [Sample shell scripts for Intune admins.](https://github.com/microsoft/shell-intune-samples)
