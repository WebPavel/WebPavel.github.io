---
layout: post
title: "Modify the trial period of Eudic"
date: 2025-08-31
excerpt: "Modify the trial period of Eudic on MacOS."
tags: [ Eudic, trial, MacOS ]
comments: true
---

# Modify the trial period of Eudic

## choose your tools to modify the plist file

I choose [VSCode](https://code.visualstudio.com/), and install extension [Binary Plist](https://marketplace.visualstudio.com/items?itemName=dnicolson.binary-plist)

## edit the property MAIN_TimesLeft

search and find the property MAIN_TimesLeft in plist file `~/Library/Preferences/com.eusoft.eudic.plist`, then edit the
attribute value to an integer which means the left days of trial period, for example, 36500 (100 years).
