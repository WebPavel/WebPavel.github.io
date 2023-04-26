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
	"CreationDate" : "2023-04-26T19:03:36.468-00:00",
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
					"PackageIdentifier" : "Piriform.CCleaner",
					"Version" : "6.10"
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
					"PackageIdentifier" : "Gyan.FFmpeg",
					"Version" : "6.0"
				},
				{
					"PackageIdentifier" : "JetBrains.IntelliJIDEA.Ultimate",
					"Version" : "2021.1.3"
				},
				{
					"PackageIdentifier" : "JetBrains.IntelliJIDEA.Community",
					"Version" : "2023.1"
				},
				{
					"PackageIdentifier" : "Kingsoft.WPSOffice",
					"Version" : "11.2.0.11536"
				},
				{
					"PackageIdentifier" : "Microsoft.EdgeWebView2Runtime"
				},
				{
					"PackageIdentifier" : "Microsoft.WindowsTerminal",
					"Version" : "1.16.10261.0"
				},
				{
					"PackageIdentifier" : "Mozilla.Firefox",
					"Version" : "112.0.1"
				},
				{
					"PackageIdentifier" : "Mozilla.Thunderbird",
					"Version" : "102.10.0"
				},
				{
					"PackageIdentifier" : "OBSProject.OBSStudio",
					"Version" : "29.0.2"
				},
				{
					"PackageIdentifier" : "Postman.Postman",
					"Version" : "10.13.0"
				},
				{
					"PackageIdentifier" : "SMPlayer.SMPlayer",
					"Version" : "22.2.0"
				},
				{
					"PackageIdentifier" : "Tencent.TIM",
					"Version" : "3.4.3.22064"
				},
				{
					"PackageIdentifier" : "VideoLAN.VLC",
					"Version" : "3.0.18"
				},
				{
					"PackageIdentifier" : "Tencent.WeChat",
					"Version" : "3.9.0.28"
				},
				{
					"PackageIdentifier" : "Rime.Weasel"
				},
				{
					"PackageIdentifier" : "WiresharkFoundation.Wireshark"
				},
				{
					"PackageIdentifier" : "Xmind.Xmind.8",
					"Version" : "3.7.9.201912052356"
				},
				{
					"PackageIdentifier" : "XnSoft.XnViewMP",
					"Version" : "1.4.4"
				},
				{
					"PackageIdentifier" : "EuSoft.Eudic",
					"Version" : "13.0.0.0"
				},
				{
					"PackageIdentifier" : "SoftDeluxe.FreeDownloadManager",
					"Version" : "6.19.0.5156"
				},
				{
					"PackageIdentifier" : "OpenJS.NodeJS.LTS",
					"Version" : "12.22.12"
				},
				{
					"PackageIdentifier" : "Microsoft.Edge",
					"Version" : "112.0.1722.58"
				},
				{
					"PackageIdentifier" : "Microsoft.VCRedist.2015+.x86",
					"Version" : "14.34.31938.0"
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
					"PackageIdentifier" : "Google.Chrome"
				},
				{
					"PackageIdentifier" : "VMware.WorkstationPro",
					"Version" : "15.5.6"
				},
				{
					"PackageIdentifier" : "Flameshot.Flameshot",
					"Version" : "12.1.0"
				},
				{
					"PackageIdentifier" : "Microsoft.VCRedist.2015+.x64",
					"Version" : "14.34.31938.0"
				},
				{
					"PackageIdentifier" : "Python.Python.3.8",
					"Version" : "3.8.10"
				}
			],
			"SourceDetails" : 
			{
				"Argument" : "https://cdn.winget.microsoft.com/cache",
				"Identifier" : "Microsoft.Winget.Source_8wekyb3d8bbwe",
				"Name" : "winget",
				"Type" : "Microsoft.PreIndexed.Package"
			}
		}
	],
	"WinGetVersion" : "1.4.10173"
}

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
winget import --no-upgrade --accept-package-agreements %~dp0/winget_export.json
pause >nul
exit

```
