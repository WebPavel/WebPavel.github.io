---
layout: post
title: "WinGet usage"
date: 2023-04-14
excerpt: "winget install apps."
tags: [WinGet, Windows 10]
comments: false
---



- winget_export.json

```json

{
  "$schema": "https://aka.ms/winget-packages.schema.2.0.json",
  "CreationDate": "2023-04-13T23:52:07.808-00:00",
  "Sources": [
    {
      "Packages": [
        {
          "PackageIdentifier": "JGraph.Draw"
        },
        {
          "PackageIdentifier": "7zip.7zip"
        },
        {
          "PackageIdentifier": "ShareX.ShareX"
        },
        {
          "PackageIdentifier": "voidtools.Everything"
        },
        {
          "PackageIdentifier": "Telerik.Fiddler.Classic"
        },
        {
          "PackageIdentifier": "Git.Git",
          "Version": "2.34.1"
        },
        {
          "PackageIdentifier": "Gyan.FFmpeg"
        },
        {
          "PackageIdentifier": "JetBrains.IntelliJIDEA.Ultimate",
          "Version": "2021.1.3"
        },
        {
          "PackageIdentifier": "JetBrains.IntelliJIDEA.Community"
        },
        {
          "PackageIdentifier": "Kingsoft.WPSOffice"
        },
        {
          "PackageIdentifier": "Microsoft.WindowsTerminal.Preview"
        },
        {
          "PackageIdentifier": "OBSProject.OBSStudio"
        },
        {
          "PackageIdentifier": "Postman.Postman"
        },
        {
          "PackageIdentifier": "VideoLAN.VLC"
        },
        {
          "PackageIdentifier": "Xmind.Xmind.8"
        },
        {
          "PackageIdentifier": "EuSoft.Eudic"
        },
        {
          "PackageIdentifier": "JavadMotallebi.NeatDownloadManager"
        },
        {
          "PackageIdentifier": "OpenJS.NodeJS.LTS",
          "Version": "12.22.12"
        },
        {
          "PackageIdentifier": "Microsoft.VCRedist.2015+.x64",
          "Version": "14.28.29325.2"
        },
        {
          "PackageIdentifier": "Microsoft.VisualStudioCode"
        },
        {
          "PackageIdentifier": "JohnMacFarlane.Pandoc"
        },
        {
          "PackageIdentifier": "Python.Python.3.8",
          "Version": "3.8.8"
        },
        {
          "PackageIdentifier": "Canonical.Ubuntu.2004"
        },
        {
          "PackageIdentifier": "WiresharkFoundation.Wireshark"
        },
        {
          "PackageIdentifier": "Daum.PotPlayer"
        },
        {
          "PackageIdentifier": "Google.Chrome"
        }
      ],
      "SourceDetails": {
        "Argument": "https://cdn.winget.microsoft.com/cache",
        "Identifier": "Microsoft.Winget.Source_8wekyb3d8bbwe",
        "Name": "winget",
        "Type": "Microsoft.PreIndexed.Package"
      }
    }
  ],
  "WinGetVersion": "1.4.10173"
}

```

- install msstore appx

```powershell

winget install 9NBLGGH5Q5FV -s msstore
winget install 9WZDNCRFJ3Q2 -s msstore
winget install 9P9TQF7MRM4R -s msstore
winget install 9WZDNCRFJBH4 -s msstore

```
