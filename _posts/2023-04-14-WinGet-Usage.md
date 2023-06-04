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
	"CreationDate" : "2023-06-04T15:40:42.627-00:00",
	"Sources" : 
	[
		{
			"Packages" : 
			[
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
					"Version" : "2004.2022.8.0"
				},
				{
					"PackageIdentifier" : "voidtools.Everything",
					"Version" : "1.4.1.1023"
				},
				{
					"PackageIdentifier" : "Telerik.Fiddler.Classic",
					"Version" : "5.0.20211.51073"
				},
				{
					"PackageIdentifier" : "Git.Git",
					"Version" : "2.34.1"
				},
				{
					"PackageIdentifier" : "JetBrains.IntelliJIDEA.Ultimate",
					"Version" : "2021.1.3"
				},
				{
					"PackageIdentifier" : "Microsoft.Edge",
					"Version" : "113.0.1774.57"
				},
				{
					"PackageIdentifier" : "Microsoft.EdgeWebView2Runtime",
					"Version" : "113.0.1774.57"
				},
				{
					"PackageIdentifier" : "Microsoft.WindowsTerminal.Preview",
					"Version" : "1.18.1462.0"
				},
				{
					"PackageIdentifier" : "OBSProject.OBSStudio",
					"Version" : "29.1.1"
				},
				{
					"PackageIdentifier" : "Postman.Postman",
					"Version" : "10.13.0"
				},
				{
					"PackageIdentifier" : "VideoLAN.VLC",
					"Version" : "> 3.0.17.4"
				},
				{
					"PackageIdentifier" : "WiresharkFoundation.Wireshark",
					"Version" : "4.0.6"
				},
				{
					"PackageIdentifier" : "TheDocumentFoundation.LibreOffice",
					"Version" : "7.5.3.2"
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
					"PackageIdentifier" : "Microsoft.DotNet.DesktopRuntime.6",
					"Version" : "6.0.16"
				},
				{
					"PackageIdentifier" : "sylikc.JPEGView",
					"Version" : "1.2.45.0"
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
		}
	],
	"WinGetVersion" : "1.4.11071"
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
%install% %~dp0/Microsoft.HEVCVideoExtension_2.0.61301.0_neutral_~_8wekyb3d8bbwe.AppxBundle
echo winget has installed!
winget import --no-upgrade --accept-package-agreements %~dp0/winget_export.json
pause >nul
exit

```
