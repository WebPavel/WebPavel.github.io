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
	"CreationDate": "2023-04-26T19:03:36.468-00:00",
	"Sources": [
		{
			"Packages": [
				{
					"PackageIdentifier": "7zip.7zip"
				},
				{
					"PackageIdentifier": "Piriform.CCleaner"
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
					"PackageIdentifier": "JetBrains.IntelliJIDEA.Ultimate",
					"Version": "2021.1.3"
				},
				{
					"PackageIdentifier": "JetBrains.IntelliJIDEA.Community"
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
					"PackageIdentifier": "OpenJS.NodeJS.LTS",
					"Version": "12.22.12"
				},
				{
					"PackageIdentifier": "Microsoft.VCRedist.2015+.x86"
				},
				{
					"PackageIdentifier": "Microsoft.VisualStudioCode"
				},
				{
					"PackageIdentifier": "JohnMacFarlane.Pandoc"
				},
				{
					"PackageIdentifier": "Flameshot.Flameshot"
				},
				{
					"PackageIdentifier": "JavadMotallebi.NeatDownloadManager"
				},
				{
					"PackageIdentifier": "Microsoft.VCRedist.2015+.x64"
				},
				{
					"PackageIdentifier": "Python.Python.3.8"
				}
			],
			"SourceDetails": {
				"Argument": "https://cdn.winget.microsoft.com/cache",
				"Identifier": "Microsoft.Winget.Source_8wekyb3d8bbwe",
				"Name": "winget",
				"Type": "Microsoft.PreIndexed.Package"
			}
		},
		{
			"Packages": [
				{
					"PackageIdentifier": "9NBLGGH5Q5FV"
				},
				{
					"PackageIdentifier": "9NBLGGH0L44H"
				},
				{
					"PackageIdentifier": "9WZDNCRFJ3Q2"
				},
				{
					"PackageIdentifier": "9WZDNCRFJBH4"
				},
				{
					"PackageIdentifier": "9P9TQF7MRM4R"
				},
				{
					"PackageIdentifier": "9MVVSZK43QQW"
				},
				{
					"PackageIdentifier": "9NSGM705MQWC"
				},
				{
					"PackageIdentifier": "9NNPTJJGTLFJ"
				},
				{
					"PackageIdentifier": "9MSVKQC78PK6"
				},
				{
					"PackageIdentifier": "9N0DX20HK701"
				},
				{
					"PackageIdentifier": "9WZDNCRFHVQM"
				}
			],
			"SourceDetails": {
				"Argument": "https://storeedgefd.dsx.mp.microsoft.com/v9.0",
				"Identifier": "StoreEdgeFD",
				"Name": "msstore",
				"Type": "Microsoft.Rest"
			}
		}
	],
	"WinGetVersion": "1.4.10173"
}

```


- add-store.cmd

```bat

@echo off
set "install=PowerShell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass Add-AppxPackage"
%install% %~dp0/Microsoft.VCLibs.140.00_14.0.30704.0_x64__8wekyb3d8bbwe.Appx
%install% %~dp0/Microsoft.VCLibs.140.00.UWPDesktop_14.0.30704.0_x64__8wekyb3d8bbwe.Appx
%install% %~dp0/Microsoft.UI.Xaml.2.7_7.2208.15002.0_x64__8wekyb3d8bbwe.Appx
%install% %~dp0/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
%install% %~dp0/Microsoft.HEVCVideoExtensions_2.0.53349.0_x64__8wekyb3d8bbwe.Appx
echo winget has installed!
winget import --no-upgrade --accept-package-agreements %~dp0/winget_export.json
pause >nul
exit

```
