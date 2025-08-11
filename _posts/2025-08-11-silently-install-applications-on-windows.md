---
layout: post
title:  "Silently install applications on Windows"
date:   2025-08-11
excerpt: "One-click download and install common software and applications on Windows 11."
tags: [silently install, Unattended installation, applications installation, PowerShell, Windows]
comments: true
---

# Silently install applications on Windows 11

As a developer for a long time, I manually click the next button step by step each time I install software and applications.
when I switch to a new environment or another computer, I have to speed such much time to prepare for this work, which mostly ends up wasting a lot of your valuable time.
Therefore, I recently make some effort to write a set of scripts to automatically install your need software and applications by reading a CSV format file.

# 开发环境配置

## Git 环境配置

### Git Windows 环境安装

参考 [How to Install Git for Windows Silently](https://hatchjs.com/git-for-windows-silent-install/)

把下面脚本保存为`install-git.bat`，然后运行来安装 git

```bat
@echo off

rem Set the installation directory.
set INSTALL_DIR=C:\Program Files\Git

rem Download the latest version of the Git installer.
curl -LO https://github.com/git-for-windows/git/releases/download/v2.50.1.windows.1/Git-2.50.1-64-bit.exe

rem Install Git.
start /wait %~dp0\Git-2.50.1-64-bit.exe /SILENT /DIR=%INSTALL_DIR%

git version

rem Remove the installer.
del Git-2.50.1-64-bit.exe

pause
```

### Git 配置

参考 [Git - git-config 文档 - Git 版本控制系统](https://git-scm.cn/docs/git-config#ENVIRONMENT)

```shell
git config --global http.proxy http://127.0.0.1:10808
git config --global http.sslVerify false
git config --global user.name "paulluis"
git config --global user.email "paulluis.dev@gmail.com"
ssh-keygen -t rsa -b 4096 -C "paulluis.dev@gmail.com"
```

## Oh My Zsh

### 安装 Oh My Zsh

```shell
curl -LORk -o "MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -LORk -o "MesloLGS NF Bold.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -LORk -o "MesloLGS NF Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -LORk -o "MesloLGS NF Bold Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
sed -i 's@robbyrussell@powerlevel10k/powerlevel10k@' ~/.zshrc
```

## Java 环境配置

### Java Windows 环境安装

一。安装 JDK 和 JRE

```
@echo off
C:\Windows\System32\chcp.com 65001

%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

set INSTALL_DIR=C:\Java\jdk1.8.0_202
echo.
start /WAIT %~dp0\jdk-8u202-windows-x64.exe /s ADDLOCAL="ToolsFeature,SourceFeature,PublicjreFeature" INSTALLDIR=%INSTALL_DIR% WEB_JAVA=0 NOSTARTMENU=1
echo You have successfully installed JDK

setx JAVA_HOME %INSTALL_DIR% /M
setx PATH "%%JAVA_HOME%%\bin;%PATH%" /M

rem Remove the installer.
::del jdk-8u202-windows-x64.exe

pause
```

二。仅安装 JDK

参考 [Oracle Java 官网教程](https://docs.oracle.com/javase/8/docs/technotes/guides/install/windows_jdk_install.html)

安装可选配置参数 [Installing the JDK and the JRE with a Configuration File](https://docs.oracle.com/javase/8/docs/technotes/guides/install/config.html#table_config_file_options)

```bat
@echo off
C:\Windows\System32\chcp.com 65001

%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

set INSTALL_DIR=C:\Java\jdk1.8.0_202
echo.
start /WAIT %~dp0\jdk-8u202-windows-x64.exe /s ADDLOCAL="ToolsFeature,SourceFeature" INSTALLDIR=%INSTALL_DIR% WEB_JAVA=0 NOSTARTMENU=1
echo You have successfully installed JDK

setx JAVA_HOME %INSTALL_DIR% /M
setx PATH "%%JAVA_HOME%%\bin;%PATH%" /M

rem Remove the installer.
::del jdk-8u202-windows-x64.exe

pause
```

### Node.js 安装

```bat
@echo off

rem Set the installation directory.
set INSTALL_DIR=C:\Program Files\nodejs

rem Download the lts version of the Node.js installer.
curl -LO https://nodejs.org/dist/v20.19.4/node-v20.19.4-x64.msi

rem Install Node.js.
::node-v20.19.4-x64.msi /passive INSTALLDIR="C:\Program Files\nodejs" /lv C:\log.txt
%~dp0\node-v20.19.4-x64.msi /passive INSTALLDIR="%INSTALL_DIR%"

node -v

rem Remove the installer.
del node-v20.19.4-x64.msi

pause
```

### 7-Zip 安装

参考官网 [Frequently Asked Questions (FAQ)](https://7-zip.org/faq.html)

```bat
@echo off

rem Set the installation directory.
set INSTALL_DIR=C:\Program Files\7-Zip

rem Download the latest version of the 7-Zip installer.
curl -LO https://7-zip.org/a/7z2500-x64.exe

rem Install 7-Zip.
start /wait %~dp0\7z2500-x64.exe /S /D="%INSTALL_DIR%"

rem Remove the installer.
del 7z2500-x64.exe

pause
```

### VSCode 安装

参考 [Question: How to silent install with "Open with Code" enabled? · Issue #14767 · microsoft/vscode](https://github.com/Microsoft/vscode/issues/14767)

```bat
@echo off

rem Set the installation directory.
set INSTALL_DIR=C:\Program Files\Microsoft VS Code

rem Download the latest version of the VSCode installer.
curl -LO https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user

rem Install VSCode.

::https://github.com/Microsoft/vscode/issues/14767
::https://jrsoftware.org/ishelp/index.php?topic=setupcmdline
start /wait %~dp0\VSCodeSetup-x64-1.102.1.exe /VERYSILENT /mergetasks="desktopicon,addcontextmenufiles,addcontextmenufolders" /DIR="%INSTALL_DIR%"

rem Remove the installer.
del VSCodeSetup-x64-1.102.1.exe

pause
```

# 常见软件整理列表

| app | name | install | package | download | home | curl | install_dir | params | ok_message                                                 | del_flag | link | link2 | after_install | verification | codepage | admin | fetch_mirrors | use_proxy | proxy | spec_dir |
| :--- | :--- |:--------| :--- |:---------| :--- | :--- | :--- | :--- |:-----------------------------------------------------------| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |:----------| :--- | :--- |
| 7-Zip | 7-Zip | 0       | 7z2501-x64.exe | 0        | https://7-zip.org/ | https://7-zip.org/a/7z2501-x64.exe | C:\Apps\7-Zip | /S |                                                            | 0 | https://7-zip.org/faq.html |  |  |  |  |  |  | 0         |  | /D="path" |
| DBeaver | DBeaver | 0       | dbeaver-ce-25.1.0-x86_64-setup.exe | 0        | https://dbeaver.io/ | https://dbeaver.io/files/25.1.0/dbeaver-ce-25.1.0-x86_64-setup.exe | C:\Apps\DBeaver | /S /allusers |                                                            | 0 | https://dbeaver.com/docs/dbeaver/Windows-Silent-Install/ | https://github.com/dbeaver/dbeaver/wiki/Windows-Silent-Install |  |  |  |  |  | 1         | http://127.0.0.1:10808 | /D=path |
| Eudic | Eudic | 0       | eudic_win.exe | 0        | https://www.eudic.net/v4/en/app/eudic | https://www.eudic.net/download/eudic_win.zip?v=2025-07-25 |  | /SD |                                                            | 0 |  |  |  |  |  |  |  | 0         |  |  |
| FDM | Free Download Manager | 0       | fdm_x64_setup.exe | 0        | https://www.freedownloadmanager.org/ | https://files2.freedownloadmanager.org/6/latest/fdm_x64_setup.exe | C:\Apps\Free Download Manager | /VERYSILENT /ALLUSERS | You have successfully installed FDM                        | 0 | https://jrsoftware.org/ishelp/index.php?topic=setupcmdline |  |  |  |  |  |  | 1         | http://127.0.0.1:10808 | /DIR="path" |
| FileZilla Server | FileZilla Server | 0       | FileZilla_Server_1.10.5_win64-setup.exe | 0        | https://filezilla-project.org/ | https://dl4.cdn.filezilla-project.org/server/FileZilla_Server_1.10.5_win64-setup.exe | C:\Apps\FileZilla Server | /S /user=all |                                                            | 0 | https://wiki.filezilla-project.org/Silent_Setup |  |  |  |  |  |  | 0         |  | /D=path |
| Firefox | Mozilla Firefox | 0       | Firefox Setup 140.1.0esr.exe | 0        | https://www.firefox.com/en-US/ | https://ftp.mozilla.org/pub/firefox/releases/140.1.0esr/win64/en-US/Firefox%20Setup%20140.1.0esr.exe | C:\Apps\Mozilla Firefox | /S /DesktopShortcut=false /MaintenanceService=false /TaskbarShortcut=false /PrivateBrowsingShortcut=false |                                                            | 0 | https://firefox-source-docs.mozilla.org/browser/installer/windows/installer/FullConfig.html |  |  |  |  |  |  | 0         |  | /InstallDirectoryPath="path" |
| FxSound | FxSound | 0       | fxsound_setup.exe | 0        | https://www.fxsound.com/ | https://github.com/fxsound2/fxsound-app/releases/download/latest/fxsound_setup.exe | C:\Apps\FxSound | /exenoui /exenoupdates |                                                            | 0 | https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec |  |  |  |  |  |  | 1         | http://127.0.0.1:10808 | APPDIR="path" |
| Git | Git | 0       | Git-2.50.1-64-bit.exe | 0        | https://gitforwindows.org/ | https://github.com/git-for-windows/git/releases/download/v2.50.1.windows.1/Git-2.50.1-64-bit.exe | C:\Apps\Git | /VERYSILENT |                                                            | 0 |  |  |  | git version |  |  |  | 1         | http://127.0.0.1:10808 | /DIR="path" |
| IDM | Internet Download Manager | 0       | idman642build42.exe | 0        | https://www.internetdownloadmanager.com/ | https://mirror2.internetdownloadmanager.com/idman642build42.exe |  | /skipdlgs |                                                            | 0 | https://www.internetdownloadmanager.com/register/new_faq/functions21.html |  |  |  |  |  |  | 0         |  |  |
| ImageGlass | ImageGlass | 0       | ImageGlass_9.3.2.520_x64.msi | 0        | https://imageglass.org/ | https://github.com/d2phap/ImageGlass/releases/download/9.3.2.520/ImageGlass_9.3.2.520_x64.msi | C:\Apps\ImageGlass | /passive |                                                            | 0 | https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec |  |  |  |  |  |  | 1         | http://127.0.0.1:10808 | APPDIR="path" |
| Java | JRE | 0       | jre-8u461-windows-x64.exe | 0        | https://www.java.com/en/ | https://javadl.oracle.com/webapps/download/AutoDL?BundleId=252322_68ce765258164726922591683c51982c | C:\Java\jre1.8.0_461 | /s INSTALL_SILENT=1 WEB_JAVA=0 NOSTARTMENU=1 |                                                            | 0 | https://www.java.com/en/download/help/silent_install.html |  | .\Java\after-install-jre.ps1 | java -version | 1 | 0 |  | 0         |  | INSTALLDIR=path |
| Java | JDK | 0       | jdk-8u202-windows-x64.exe | 0        | https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html | !!!important!!!Required login https://download.oracle.com/otn/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-windows-x64.exe | C:\Java\jdk1.8.0_202 | /s INSTALL_SILENT=1 ADDLOCAL="ToolsFeature,SourceFeature" NOSTARTMENU=1 |                                                            | 0 | https://www.java.com/en/download/help/silent_install.html |  | .\Java\after-install.ps1 | java -version | 1 | 0 |  | 0         |  | INSTALLDIR=path |
| MSYS2 | MSYS2 | 0       | msys2-base-x86_64-20250622.sfx.exe | 0        | https://www.msys2.org/ | https://github.com/msys2/msys2-installer/releases/download/2025-06-22/msys2-base-x86_64-20250622.sfx.exe | C:\Apps\ | -y |                                                            | 0 | https://www.msys2.org/docs/installer/ |  |  |  |  |  |  | 1         | http://127.0.0.1:10808 | -opath |
| Node.js | nodejs | 0       | node-v20.19.4-x64.msi | 0        | https://nodejs.org/en | https://nodejs.org/dist/v20.19.4/node-v20.19.4-x64.msi | C:\Apps\nodejs | /passive |                                                            | 0 | https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec |  |  | node -v |  |  |  | 0         |  | INSTALLDIR="path" |
| PeaZip | PeaZip | 0       | peazip-10.6.0.WIN64.exe | 0        | https://peazip.github.io/ | https://github.com/peazip/PeaZip/releases/download/10.6.0/peazip-10.6.0.WIN64.exe | C:\Apps\PeaZip | /VERYSILENT /ALLUSERS /MERGETASKS="!desktopicon" |                                                            | 0 | https://peazip.github.io/peazip-help-faq.html#run_peazip_on_microsoft_windows |  |  |  |  |  |  | 1         | http://127.0.0.1:10808 | /DIR="path" |
| Podman | Podman Desktop | 0       | podman-desktop-airgap-1.20.2-setup-x64.exe | 0        | https://podman-desktop.io/ | https://github.com/podman-desktop/podman-desktop/releases/download/v1.20.2/podman-desktop-airgap-1.20.2-setup-x64.exe | C:\Apps\Podman Desktop | /S |                                                            | 0 | https://podman-desktop.io/docs/installation/windows-install#silent-windows-installer | https://github.com/containers/podman/blob/main/build_windows.md | .\PodmanDesktop\after-install.ps1 |  |  |  |  | 1         | http://127.0.0.1:10808 | /D="path" |
| Postman | Postman | 0       | Postman-win64-9.31.28-Setup.exe | 0        | https://www.postman.com/ | https://dl.pstmn.io/download/version/9.31.28/win64 |  |  |                                                            | 0 | https://learning.postman.com/docs/administration/enterprise/managing-enterprise-deployment/ |  |  |  |  |  |  | 0         |  |  |
| PowerToys | PowerToys | 0       | PowerToysSetup-0.92.1-x64.exe | 0        | https://learn.microsoft.com/en-us/windows/powertoys/ | https://github.com/microsoft/PowerToys/releases/download/v0.92.1/PowerToysSetup-0.92.1-x64.exe | C:\Apps\PowerToys | /passive |                                                            | 0 | https://learn.microsoft.com/en-us/windows/powertoys/install#command-line-installer-arguments |  |  |  |  |  |  | 1         | http://127.0.0.1:10808 | InstallFolder="path" |
| Rime | Rime | 0       | weasel-0.17.4.0-installer.exe | 0        | https://rime.im/ | https://github.com/rime/weasel/releases/download/0.17.4/weasel-0.17.4.0-installer.exe |  | /S /ls /du /toggleime /release |                                                            | 0 | https://github.com/rime/weasel/blob/master/WeaselSetup/WeaselSetup.cpp#L163-L179 |  |  |  |  |  |  | 1         | http://127.0.0.1:10808 |  |
| ShareX | ShareX | 0       | ShareX-17.1.0-setup.exe | 0        | https://getsharex.com/ | https://github.com/ShareX/ShareX/releases/download/v17.1.0/ShareX-17.1.0-setup.exe | C:\Apps\ShareX | /VERYSILENT /NORUN |                                                            | 0 | https://getsharex.com/docs/command-line-arguments#sharex-setup-cli |  |  |  |  |  |  | 1         | http://127.0.0.1:10808 | /DIR="path" |
| SMPlayer | SMPlayer | 0       | smplayer-25.6.0-x64-unsigned.exe | 0        | https://smplayer.info/ | https://github.com/smplayer-dev/smplayer/releases/download/v25.6.0/smplayer-25.6.0-x64-unsigned.exe | C:\Apps\SMPlayer | /S | SMPlayer has been successfully installed on your computer. | 0 | https://nsis.sourceforge.io/Docs/Chapter3.html#3.2.1 |  |  |  |  |  |  | 1         | http://127.0.0.1:10808 | /D=path |
| Starship | starship | 0       | starship-x86_64-pc-windows-msvc.msi | 0        | https://starship.rs/ | https://github.com/starship/starship/releases/download/v1.23.0/starship-x86_64-pc-windows-msvc.msi | C:\Apps\starship | /passive |                                                            | 0 | https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec |  | .\.config\starship\starship.bat |  |  |  |  | 1         | http://127.0.0.1:10808 | APPLICATIONFOLDER="path" |
| Sumatra PDF | SumatraPDF | 0       | SumatraPDF-3.5.2-64-install.exe | 0        | https://www.sumatrapdfreader.org/free-pdf-reader | https://www.sumatrapdfreader.org/dl/rel/3.5.2/SumatraPDF-3.5.2-64-install.exe | C:\Apps\SumatraPDF | -s -with-preview |                                                            | 0 | https://www.sumatrapdfreader.org/docs/Installer-cmd-line-arguments |  |  |  |  |  |  | 0         |  | -d "path" |
| Tabby | Tabby | 0       | tabby-1.0.225-setup-x64.exe | 0        | https://tabby.sh/ | https://github.com/Eugeny/tabby/releases/download/v1.0.225/tabby-1.0.225-setup-x64.exe | C:\Apps\Tabby | /S /allusers |                                                            | 0 | https://github.com/Eugeny/tabby/issues |  |  |  |  |  |  | 1         | http://127.0.0.1:10808 | /D=path |
| ungoogled-chromium | ungoogled-chromium | 0       | ungoogled-chromium_138.0.7204.183-1.1_installer_x64.exe | 0        | https://github.com/ungoogled-software/ungoogled-chromium-windows | https://github.com/ungoogled-software/ungoogled-chromium-windows/releases/download/138.0.7204.183-1.1/ungoogled-chromium_138.0.7204.183-1.1_installer_x64.exe |  | --install --silent --do-not-launch-chrome --system-level |                                                            | 0 |  |  |  |  |  |  |  | 1         | http://127.0.0.1:10808 |  |
| Visual C++ Redistributable | Microsoft Visual C++ Redistributable | 0       | VC_redist.x64.exe | 0        | https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170 | https://aka.ms/vs/17/release/vc_redist.x64.exe |  | /install /passive /norestart |                                                            | 0 | https://learn.microsoft.com/en-us/cpp/windows/redistributing-visual-cpp-files?view=msvc-170#command-line-options-for-the-redistributable-packages |  |  |  |  |  |  | 0         |  |  |
| Visual C++ Redistributable | Microsoft Visual C++ Redistributable | 0       | VC_redist.x86.exe | 0        | https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170 | https://aka.ms/vs/17/release/vc_redist.x86.exe |  | /install /passive /norestart |                                                            | 0 | https://learn.microsoft.com/en-us/cpp/windows/redistributing-visual-cpp-files?view=msvc-170#command-line-options-for-the-redistributable-packages |  |  |  |  |  |  | 0         |  |  |
| VSCode | Microsoft VS Code | 0       | VSCodeSetup-x64-1.102.1.exe | 0        | https://code.visualstudio.com/ | https://code.visualstudio.com/sha/download?build=stable&os=win32-x64 | C:\Apps\Microsoft VS Code | /VERYSILENT /mergetasks="!desktopicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,!runcode" |                                                            | 0 | https://jrsoftware.org/ishelp/index.php?topic=setupcmdline | https://github.com/Microsoft/vscode/blob/main/build/win32/code.iss |  |  |  |  |  | 0         |  | /DIR="path" |
| WinSCP | WinSCP | 0       | WinSCP-6.5.3-Setup.exe | 0        | https://winscp.net/eng/index.php | https://winscp.net/download/WinSCP-6.5.3-Setup.exe/download | C:\Apps\WinSCP | /LANG=2052 /VERYSILENT /ALLUSERS |                                                            | 0 | https://winscp.net/eng/docs/installation |  |  |  |  |  |  | 0         |  | /DIR="path" |
| XMind 8 | XMind | 0       | xmind-8-update9-windows.exe | 0        | https://xmind.com/download/xmind8/ | https://www.xmind.app/xmind/downloads/xmind-8-update9-windows.exe | C:\Apps\XMind | /VERYSILENT /LANG=2052 |                                                            | 0 | https://jrsoftware.org/ishelp/index.php?topic=setupcmdline |  |  |  |  |  |  | 0         |  | /DIR="path" |
| Zeal | Zeal | 0       | zeal-0.7.2-windows-x64.msi | 0        | https://zealdocs.org/ | https://github.com/zealdocs/zeal/releases/download/v0.7.2/zeal-0.7.2-windows-x64.msi | C:\Apps\Zeal | /passive |                                                            | 0 | https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec |  |  |  |  |  |  | 1         | http://127.0.0.1:10808 | INSTALL_ROOT="path" |
| PostgreSQL | PostgreSQL | 0 | postgresql-15.13-3-windows-x64.exe | 0 | https://www.postgresql.org/ | https://sbp.enterprisedb.com/getfile.jsp?fileid=1259617 | C:\Apps\PostgreSQL\15 | --create_shortcuts 1 --mode unattended --unattendedmodeui none --superaccount postgres --superpassword postgres --serverport 5432 --disable-components pgAdmin,stackbuilder --enable-components server,commandlinetools |  | 0 | https://www.enterprisedb.com/docs/supported-open-source/postgresql/installing/command_line_parameters/ |  | .\PostgreSQL\after-install.ps1 |  |  |  |  | 0         |                        | --prefix "path" --datadir "path\data" |

## CSV format file

```csv
app,name,install,package,download,home,curl,install_dir,params,ok_message,del_flag,link,link2,after_install,verification,codepage,admin,fetch_mirrors,use_proxy,proxy,spec_dir
7-Zip,7-Zip,0,7z2501-x64.exe,0,https://7-zip.org/,https://7-zip.org/a/7z2501-x64.exe,C:\Apps\7-Zip,/S,"",0,https://7-zip.org/faq.html,"","","","","","",0,"","/D=""path"""
DBeaver,DBeaver,0,dbeaver-ce-25.1.0-x86_64-setup.exe,0,https://dbeaver.io/,https://dbeaver.io/files/25.1.0/dbeaver-ce-25.1.0-x86_64-setup.exe,C:\Apps\DBeaver,/S /allusers,"",0,https://dbeaver.com/docs/dbeaver/Windows-Silent-Install/,https://github.com/dbeaver/dbeaver/wiki/Windows-Silent-Install,"","","","","",1,http://127.0.0.1:10808,/D=path
Eudic,Eudic,0,eudic_win.exe,0,https://www.eudic.net/v4/en/app/eudic,https://www.eudic.net/download/eudic_win.zip?v=2025-07-25,"",/SD,"",0,"","","","","","","",0,"",""
FDM,Free Download Manager,0,fdm_x64_setup.exe,0,https://www.freedownloadmanager.org/,https://files2.freedownloadmanager.org/6/latest/fdm_x64_setup.exe,C:\Apps\Free Download Manager,/VERYSILENT /ALLUSERS,You have successfully installed FDM,0,https://jrsoftware.org/ishelp/index.php?topic=setupcmdline,"","","","","","",1,http://127.0.0.1:10808,"/DIR=""path"""
FileZilla Server,FileZilla Server,0,FileZilla_Server_1.10.5_win64-setup.exe,0,https://filezilla-project.org/,https://dl4.cdn.filezilla-project.org/server/FileZilla_Server_1.10.5_win64-setup.exe,C:\Apps\FileZilla Server,/S /user=all,"",0,https://wiki.filezilla-project.org/Silent_Setup,"","","","","","",0,"",/D=path
Firefox,Mozilla Firefox,0,Firefox Setup 140.1.0esr.exe,0,https://www.firefox.com/en-US/,https://ftp.mozilla.org/pub/firefox/releases/140.1.0esr/win64/en-US/Firefox%20Setup%20140.1.0esr.exe,C:\Apps\Mozilla Firefox,/S /DesktopShortcut=false /MaintenanceService=false /TaskbarShortcut=false /PrivateBrowsingShortcut=false,"",0,https://firefox-source-docs.mozilla.org/browser/installer/windows/installer/FullConfig.html,"","","","","","",0,"","/InstallDirectoryPath=""path"""
FxSound,FxSound,0,fxsound_setup.exe,0,https://www.fxsound.com/,https://github.com/fxsound2/fxsound-app/releases/download/latest/fxsound_setup.exe,C:\Apps\FxSound,/exenoui /exenoupdates,"",0,https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec,"","","","","","",1,http://127.0.0.1:10808,"APPDIR=""path"""
Git,Git,0,Git-2.50.1-64-bit.exe,0,https://gitforwindows.org/,https://github.com/git-for-windows/git/releases/download/v2.50.1.windows.1/Git-2.50.1-64-bit.exe,C:\Apps\Git,/VERYSILENT,"",0,"","","",git version,"","","",1,http://127.0.0.1:10808,"/DIR=""path"""
IDM,Internet Download Manager,0,idman642build42.exe,0,https://www.internetdownloadmanager.com/,https://mirror2.internetdownloadmanager.com/idman642build42.exe,"",/skipdlgs,"",0,https://www.internetdownloadmanager.com/register/new_faq/functions21.html,"","","","","","",0,"",""
ImageGlass,ImageGlass,0,ImageGlass_9.3.2.520_x64.msi,0,https://imageglass.org/,https://github.com/d2phap/ImageGlass/releases/download/9.3.2.520/ImageGlass_9.3.2.520_x64.msi,C:\Apps\ImageGlass,/passive,"",0,https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec,"","","","","","",1,http://127.0.0.1:10808,"APPDIR=""path"""
Java,JRE,0,jre-8u461-windows-x64.exe,0,https://www.java.com/en/,https://javadl.oracle.com/webapps/download/AutoDL?BundleId=252322_68ce765258164726922591683c51982c,C:\Java\jre1.8.0_461,/s INSTALL_SILENT=1 WEB_JAVA=0 NOSTARTMENU=1,"",0,https://www.java.com/en/download/help/silent_install.html,"",.\Java\after-install-jre.ps1,java -version,1,0,"",0,"",INSTALLDIR=path
Java,JDK,0,jdk-8u202-windows-x64.exe,0,https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html,!!!important!!!Required login https://download.oracle.com/otn/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-windows-x64.exe,C:\Java\jdk1.8.0_202,"/s INSTALL_SILENT=1 ADDLOCAL=""ToolsFeature,SourceFeature"" NOSTARTMENU=1","",0,https://www.java.com/en/download/help/silent_install.html,"",.\Java\after-install.ps1,java -version,1,0,"",0,"",INSTALLDIR=path
MSYS2,MSYS2,0,msys2-base-x86_64-20250622.sfx.exe,0,https://www.msys2.org/,https://github.com/msys2/msys2-installer/releases/download/2025-06-22/msys2-base-x86_64-20250622.sfx.exe,C:\Apps\,-y,"",0,https://www.msys2.org/docs/installer/,"","","","","","",1,http://127.0.0.1:10808,-opath
Node.js,nodejs,0,node-v20.19.4-x64.msi,0,https://nodejs.org/en,https://nodejs.org/dist/v20.19.4/node-v20.19.4-x64.msi,C:\Apps\nodejs,/passive,"",0,https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec,"","",node -v,"","","",0,"","INSTALLDIR=""path"""
PeaZip,PeaZip,0,peazip-10.6.0.WIN64.exe,0,https://peazip.github.io/,https://github.com/peazip/PeaZip/releases/download/10.6.0/peazip-10.6.0.WIN64.exe,C:\Apps\PeaZip,"/VERYSILENT /ALLUSERS /MERGETASKS=""!desktopicon""","",0,https://peazip.github.io/peazip-help-faq.html#run_peazip_on_microsoft_windows,"","","","","","",1,http://127.0.0.1:10808,"/DIR=""path"""
Podman,Podman Desktop,0,podman-desktop-airgap-1.20.2-setup-x64.exe,0,https://podman-desktop.io/,https://github.com/podman-desktop/podman-desktop/releases/download/v1.20.2/podman-desktop-airgap-1.20.2-setup-x64.exe,C:\Apps\Podman Desktop,/S,"",0,https://podman-desktop.io/docs/installation/windows-install#silent-windows-installer,https://github.com/containers/podman/blob/main/build_windows.md,.\PodmanDesktop\after-install.ps1,"","","","",1,http://127.0.0.1:10808,"/D=""path"""
Postman,Postman,0,Postman-win64-9.31.28-Setup.exe,0,https://www.postman.com/,https://dl.pstmn.io/download/version/9.31.28/win64,"","","",0,https://learning.postman.com/docs/administration/enterprise/managing-enterprise-deployment/,"","","","","","",0,"",""
PowerToys,PowerToys,0,PowerToysSetup-0.92.1-x64.exe,0,https://learn.microsoft.com/en-us/windows/powertoys/,https://github.com/microsoft/PowerToys/releases/download/v0.92.1/PowerToysSetup-0.92.1-x64.exe,C:\Apps\PowerToys,/passive,"",0,https://learn.microsoft.com/en-us/windows/powertoys/install#command-line-installer-arguments,"","","","","","",1,http://127.0.0.1:10808,"InstallFolder=""path"""
Rime,Rime,0,weasel-0.17.4.0-installer.exe,0,https://rime.im/,https://github.com/rime/weasel/releases/download/0.17.4/weasel-0.17.4.0-installer.exe,"",/S /ls /du /toggleime /release,"",0,https://github.com/rime/weasel/blob/master/WeaselSetup/WeaselSetup.cpp#L163-L179,"","","","","","",1,http://127.0.0.1:10808,""
ShareX,ShareX,0,ShareX-17.1.0-setup.exe,0,https://getsharex.com/,https://github.com/ShareX/ShareX/releases/download/v17.1.0/ShareX-17.1.0-setup.exe,C:\Apps\ShareX,/VERYSILENT /NORUN,"",0,https://getsharex.com/docs/command-line-arguments#sharex-setup-cli,"","","","","","",1,http://127.0.0.1:10808,"/DIR=""path"""
SMPlayer,SMPlayer,0,smplayer-25.6.0-x64-unsigned.exe,0,https://smplayer.info/,https://github.com/smplayer-dev/smplayer/releases/download/v25.6.0/smplayer-25.6.0-x64-unsigned.exe,C:\Apps\SMPlayer,/S,SMPlayer has been successfully installed on your computer.,0,https://nsis.sourceforge.io/Docs/Chapter3.html#3.2.1,"","","","","","",1,http://127.0.0.1:10808,/D=path
Starship,starship,0,starship-x86_64-pc-windows-msvc.msi,0,https://starship.rs/,https://github.com/starship/starship/releases/download/v1.23.0/starship-x86_64-pc-windows-msvc.msi,C:\Apps\starship,/passive,"",0,https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec,"",.\.config\starship\starship.bat,"","","","",1,http://127.0.0.1:10808,"APPLICATIONFOLDER=""path"""
Sumatra PDF,SumatraPDF,0,SumatraPDF-3.5.2-64-install.exe,0,https://www.sumatrapdfreader.org/free-pdf-reader,https://www.sumatrapdfreader.org/dl/rel/3.5.2/SumatraPDF-3.5.2-64-install.exe,C:\Apps\SumatraPDF,-s -with-preview,"",0,https://www.sumatrapdfreader.org/docs/Installer-cmd-line-arguments,"","","","","","",0,"","-d ""path"""
Tabby,Tabby,0,tabby-1.0.225-setup-x64.exe,0,https://tabby.sh/,https://github.com/Eugeny/tabby/releases/download/v1.0.225/tabby-1.0.225-setup-x64.exe,C:\Apps\Tabby,/S /allusers,"",0,https://github.com/Eugeny/tabby/issues,"","","","","","",1,http://127.0.0.1:10808,/D=path
ungoogled-chromium,ungoogled-chromium,0,ungoogled-chromium_138.0.7204.183-1.1_installer_x64.exe,0,https://github.com/ungoogled-software/ungoogled-chromium-windows,https://github.com/ungoogled-software/ungoogled-chromium-windows/releases/download/138.0.7204.183-1.1/ungoogled-chromium_138.0.7204.183-1.1_installer_x64.exe,"",--install --silent --do-not-launch-chrome --system-level,"",0,"","","","","","","",1,http://127.0.0.1:10808,""
Visual C++ Redistributable,Microsoft Visual C++ Redistributable,0,VC_redist.x64.exe,0,https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170,https://aka.ms/vs/17/release/vc_redist.x64.exe,"",/install /passive /norestart,"",0,https://learn.microsoft.com/en-us/cpp/windows/redistributing-visual-cpp-files?view=msvc-170#command-line-options-for-the-redistributable-packages,"","","","","","",0,"",""
Visual C++ Redistributable,Microsoft Visual C++ Redistributable,0,VC_redist.x86.exe,0,https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170,https://aka.ms/vs/17/release/vc_redist.x86.exe,"",/install /passive /norestart,"",0,https://learn.microsoft.com/en-us/cpp/windows/redistributing-visual-cpp-files?view=msvc-170#command-line-options-for-the-redistributable-packages,"","","","","","",0,"",""
VSCode,Microsoft VS Code,0,VSCodeSetup-x64-1.102.1.exe,0,https://code.visualstudio.com/,https://code.visualstudio.com/sha/download?build=stable&os=win32-x64,C:\Apps\Microsoft VS Code,"/VERYSILENT /mergetasks=""!desktopicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,!runcode""","",0,https://jrsoftware.org/ishelp/index.php?topic=setupcmdline,https://github.com/Microsoft/vscode/blob/main/build/win32/code.iss,"","","","","",0,"","/DIR=""path"""
WinSCP,WinSCP,0,WinSCP-6.5.3-Setup.exe,0,https://winscp.net/eng/index.php,https://winscp.net/download/WinSCP-6.5.3-Setup.exe/download,C:\Apps\WinSCP,/LANG=2052 /VERYSILENT /ALLUSERS,"",0,https://winscp.net/eng/docs/installation,"","","","","","",0,"","/DIR=""path"""
XMind 8,XMind,0,xmind-8-update9-windows.exe,0,https://xmind.com/download/xmind8/,https://www.xmind.app/xmind/downloads/xmind-8-update9-windows.exe,C:\Apps\XMind,/VERYSILENT /LANG=2052,"",0,https://jrsoftware.org/ishelp/index.php?topic=setupcmdline,"","","","","","",0,"","/DIR=""path"""
Zeal,Zeal,0,zeal-0.7.2-windows-x64.msi,0,https://zealdocs.org/,https://github.com/zealdocs/zeal/releases/download/v0.7.2/zeal-0.7.2-windows-x64.msi,C:\Apps\Zeal,/passive,"",0,https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec,"","","","","","",1,http://127.0.0.1:10808,"INSTALL_ROOT=""path"""
PostgreSQL,PostgreSQL,0,postgresql-15.13-3-windows-x64.exe,0,https://www.postgresql.org/,https://sbp.enterprisedb.com/getfile.jsp?fileid=1259617,C:\Apps\PostgreSQL\15,"--create_shortcuts 1 --mode unattended --unattendedmodeui none --superaccount postgres --superpassword postgres --serverport 5432 --disable-components pgAdmin,stackbuilder --enable-components server,commandlinetools","",0,https://www.enterprisedb.com/docs/supported-open-source/postgresql/installing/command_line_parameters/,"",.\PostgreSQL\after-install.ps1,"","","","",0,"","--prefix ""path"" --datadir ""path\data"""
```

## 使用脚本

```powershell
function install_app
{
    param(
        [String]$name,
        [Int16]$install = 1,
        [String]$package,
        [Int16]$download = 1,
        [String]$curl,
        [String]$install_dir,
        [String]$params,
        [String]$ok_message,
        [Int16]$del_flag = 0,
        [String]$after_install,
        [String]$verification,
        [Int16]$codepage = 0,
        [Int16]$admin = 0,
        [String]$fetch_mirrors,
        [Int16]$use_proxy = 0,
        [String]$proxy,
        [String]$spec_dir
    )
    cmd.exe /c pause
    Write-Output "-name $name -install $install -package $package -download $download -curl $curl -install_dir $install_dir -params $params -ok_message $ok_message -del_flag $del_flag -after_install $after_install -verification $verification -codepage $codepage -admin $admin -fetch_mirrors $fetch_mirrors -use_proxy $use_proxy -proxy $proxy -spec_dir $spec_dir"
    Write-Output "================$name================"
    if ($install -eq 1)
    {
        Write-Output "================$codepage================"
        # Download the latest version of the installer.
        if ($download -eq 1)
        {
            if ( [String]::IsNullOrWhiteSpace($fetch_mirrors))
            {
                if ($use_proxy -eq 1)
                {
                    Invoke-WebRequest -PassThru -Uri $curl -Proxy $proxy -OutFile $package
                }
                else
                {
                    Invoke-WebRequest -PassThru -Uri $curl -OutFile $package
                }
            }
            else
            {
                if ($use_proxy -eq 1)
                {
                    Invoke-WebRequest -PassThru -Uri $fetch_mirrors -Proxy $proxy -OutFile $package
                }
                else
                {
                    Invoke-WebRequest -PassThru -Uri $fetch_mirrors -OutFile $package
                }
            }
        }

        Write-Output "$PSScriptRoot"
        if (Test-Path -Path $PSScriptRoot\$package)
        {
            $arguments = ""
            # Set the installation directory.
            if (-not [String]::IsNullOrWhiteSpace($install_dir))
            {
                $arguments = $spec_dir -creplace "path", $install_dir
            }
            Write-Output "$arguments"
            try
            {
                # Install
                Write-Output "$PSScriptRoot\$package $params $arguments"
                $args = @($params)
                if (-not [String]::IsNullOrWhiteSpace($arguments))
                {
                    $args = @($params, $arguments)
                }

                if ($admin -ne 1)
                {
                    if ($package -match '^.*\.exe$')
                    {
                        if ( [String]::IsNullOrWhiteSpace($params))
                        {
                            Start-Process -FilePath $PSScriptRoot\$package -NoNewWindow -Wait -PassThru
                        }
                        else
                        {
                            Start-Process -FilePath $PSScriptRoot\$package -ArgumentList $args -NoNewWindow -Wait -PassThru
                        }
                    }
                    else
                    {
                        $args = @("/i `"$package`"", $params, $arguments)
                        Start-Process msiexec.exe -ArgumentList $args -NoNewWindow -Wait -PassThru
                    }
                }
                else
                {
                    if ($package -match '^.*\.exe$')
                    {
                        if ( [String]::IsNullOrWhiteSpace($params))
                        {
                            Start-Process -FilePath "powershell" -NoNewWindow -Wait -PassThru -Verb RunAs -ArgumentList "-Command & {$PSScriptRoot\$package}"
                        }
                        else
                        {
                            Start-Process -FilePath "powershell" -NoNewWindow -Wait -PassThru -Verb RunAs -ArgumentList "-Command & {$PSScriptRoot\$package $args}"
                        }
                    }
                    else
                    {
                        $args = @("/i `"$package`"", $params, $arguments)
                        Start-Process -FilePath "powershell" -NoNewWindow -Wait -PassThru -Verb RunAs -ArgumentList "-Command & {msiexec.exe $args}"
                    }
                }

                $exitCode = $LASTEXITCODE

                if ($exitCode -eq 0)
                {
                    if ( [String]::IsNullOrWhiteSpace($ok_message))
                    {
                        Write-Output "$name has been successfully installed."
                    }
                    else
                    {
                        Write-Output "$ok_message"
                    }
                }
                else
                {
                    Write-Output "Unable to install $name : $exitCode"
                }
                # Remove the installer.
                if (($del_flag -eq 1) -and (Test-Path -Path $PSScriptRoot\$package))
                {
                    Remove-Item $PSScriptRoot\$package
                }
                if (-not [String]::IsNullOrWhiteSpace($after_install))
                {
                    Start-Process -FilePath "powershell" -ArgumentList @("$after_install") -NoNewWindow -Wait
                }
                if (-not [String]::IsNullOrWhiteSpace($verification))
                {
                    Start-Process -FilePath "powershell" -ArgumentList @("$verification") -NoNewWindow -Wait
                }
                $manual_check = 1
                if ($manual_check -eq 1)
                {
                    cmd.exe /c pause
                }
            }
            catch
            {
                Write-Output "Unable to install $name : $_"
            }
        }
    }
}

Import-Csv -Path .\app.csv -Delimiter "," | ForEach-Object {
    Write-Output "-name $( $_.name ) -install $( $_.install ) -package $( $_.package ) -download $( $_.download ) -curl $( $_.curl ) -install_dir $( $_.install_dir ) -params $( $_.params ) -ok_message $( $_.ok_message ) -del_flag $( $_.del_flag ) -after_install $( $_.after_install ) -verification $( $_.verification ) -codepage $( $_.codepage ) -admin $( $_.admin ) -fetch_mirrors $( $_.fetch_mirrors ) -use_proxy $( $_.use_proxy ) -proxy $( $_.proxy ) -spec_dir $( $_.spec_dir )"
    install_app -name $_.name -install $_.install -package $_.package -download $_.download -curl $_.curl -install_dir $_.install_dir -params $_.params -ok_message $_.ok_message -del_flag $_.del_flag -after_install $_.after_install -verification $_.verification -codepage $_.codepage -admin $_.admin -fetch_mirrors $_.fetch_mirrors -use_proxy $_.use_proxy -proxy $_.proxy -spec_dir $_.spec_dir
}

```
