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
	"$schema" : "https://aka.ms/winget-packages.schema.2.0.json",
	"CreationDate" : "2023-04-15T22:32:23.537-00:00",
	"Sources" : 
	[
		{
			"Packages" : 
			[
				{
					"PackageIdentifier" : "JGraph.Draw",
					"Version" : "21.1.2"
				},
				{
					"PackageIdentifier" : "7zip.7zip",
					"Version" : "22.01"
				},
				{
					"PackageIdentifier" : "ShareX.ShareX",
					"Version" : "15.0.0"
				},
				{
					"PackageIdentifier" : "Canonical.Ubuntu.2004",
					"Version" : "2004.2021.825.0"
				},
				{
					"PackageIdentifier" : "voidtools.Everything",
					"Version" : "1.4.1.1022"
				},
				{
					"PackageIdentifier" : "Telerik.Fiddler.Classic",
					"Version" : "5.0.20211.51073"
				},
				{
					"PackageIdentifier" : "GeekUninstaller.GeekUninstaller",
					"Version" : "1.5.1.163"
				},
				{
					"PackageIdentifier" : "Git.Git",
					"Version" : "2.34.1"
				},
				{
					"PackageIdentifier" : "Google.Chrome",
					"Version" : "112.0.5615.121"
				},
				{
					"PackageIdentifier" : "Gyan.FFmpeg",
					"Version" : "6.0"
				},
				{
					"PackageIdentifier" : "JetBrains.IntelliJIDEA.Ultimate",
					"Version" : "2021.1.3"
				},
				{
					"PackageIdentifier" : "JetBrains.IntelliJIDEA.Community",
					"Version" : "2022.3.1"
				},
				{
					"PackageIdentifier" : "Kingsoft.WPSOffice",
					"Version" : "11.2.0.11516"
				},
				{
					"PackageIdentifier" : "Microsoft.Edge",
					"Version" : "112.0.1722.39"
				},
				{
					"PackageIdentifier" : "Microsoft.EdgeWebView2Runtime",
					"Version" : "112.0.1722.39"
				},
				{
					"PackageIdentifier" : "Microsoft.WindowsTerminal.Preview",
					"Version" : "1.17.10234.0"
				},
				{
					"PackageIdentifier" : "OBSProject.OBSStudio",
					"Version" : "29.0.2"
				},
				{
					"PackageIdentifier" : "Postman.Postman",
					"Version" : "10.12.13"
				},
				{
					"PackageIdentifier" : "Daum.PotPlayer",
					"Version" : "230404"
				},
				{
					"PackageIdentifier" : "VideoLAN.VLC",
					"Version" : "3.0.18"
				},
				{
					"PackageIdentifier" : "WiresharkFoundation.Wireshark",
					"Version" : "4.0.4"
				},
				{
					"PackageIdentifier" : "Xmind.Xmind.8",
					"Version" : "3.7.9.201912052356"
				},
				{
					"PackageIdentifier" : "EuSoft.Eudic",
					"Version" : "13.0.0.0"
				},
				{
					"PackageIdentifier" : "JavadMotallebi.NeatDownloadManager",
					"Version" : "1.4"
				},
				{
					"PackageIdentifier" : "OpenJS.NodeJS.LTS",
					"Version" : "12.22.12"
				},
				{
					"PackageIdentifier" : "Microsoft.VCRedist.2015+.x64",
					"Version" : "14.32.31332.0"
				},
				{
					"PackageIdentifier" : "Microsoft.VisualStudioCode",
					"Version" : "1.77.3"
				},
				{
					"PackageIdentifier" : "JohnMacFarlane.Pandoc",
					"Version" : "3.1.2"
				},
				{
					"PackageIdentifier" : "Python.Python.3.8",
					"Version" : "3.8.8"
				}
			],
			"SourceDetails" : 
			{
				"Argument" : "https://cdn.winget.microsoft.com/cache",
				"Identifier" : "Microsoft.Winget.Source_8wekyb3d8bbwe",
				"Name" : "winget",
				"Type" : "Microsoft.PreIndexed.Package"
			}
		},
		{
			"Packages" : 
			[
				{
					"PackageIdentifier" : "9NBLGGH5Q5FV",
					"Version" : "2.14.91.0"
				},
				{
					"PackageIdentifier" : "9NBLGGH0L44H",
					"Version" : "2020.1.21621.0"
				},
				{
					"PackageIdentifier" : "9WZDNCRFJ3Q2",
					"Version" : "4.53.50501.0"
				},
				{
					"PackageIdentifier" : "9WZDNCRFJBH4",
					"Version" : "2023.10030.7003.0"
				},
				{
					"PackageIdentifier" : "9P9TQF7MRM4R",
					"Version" : "1.2.0.0"
				}
			],
			"SourceDetails" : 
			{
				"Argument" : "https://storeedgefd.dsx.mp.microsoft.com/v9.0",
				"Identifier" : "StoreEdgeFD",
				"Name" : "msstore",
				"Type" : "Microsoft.Rest"
			}
		}
	],
	"WinGetVersion" : "1.4.10173"
}

```

- install msstore appx

```powershell

winget install 9NBLGGH5Q5FV -s msstore
winget install 9WZDNCRFJ3Q2 -s msstore
winget install 9P9TQF7MRM4R -s msstore
winget install 9WZDNCRFJBH4 -s msstore

```

- add-store.cmd

```bat

@echo off
set "install=PowerShell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass add-appxpackage"
%install% %~dp0/Microsoft.VCLibs.140.00_14.0.30704.0_x64__8wekyb3d8bbwe.Appx
%install% %~dp0/Microsoft.VCLibs.140.00.UWPDesktop_14.0.30704.0_x64__8wekyb3d8bbwe.Appx
%install% %~dp0/Microsoft.UI.Xaml.2.7_7.2208.15002.0_x64__8wekyb3d8bbwe.Appx
%install% %~dp0/Microsoft.DesktopAppInstaller_2021.1207.203.0_neutral_~_8wekyb3d8bbwe.AppxBundle
%install% %~dp0/Microsoft.HEVCVideoExtensions_2.0.53349.0_x64__8wekyb3d8bbwe.Appx
echo everything is ready!
winget import --no-upgrade %~dp0/winget_export.json
pause >nul
exit

```
