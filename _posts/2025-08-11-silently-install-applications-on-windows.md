---
layout: post
title: "Silently install applications on Windows"
date: 2025-08-11
excerpt: "One-click download and install common software and applications on Windows 11."
tags: [ silently install, Unattended installation, applications installation, PowerShell, Windows ]
comments: true
---

# Silently install applications on Windows 11

As a developer for a long time, I manually click the next button step by step each time I install software and
applications.
when I switch to a new environment or another computer, I have to speed such much time to prepare for this work, which
mostly ends up wasting a lot of your valuable time.
Therefore, I recently make some effort to write a set of scripts to automatically install your need software and
applications by reading a CSV format file.

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
git config --global http.proxy http://127.0.0.1:10808
git config --global http.sslVerify false
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
git config --global color.ui auto

rem Remove the installer.
del Git-2.50.1-64-bit.exe

pause
```

### Git 配置

参考 [Git - git-config 文档 - Git 版本控制系统](https://git-scm.cn/docs/git-config#ENVIRONMENT)

#### Git/after-install.sh

```shell
git config --global http.proxy http://127.0.0.1:10808
git config --global http.sslVerify false
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
git config --global color.ui auto
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

## Oh My Zsh

### 安装 Oh My Zsh

#### Git/Oh My Zsh/install-oh-my-zsh.sh

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

#### Java/after-install.ps1

```powershell
param (
    [String]$JavaHomePath = "C:\Java\jdk1.8.0_202"
)
if ( [String]::IsNullOrWhiteSpace([Environment]::GetEnvironmentVariable("JAVA_HOME", "Machine")))
{
    [Environment]::SetEnvironmentVariable("JAVA_HOME", "$JavaHomePath", "Machine")
}
$NewPath = (([Environment]::GetEnvironmentVariable("PATH", "Machine") -split ";") | ?{ $_ -and $_ -notlike "*\Java\*\bin" }) -join ";"
[Environment]::SetEnvironmentVariable("PATH", "$NewPath;$JavaHomePath\bin", "Machine")

Invoke-Expression "& java -version"
```

#### Java/after-install-jre.ps1

```powershell
param (
    [String]$JavaHomePath = "C:\Java\jre1.8.0_461"
)
if ( [String]::IsNullOrWhiteSpace([Environment]::GetEnvironmentVariable("JAVA_HOME", "Machine")))
{
    [Environment]::SetEnvironmentVariable("JAVA_HOME", "$JavaHomePath", "Machine")
}
$NewPath = (([Environment]::GetEnvironmentVariable("PATH", "Machine") -split ";") | ?{ $_ -and $_ -notlike "*\Java\*\bin" }) -join ";"
[Environment]::SetEnvironmentVariable("PATH", "$NewPath;$JavaHomePath\bin", "Machine")

Invoke-Expression "& java -version"
```

#### Java/after-install.bat

```bat
@echo off

set INSTALL_DIR="C:\Java\jdk1.8.0_202"
setx JAVA_HOME %INSTALL_DIR% /M
setx PATH "%%JAVA_HOME%%\bin;%PATH%" /M

java -version

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

### Podman Desktop 安装

After completing the installation of Podman Desktop, It doesn't come with the Podman installation,
even though the installation package contains the pod installation package. So you need to install it manually.

#### PodmanDesktop/after-install.ps1

```bat
param(
    [String]$podmanDesktopInstallFolder = "C:\Apps\Podman Desktop"
)
$package = "$podmanDesktopInstallFolder\resources\extensions\podman\packages\extension\assets\podman-5.5.2-setup.exe"
$args = @("/quiet", "MachineProvider=wsl AllowOldWin=1 InstallFolder=`"C:\Apps\Podman`"")
Start-Process -FilePath $package -ArgumentList $args -NoNewWindow -Wait -PassThru
$exitCode = $LASTEXITCODE
$name = "Podman"
if ($exitCode -eq 0)
{
    Write-Output "$name has been successfully installed."
}
else
{
    Write-Output "Unable to install $name : $exitCode"
}
```

### MSYS2 Installation

Due to the well-known GFW network problem in China, It doesn't finish as quickly as expected when generating GNUPgp if
you start bash after completing the installation.
Please do not do this. On the contrary, use the script below to set up the mirrors of software source for updates.

#### MSYS2/after-install.sh

```shell
# sed -i "s#mirror.msys2.org/#mirrors.ustc.edu.cn/msys2/#g" /c/msys64/etc/pacman.d/mirrorlist*
sed -i "s#mirror.msys2.org/#mirrors.ustc.edu.cn/msys2/#g" /c/Apps/msys64/etc/pacman.d/mirrorlist*
```

#### MSYS2/install-needed.sh

```shell
pacman -Sy
pacman -Sy mingw-w64-ucrt-x86_64-imagemagick
pacman -Sy mingw-w64-ucrt-x86_64-mediainfo
pacman -Sy mingw-w64-ucrt-x86_64-ffmpeg
pacman -Sy vim
pacman -Sy mingw-w64-ucrt-x86_64-zeal
pacman -Sy mingw-w64-ucrt-x86_64-podman
pacman -Sy mingw-w64-ucrt-x86_64-podman-compose
pacman -Sy mingw-w64-ucrt-x86_64-starship
pacman -Sy mingw-w64-ucrt-x86_64-ttf-jetbrains-mono-nerd
pacman -Sy zsh
pacman -Sy mingw-w64-ucrt-x86_64-aria2
mkdir -p ~/.config && touch ~/.config/starship.toml

tee -a ~/.config/starship.toml << 'EOF'
"$schema" = 'https://starship.rs/config-schema.json'

format = """
[](color_orange)\
$os\
$username\
[](bg:color_yellow fg:color_orange)\
$directory\
[](fg:color_yellow bg:color_aqua)\
$git_branch\
$git_status\
[](fg:color_aqua bg:color_blue)\
$c\
$cpp\
$rust\
$golang\
$nodejs\
$php\
$java\
$kotlin\
$haskell\
$python\
[](fg:color_blue bg:color_bg3)\
$docker_context\
$conda\
$pixi\
[](fg:color_bg3 bg:color_bg1)\
$time\
[ ](fg:color_bg1)\
$line_break$character"""

palette = 'gruvbox_dark'

[palettes.gruvbox_dark]
color_fg0 = '#fbf1c7'
color_bg1 = '#3c3836'
color_bg3 = '#665c54'
color_blue = '#458588'
color_aqua = '#689d6a'
color_green = '#98971a'
color_orange = '#d65d0e'
color_purple = '#b16286'
color_red = '#cc241d'
color_yellow = '#d79921'

[os]
disabled = false
style = "bg:color_orange fg:color_fg0"

[os.symbols]
Windows = "󰍲"
Ubuntu = "󰕈"
SUSE = ""
Raspbian = "󰐿"
Mint = "󰣭"
Macos = "󰀵"
Manjaro = ""
Linux = "󰌽"
Gentoo = "󰣨"
Fedora = "󰣛"
Alpine = ""
Amazon = ""
Android = ""
Arch = "󰣇"
Artix = "󰣇"
EndeavourOS = ""
CentOS = ""
Debian = "󰣚"
Redhat = "󱄛"
RedHatEnterprise = "󱄛"
Pop = ""

[username]
show_always = true
style_user = "bg:color_orange fg:color_fg0"
style_root = "bg:color_orange fg:color_fg0"
format = '[ $user ]($style)'

[directory]
style = "fg:color_fg0 bg:color_yellow"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[directory.substitutions]
"Documents" = "󰈙 "
"Downloads" = " "
"Music" = "󰝚 "
"Pictures" = " "
"Developer" = "󰲋 "

[git_branch]
symbol = ""
style = "bg:color_aqua"
format = '[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)'

[git_status]
style = "bg:color_aqua"
format = '[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)'

[nodejs]
symbol = ""
style = "bg:color_blue"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

[c]
symbol = " "
style = "bg:color_blue"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

[cpp]
symbol = " "
style = "bg:color_blue"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

[rust]
symbol = ""
style = "bg:color_blue"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

[golang]
symbol = ""
style = "bg:color_blue"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

[php]
symbol = ""
style = "bg:color_blue"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

[java]
symbol = ""
style = "bg:color_blue"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

[kotlin]
symbol = ""
style = "bg:color_blue"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

[haskell]
symbol = ""
style = "bg:color_blue"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

[python]
symbol = ""
style = "bg:color_blue"
format = '[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)'

[docker_context]
symbol = ""
style = "bg:color_bg3"
format = '[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)'

[conda]
style = "bg:color_bg3"
format = '[[ $symbol( $environment) ](fg:#83a598 bg:color_bg3)]($style)'

[pixi]
style = "bg:color_bg3"
format = '[[ $symbol( $version)( $environment) ](fg:color_fg0 bg:color_bg3)]($style)'

[time]
disabled = false
time_format = "%R"
style = "bg:color_bg1"
format = '[[  $time ](fg:color_fg0 bg:color_bg1)]($style)'

[line_break]
disabled = false

[character]
disabled = false
success_symbol = '[](bold fg:color_green)'
error_symbol = '[](bold fg:color_red)'
vimcmd_symbol = '[](bold fg:color_green)'
vimcmd_replace_one_symbol = '[](bold fg:color_purple)'
vimcmd_replace_symbol = '[](bold fg:color_purple)'
vimcmd_visual_symbol = '[](bold fg:color_yellow)'
EOF

tee -a ~/.bashrc << EOF
/c/Windows/System32/chcp.com 65001 > /dev/null 2>&1
if [ -t 1 ]; then
  exec zsh
fi
EOF

tee -a ~/.zshrc << 'EOF'
eval "$(starship init zsh)"
EOF

aria2c -c -x16 -s16 --all-proxy=http://127.0.0.1:10808 --check-certificate=false -R --dir=/d/upload/Application -o Fluent.Reader.Setup.1.1.4.x64.exe https://github.com/yang991178/fluent-reader/releases/download/v1.1.4/Fluent.Reader.Setup.1.1.4.x64.exe
aria2c -c -x16 -s16 --check-certificate=false -R --dir=/d/upload/Compressed -o en-us_windows_10_iot_enterprise_ltsc_2021_x64_dvd_257ad90f.iso "https://delivery.activated.win/dbmassgrave/en-us_windows_10_iot_enterprise_ltsc_2021_x64_dvd_257ad90f.iso?t=9VPfetdBzadAtJjHxfU72VhNTJBYd5Vk&P1=1756147690&P2=601&P3=2&P4=3w1CL8Qn%2FCZP4lsyPNU%2BBXB4Hc%2BmAaOAVqz6tkJp6Oo%3D"
aria2c -c -x16 -s16 --check-certificate=false -R --dir=/d/upload/Compressed -o zh-cn_windows_10_enterprise_ltsc_2021_x64_dvd_033b7312.iso "https://delivery.massgrave.dev/dbmassgrave/zh-cn_windows_10_enterprise_ltsc_2021_x64_dvd_033b7312.iso?t=9VPfetdBzadAtJjHbAyiyQXvvYtKAPSU&P1=1756148179&P2=601&P3=2&P4=gDOPa0%2FTa24FOzBP4FMKWG8G91FMPmQj9QZPH33aDZ0%3D"
aria2c -c -x16 -s16 --check-certificate=false -R --dir=/d/upload/Compressed -o zh-cn_windows_11_enterprise_ltsc_2024_x64_dvd_cff9cd2d.iso "https://delivery.activated.win/dbmassgrave/zh-cn_windows_11_enterprise_ltsc_2024_x64_dvd_cff9cd2d.iso?t=9VPfetdBzadAtJjHK641KMMJQZYZ4K0h&P1=1756149550&P2=601&P3=2&P4=aZqDZLI%2BqQFAf6oxNp31GIKVZMv5uKh6hvSBPp7Ulso%3D"

```

### PostgreSQL Installation

#### PostgreSQL/after-install.ps1

```powershell
param (
    [String]$PostgreSQLHomePath = "C:\Apps\PostgreSQL\15"
)
$NewPath = (([Environment]::GetEnvironmentVariable("PATH", "Machine") -split ";") | ?{ $_ -and $_ -notlike "*\PostgreSQL\*\bin" }) -join ";"
[Environment]::SetEnvironmentVariable("PATH", "$NewPath;$PostgreSQLHomePath\bin", "Machine")

Invoke-Expression "& psql `"dbname=postgres host=localhost user=postgres password=postgres port=5432 sslmode=prefer`""
```

### Starship

I suggest installing the nerd font first, you do install starship.

#### starship/plain-text-symbols.toml

```toml
[character]
success_symbol = "[>](bold green)"
error_symbol = "[x](bold red)"
vimcmd_symbol = "[<](bold green)"

[git_commit]
tag_symbol = " tag "

[git_status]
ahead = ">"
behind = "<"
diverged = "<>"
renamed = "r"
deleted = "x"

[aws]
symbol = "aws "

[azure]
symbol = "az "

[buf]
symbol = "buf "

[bun]
symbol = "bun "

[c]
symbol = "C "

[cpp]
symbol = "C++ "

[cobol]
symbol = "cobol "

[conda]
symbol = "conda "

[container]
symbol = "container "

[crystal]
symbol = "cr "

[cmake]
symbol = "cmake "

[daml]
symbol = "daml "

[dart]
symbol = "dart "

[deno]
symbol = "deno "

[dotnet]
symbol = ".NET "

[directory]
read_only = " ro"

[docker_context]
symbol = "docker "

[elixir]
symbol = "exs "

[elm]
symbol = "elm "

[fennel]
symbol = "fnl "

[fossil_branch]
symbol = "fossil "

[gcloud]
symbol = "gcp "

[git_branch]
symbol = "git "

[gleam]
symbol = "gleam "

[golang]
symbol = "go "

[gradle]
symbol = "gradle "

[guix_shell]
symbol = "guix "

[haskell]
symbol = "haskell "

[helm]
symbol = "helm "

[hg_branch]
symbol = "hg "

[java]
symbol = "java "

[julia]
symbol = "jl "

[kotlin]
symbol = "kt "

[lua]
symbol = "lua "

[nodejs]
symbol = "nodejs "

[memory_usage]
symbol = "memory "

[meson]
symbol = "meson "

[nats]
symbol = "nats "

[nim]
symbol = "nim "

[nix_shell]
symbol = "nix "

[ocaml]
symbol = "ml "

[opa]
symbol = "opa "

[os.symbols]
AIX = "aix "
Alpaquita = "alq "
AlmaLinux = "alma "
Alpine = "alp "
Amazon = "amz "
Android = "andr "
Arch = "rch "
Artix = "atx "
Bluefin = "blfn "
CachyOS = "cach "
CentOS = "cent "
Debian = "deb "
DragonFly = "dfbsd "
Emscripten = "emsc "
EndeavourOS = "ndev "
Fedora = "fed "
FreeBSD = "fbsd "
Garuda = "garu "
Gentoo = "gent "
HardenedBSD = "hbsd "
Illumos = "lum "
Kali = "kali "
Linux = "lnx "
Mabox = "mbox "
Macos = "mac "
Manjaro = "mjo "
Mariner = "mrn "
MidnightBSD = "mid "
Mint = "mint "
NetBSD = "nbsd "
NixOS = "nix "
Nobara = "nbra "
OpenBSD = "obsd "
OpenCloudOS = "ocos "
openEuler = "oeul "
openSUSE = "osuse "
OracleLinux = "orac "
Pop = "pop "
Raspbian = "rasp "
Redhat = "rhl "
RedHatEnterprise = "rhel "
RockyLinux = "rky "
Redox = "redox "
Solus = "sol "
SUSE = "suse "
Ubuntu = "ubnt "
Ultramarine = "ultm "
Unknown = "unk "
Uos = "uos "
Void = "void "
Windows = "win "

[package]
symbol = "pkg "

[perl]
symbol = "pl "

[php]
symbol = "php "

[pijul_channel]
symbol = "pijul "

[pixi]
symbol = "pixi "

[pulumi]
symbol = "pulumi "

[purescript]
symbol = "purs "

[python]
symbol = "py "

[quarto]
symbol = "quarto "

[raku]
symbol = "raku "

[rlang]
symbol = "r "

[ruby]
symbol = "rb "

[rust]
symbol = "rs "

[scala]
symbol = "scala "

[spack]
symbol = "spack "

[solidity]
symbol = "solidity "

[status]
symbol = "[x](bold red) "

[sudo]
symbol = "sudo "

[swift]
symbol = "swift "

[typst]
symbol = "typst "

[terraform]
symbol = "terraform "

[zig]
symbol = "zig "

```

#### starship/WindowsPowerShell/Microsoft.PowerShell_profile.ps1

```powershell
Invoke-Expression (&starship init powershell)

$ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
```

#### starship/starship.bat

```bat
@echo off
xcopy %~dp0WindowsPowerShell %USERPROFILE%\Documents\WindowsPowerShell /s /e /i
xcopy %~dp0plain-text-symbols.toml %USERPROFILE%\.config\starship.toml /s /e /i
echo.
xcopy %~dp0JetBrainsMono\*.ttf %windir%\Fonts\ /s /e /i
pause
```

### IntelliJ IDEA

#### IntelliJ IDEA/silent.config

```ini
; Installation mode. It can be user or admin.
; NOTE: for admin mode please use "Run as Administrator" for command prompt to avoid UAC dialog.
mode = admin

; Desktop shortcut for launchers
launcher64 = 1

; Add launchers path to PATH env variable
updatePATH = 0

; Add "Open Folder as Project" to context menu
updateContextMenu = 0

; List of associations. To create an association change value to 1.
.java = 0
.groovy = 0
.kt = 0

```

### MySQL 5.7

#### MySQL/after-install.ps1

```powershell
param(
    [String]$installdir = "C:\Apps\MySQL\MySQL Server 5.7",
    [String]$datadir = $installdir,
    [String]$passwd = "masterA@#1",
    [Int32]$port = 33306,
    [String]$MySQLInstallerConsole = "C:\Program Files (x86)\MySQL\MySQL Installer for Windows\MySQLInstallerConsole.exe"
)
#MySQLInstallerConsole.exe --help --action=install
#MySQLInstallerConsole.exe community install server;5.7.44;x64 --show-settings
$args = @("community", "--install server;5.7.44;x64:*:type=config;open_windows_firewall=true;bin_log=true;port=$port;password=$passwd;install_dir=`"$installdir`";data_directory=`"$datadir`"", "--silent")
Write-Output "$MySQLInstallerConsole $args"
Start-Process -FilePath $MySQLInstallerConsole -ArgumentList $args -NoNewWindow -Wait -PassThru
```

### VirtualBox

VirtualBox 在 Windows 主机上的安装目录必须满足某些安全要求，详情可见[Installing VirtualBox](https://www.virtualbox.org/manual/topics/installation.html#install-win-unattended)

### RabbitMQ

#### RabbitMQ/after-install.ps1

```powershell
param(
    [String]$RabbitMQInstallFolder = "C:\Apps\RabbitMQ Server\rabbitmq_server-4.1.3"
)
$package = "$RabbitMQInstallFolder\sbin\rabbitmq-plugins.bat"
$args = @("enable rabbitmq_management")
Start-Process -FilePath $package -ArgumentList $args -NoNewWindow -Wait -PassThru
Start-Service -Name "RabbitMQ" -PassThru

Start-Process "http://localhost:15672"
```

### Rime

#### rime/after-install.bat

```bat
@echo off
set rime_dir=%APPDATA%\Rime
xcopy %~dp0rime-ice\* %rime_dir%\ /s /e /i
pause
```

### WSL

#### WSL/after-install.ps1

```powershell
# https://documentation.ubuntu.com/wsl/latest/howto/install-ubuntu-wsl2/
param(
    [String]$wslimage = "ubuntu-24.04.3-wsl-amd64.wsl",
    [String]$wsl = "https://releases.ubuntu.com/noble/$wslimage",
    [Boolean]$useproxy = $true,
    [String]$proxy = "http://127.0.0.1:10808"
)
if (-not (Test-Path -Path ".\$wslimage"))
{
    if ((-not $useproxy) -or [String]::IsNullOrWhiteSpace($proxy))
    {
        Invoke-WebRequest -PassThru -Uri $wsl -OutFile .\$wslimage
    }
    else
    {
        Invoke-WebRequest -PassThru -Uri $wsl -Proxy $proxy -OutFile .\$wslimage
    }
}
Write-Output ".\$wslimage"
if (Test-Path -Path ".\$wslimage")
{
    $args = ("--install", "--no-launch", "--from-file .\$wslimage")
    Start-Process -FilePath "wsl" -ArgumentList $args -NoNewWindow -Wait -PassThru
}
```

# 常见软件整理列表

| app                        | name                                 | install | package                                                     | download | home                                                                                   | curl                                                                                                                                                                                                                    | install_dir                                         | params                                                                                                                                                                                                                  | ok_message                                                 | del_flag | link                                                                                                                                                                                                                                                       | link2                                                                                                                                                                | after_install                     | verification     | codepage | admin | fetch_mirrors                                                                      | use_proxy | proxy                  | spec_dir                                                                                                                |
|:---------------------------|:-------------------------------------|:--------|:------------------------------------------------------------|:---------|:---------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------|:---------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------|:-----------------|:---------|:------|:-----------------------------------------------------------------------------------|:----------|:-----------------------|:------------------------------------------------------------------------------------------------------------------------|
| 7-Zip                      | 7-Zip                                | 0       | 7z2501-x64.exe                                              | 0        | https://7-zip.org/                                                                     | https://7-zip.org/a/7z2501-x64.exe                                                                                                                                                                                      | C:\Apps\7-Zip                                       | /S                                                                                                                                                                                                                      |                                                            | 0        | https://7-zip.org/faq.html                                                                                                                                                                                                                                 |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /D="path"                                                                                                               |
| DBeaver                    | DBeaver                              | 0       | dbeaver-ce-25.1.5-x86_64-setup.exe                          | 0        | https://dbeaver.io/                                                                    | https://github.com/dbeaver/dbeaver/releases/download/25.1.5/dbeaver-ce-25.1.5-x86_64-setup.exe                                                                                                                          | C:\Apps\DBeaver                                     | /S /allusers                                                                                                                                                                                                            |                                                            | 0        | https://dbeaver.com/docs/dbeaver/Windows-Silent-Install/                                                                                                                                                                                                   | https://github.com/dbeaver/dbeaver/wiki/Windows-Silent-Install                                                                                                       |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | /D=path                                                                                                                 |
| Eudic                      | Eudic                                | 0       | eudic_win.exe                                               | 0        | https://www.eudic.net/v4/en/app/eudic                                                  | https://www.eudic.net/download/eudic_win.zip?v=2025-07-25                                                                                                                                                               |                                                     | /SD                                                                                                                                                                                                                     |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        |                                                                                                                         |
| FDM                        | Free Download Manager                | 0       | fdm_x64_setup.exe                                           | 0        | https://www.freedownloadmanager.org/                                                   | https://files2.freedownloadmanager.org/6/latest/fdm_x64_setup.exe                                                                                                                                                       | C:\Apps\Free Download Manager                       | /VERYSILENT /ALLUSERS                                                                                                                                                                                                   | You have successfully installed FDM                        | 0        | https://jrsoftware.org/ishelp/index.php?topic=setupcmdline                                                                                                                                                                                                 |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | /DIR="path"                                                                                                             |
| FileZilla Server           | FileZilla Server                     | 0       | FileZilla_Server_1.10.5_win64-setup.exe                     | 0        | https://filezilla-project.org/                                                         |                                                                                                                                                                                                                         | C:\Apps\FileZilla Server                            | /S /user=all                                                                                                                                                                                                            |                                                            | 0        | https://wiki.filezilla-project.org/Silent_Setup                                                                                                                                                                                                            |                                                                                                                                                                      | .\FileZilla\after-install.ps1     |                  |          |       |                                                                                    | 0         |                        | /D=path                                                                                                                 |
| Firefox                    | Mozilla Firefox                      | 0       | Firefox Setup 140.2.0esr.exe                                | 0        | https://www.firefox.com/en-US/                                                         | https://ftp.mozilla.org/pub/firefox/releases/140.2.0esr/win64/en-US/Firefox%20Setup%20140.2.0esr.exe                                                                                                                    | C:\Apps\Mozilla Firefox                             | /S /DesktopShortcut=true /MaintenanceService=false /TaskbarShortcut=false /PrivateBrowsingShortcut=false                                                                                                                |                                                            | 0        | https://firefox-source-docs.mozilla.org/browser/installer/windows/installer/FullConfig.html                                                                                                                                                                |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /InstallDirectoryPath="path"                                                                                            |
| FxSound                    | FxSound                              | 0       | fxsound_setup.exe                                           | 0        | https://www.fxsound.com/                                                               | https://github.com/fxsound2/fxsound-app/releases/download/latest/fxsound_setup.exe                                                                                                                                      | C:\Apps\FxSound                                     | /exenoui /exenoupdates                                                                                                                                                                                                  |                                                            | 0        | https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec                                                                                                                                                                   |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | APPDIR="path"                                                                                                           |
| Git                        | Git                                  | 0       | Git-2.50.1-64-bit.exe                                       | 0        | https://gitforwindows.org/                                                             | https://github.com/git-for-windows/git/releases/download/v2.50.1.windows.1/Git-2.50.1-64-bit.exe                                                                                                                        | C:\Apps\Git                                         | /VERYSILENT                                                                                                                                                                                                             |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   | git version      |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | /DIR="path"                                                                                                             |
| IDM                        | Internet Download Manager            | 0       | idman642build42.exe                                         | 0        | https://www.internetdownloadmanager.com/                                               | https://mirror2.internetdownloadmanager.com/idman642build42.exe                                                                                                                                                         |                                                     | /skipdlgs                                                                                                                                                                                                               |                                                            | 0        | https://www.internetdownloadmanager.com/register/new_faq/functions21.html                                                                                                                                                                                  |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        |                                                                                                                         |
| ImageGlass                 | ImageGlass                           | 0       | ImageGlass_9.3.2.520_x64.msi                                | 0        | https://imageglass.org/                                                                | https://github.com/d2phap/ImageGlass/releases/download/9.3.2.520/ImageGlass_9.3.2.520_x64.msi                                                                                                                           | C:\Apps\ImageGlass                                  | /passive                                                                                                                                                                                                                |                                                            | 0        | https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec                                                                                                                                                                   |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | APPDIR="path"                                                                                                           |
| Java                       | JRE                                  | 0       | jre-8u461-windows-x64.exe                                   | 0        | https://www.java.com/en/                                                               | https://javadl.oracle.com/webapps/download/AutoDL?BundleId=252322_68ce765258164726922591683c51982c                                                                                                                      | C:\Java\jre1.8.0_461                                | /s INSTALL_SILENT=1 WEB_JAVA=0 NOSTARTMENU=1                                                                                                                                                                            |                                                            | 0        | https://www.java.com/en/download/help/silent_install.html                                                                                                                                                                                                  |                                                                                                                                                                      | .\Java\after-install-jre.ps1      | java -version    | 1        | 0     |                                                                                    | 0         |                        | INSTALLDIR=path                                                                                                         |
| Java                       | JDK                                  | 0       | jdk-8u202-windows-x64.exe                                   | 0        | https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html         | !!!important!!!Required login https://download.oracle.com/otn/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-windows-x64.exe                                                                             | C:\Java\jdk1.8.0_202                                | /s INSTALL_SILENT=1 ADDLOCAL="ToolsFeature,SourceFeature" NOSTARTMENU=1                                                                                                                                                 |                                                            | 0        | https://www.java.com/en/download/help/silent_install.html                                                                                                                                                                                                  |                                                                                                                                                                      | .\Java\after-install.ps1          | java -version    | 1        | 0     |                                                                                    | 0         |                        | INSTALLDIR=path                                                                                                         |
| MSYS2                      | MSYS2                                | 0       | msys2-base-x86_64-20250622.sfx.exe                          | 0        | https://www.msys2.org/                                                                 | https://github.com/msys2/msys2-installer/releases/download/2025-06-22/msys2-base-x86_64-20250622.sfx.exe                                                                                                                | C:\Apps\                                            | -y                                                                                                                                                                                                                      |                                                            | 0        | https://www.msys2.org/docs/installer/                                                                                                                                                                                                                      |                                                                                                                                                                      |                                   |                  |          |       | https://mirrors.nju.edu.cn/msys2/distrib/x86_64/msys2-base-x86_64-20250622.sfx.exe | 1         | http://127.0.0.1:10808 | -opath                                                                                                                  |
| Node.js                    | nodejs                               | 0       | node-v20.19.4-x64.msi                                       | 0        | https://nodejs.org/en                                                                  | https://nodejs.org/dist/v20.19.4/node-v20.19.4-x64.msi                                                                                                                                                                  | C:\Apps\nodejs                                      | /passive                                                                                                                                                                                                                |                                                            | 0        | https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec                                                                                                                                                                   |                                                                                                                                                                      |                                   | node -v          |          |       |                                                                                    | 0         |                        | INSTALLDIR="path"                                                                                                       |
| PeaZip                     | PeaZip                               | 0       | peazip-10.6.0.WIN64.exe                                     | 0        | https://peazip.github.io/                                                              | https://github.com/peazip/PeaZip/releases/download/10.6.0/peazip-10.6.0.WIN64.exe                                                                                                                                       | C:\Apps\PeaZip                                      | /VERYSILENT /ALLUSERS /MERGETASKS="!desktopicon"                                                                                                                                                                        |                                                            | 0        | https://peazip.github.io/peazip-help-faq.html#run_peazip_on_microsoft_windows                                                                                                                                                                              |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | /DIR="path"                                                                                                             |
| Podman Desktop             | Podman Desktop                       | 0       | podman-desktop-airgap-1.20.2-setup-x64.exe                  | 0        | https://podman-desktop.io/                                                             | https://github.com/podman-desktop/podman-desktop/releases/download/v1.20.2/podman-desktop-airgap-1.20.2-setup-x64.exe                                                                                                   | C:\Apps\Podman Desktop                              | /S                                                                                                                                                                                                                      |                                                            | 0        | https://podman-desktop.io/docs/installation/windows-install#silent-windows-installer                                                                                                                                                                       | https://github.com/containers/podman/blob/main/build_windows.md                                                                                                      | .\PodmanDesktop\after-install.ps1 |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | /D="path"                                                                                                               |
| Postman                    | Postman                              | 0       | Postman-win64-9.31.28-Setup.exe                             | 0        | https://www.postman.com/                                                               | https://dl.pstmn.io/download/version/9.31.28/win64                                                                                                                                                                      |                                                     |                                                                                                                                                                                                                         |                                                            | 0        | https://learning.postman.com/docs/administration/enterprise/managing-enterprise-deployment/                                                                                                                                                                |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        |                                                                                                                         |
| PowerToys                  | PowerToys                            | 0       | PowerToysSetup-0.93.0-x64.exe                               | 0        | https://learn.microsoft.com/en-us/windows/powertoys/                                   | https://github.com/microsoft/PowerToys/releases/download/v0.93.0/PowerToysSetup-0.93.0-x64.exe                                                                                                                          | C:\Apps\PowerToys                                   | /passive                                                                                                                                                                                                                |                                                            | 0        | https://learn.microsoft.com/en-us/windows/powertoys/install#command-line-installer-arguments                                                                                                                                                               |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | InstallFolder="path"                                                                                                    |
| Rime                       | Rime                                 | 0       | weasel-0.17.4.0-installer.exe                               | 0        | https://rime.im/                                                                       | https://github.com/rime/weasel/releases/download/0.17.4/weasel-0.17.4.0-installer.exe                                                                                                                                   |                                                     | /S /ls /du /toggleime /release                                                                                                                                                                                          |                                                            | 0        | https://github.com/rime/weasel/blob/master/WeaselSetup/WeaselSetup.cpp#L163-L179                                                                                                                                                                           |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 |                                                                                                                         |
| ShareX                     | ShareX                               | 0       | ShareX-18.0.1-setup.exe                                     | 0        | https://getsharex.com/                                                                 | https://github.com/ShareX/ShareX/releases/download/v18.0.1/ShareX-18.0.1-setup.exe                                                                                                                                      | C:\Apps\ShareX                                      | /VERYSILENT /NORUN                                                                                                                                                                                                      |                                                            | 0        | https://getsharex.com/docs/command-line-arguments#sharex-setup-cli                                                                                                                                                                                         |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | /DIR="path"                                                                                                             |
| SMPlayer                   | SMPlayer                             | 0       | smplayer-25.6.0-x64-unsigned.exe                            | 0        | https://smplayer.info/                                                                 | https://github.com/smplayer-dev/smplayer/releases/download/v25.6.0/smplayer-25.6.0-x64-unsigned.exe                                                                                                                     | C:\Apps\SMPlayer                                    | /S                                                                                                                                                                                                                      | SMPlayer has been successfully installed on your computer. | 0        | https://nsis.sourceforge.io/Docs/Chapter3.html#3.2.1                                                                                                                                                                                                       |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | /D=path                                                                                                                 |
| Starship                   | starship                             | 0       | starship-x86_64-pc-windows-msvc.msi                         | 0        | https://starship.rs/                                                                   | https://github.com/starship/starship/releases/download/v1.23.0/starship-x86_64-pc-windows-msvc.msi                                                                                                                      | C:\Apps\starship                                    | /passive                                                                                                                                                                                                                |                                                            | 0        | https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec                                                                                                                                                                   |                                                                                                                                                                      | .\starship\starship.bat           |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | APPLICATIONFOLDER="path"                                                                                                |
| Sumatra PDF                | SumatraPDF                           | 0       | SumatraPDF-3.5.2-64-install.exe                             | 0        | https://www.sumatrapdfreader.org/free-pdf-reader                                       | https://www.sumatrapdfreader.org/dl/rel/3.5.2/SumatraPDF-3.5.2-64-install.exe                                                                                                                                           | C:\Apps\SumatraPDF                                  | -s -with-preview -all-users                                                                                                                                                                                             |                                                            | 0        | https://www.sumatrapdfreader.org/docs/Installer-cmd-line-arguments                                                                                                                                                                                         |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | -d "path"                                                                                                               |
| Tabby                      | Tabby                                | 0       | tabby-1.0.227-setup-x64.exe                                 | 0        | https://tabby.sh/                                                                      | https://github.com/Eugeny/tabby/releases/download/v1.0.227/tabby-1.0.227-setup-x64.exe                                                                                                                                  | C:\Apps\Tabby                                       | /S /allusers                                                                                                                                                                                                            |                                                            | 0        | https://github.com/Eugeny/tabby/issues                                                                                                                                                                                                                     |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | /D=path                                                                                                                 |
| ungoogled-chromium         | ungoogled-chromium                   | 0       | ungoogled-chromium_139.0.7258.138-1.1_installer_x64.exe     | 0        | https://github.com/ungoogled-software/ungoogled-chromium-windows                       | https://github.com/ungoogled-software/ungoogled-chromium-windows/releases/download/139.0.7258.138-1.1/ungoogled-chromium_139.0.7258.138-1.1_installer_x64.exe                                                           |                                                     | --install --silent --do-not-launch-chrome --system-level                                                                                                                                                                |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 |                                                                                                                         |
| Visual C++ Redistributable | Microsoft Visual C++ Redistributable | 0       | VC_redist.x64.exe                                           | 0        | https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170 | https://aka.ms/vs/17/release/vc_redist.x64.exe                                                                                                                                                                          |                                                     | /install /passive /norestart                                                                                                                                                                                            |                                                            | 0        | https://learn.microsoft.com/en-us/cpp/windows/redistributing-visual-cpp-files?view=msvc-170#command-line-options-for-the-redistributable-packages                                                                                                          |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        |                                                                                                                         |
| Visual C++ Redistributable | Microsoft Visual C++ Redistributable | 0       | VC_redist.x86.exe                                           | 0        | https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170 | https://aka.ms/vs/17/release/vc_redist.x86.exe                                                                                                                                                                          |                                                     | /install /passive /norestart                                                                                                                                                                                            |                                                            | 0        | https://learn.microsoft.com/en-us/cpp/windows/redistributing-visual-cpp-files?view=msvc-170#command-line-options-for-the-redistributable-packages                                                                                                          |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        |                                                                                                                         |
| VSCode                     | Microsoft VS Code                    | 0       | VSCodeSetup-x64-1.102.1.exe                                 | 0        | https://code.visualstudio.com/                                                         | https://code.visualstudio.com/sha/download?build=stable&os=win32-x64                                                                                                                                                    | C:\Apps\Microsoft VS Code                           | /VERYSILENT /mergetasks="desktopicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,!runcode"                                                                                                             |                                                            | 0        | https://jrsoftware.org/ishelp/index.php?topic=setupcmdline                                                                                                                                                                                                 | https://github.com/Microsoft/vscode/blob/main/build/win32/code.iss                                                                                                   |                                   |                  |          |       |                                                                                    | 0         |                        | /DIR="path"                                                                                                             |
| WinSCP                     | WinSCP                               | 0       | WinSCP-6.5.3-Setup.exe                                      | 0        | https://winscp.net/eng/index.php                                                       | https://winscp.net/download/WinSCP-6.5.3-Setup.exe/download                                                                                                                                                             | C:\Apps\WinSCP                                      | /VERYSILENT /ALLUSERS                                                                                                                                                                                                   |                                                            | 0        | https://winscp.net/eng/docs/installation                                                                                                                                                                                                                   |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /DIR="path"                                                                                                             |
| XMind 8                    | XMind                                | 0       | xmind-8-update9-windows.exe                                 | 0        | https://xmind.com/download/xmind8/                                                     | https://www.xmind.app/xmind/downloads/xmind-8-update9-windows.exe                                                                                                                                                       | C:\Apps\XMind                                       | /VERYSILENT                                                                                                                                                                                                             |                                                            | 0        | https://jrsoftware.org/ishelp/index.php?topic=setupcmdline                                                                                                                                                                                                 |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /DIR="path"                                                                                                             |
| Zeal                       | Zeal                                 | 0       | zeal-0.7.2-windows-x64.msi                                  | 0        | https://zealdocs.org/                                                                  | https://github.com/zealdocs/zeal/releases/download/v0.7.2/zeal-0.7.2-windows-x64.msi                                                                                                                                    | C:\Apps\Zeal                                        | /passive                                                                                                                                                                                                                |                                                            | 0        | https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec                                                                                                                                                                   |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | INSTALL_ROOT="path"                                                                                                     |
| PostgreSQL                 | PostgreSQL                           | 0       | postgresql-15.13-3-windows-x64.exe                          | 0        | https://www.postgresql.org/                                                            | https://sbp.enterprisedb.com/getfile.jsp?fileid=1259617                                                                                                                                                                 | C:\Apps\PostgreSQL\15                               | --create_shortcuts 1 --mode unattended --unattendedmodeui none --superaccount postgres --superpassword postgres --serverport 5432 --disable-components pgAdmin,stackbuilder --enable-components server,commandlinetools |                                                            | 0        | https://www.enterprisedb.com/docs/supported-open-source/postgresql/installing/command_line_parameters/                                                                                                                                                     |                                                                                                                                                                      | .\PostgreSQL\after-install.ps1    |                  |          |       |                                                                                    | 0         |                        | --prefix "path" --datadir "path\data"                                                                                   |
| Eclipse Adoptium           | Eclipse Adoptium                     | 0       | OpenJDK17U-jdk_x64_windows_hotspot_17.0.12_7.msi            | 0        | https://adoptium.net/                                                                  | https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.12%2B7/OpenJDK17U-jdk_x64_windows_hotspot_17.0.12_7.msi                                                                                       | C:\Apps\Eclipse Adoptium\jdk-17.0.12.7-hotspot\     | /quiet ADDLOCAL=FeatureMain,FeatureEnvironment,FeatureJarFileRunWith,FeatureJavaHome                                                                                                                                    |                                                            | 0        | https://adoptium.net/installation/windows#command-line-installation                                                                                                                                                                                        |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | INSTALLDIR="path"                                                                                                       |
| Jenkins                    | Jenkins                              | 0       | jenkins.msi                                                 | 0        | https://www.jenkins.io/                                                                | https://get.jenkins.io/windows-stable/2.516.1/jenkins.msi                                                                                                                                                               | C:\Apps\Jenkins                                     | /qn /norestart PORT=8080 JAVA_HOME="C:\Apps\Eclipse Adoptium\jdk-17.0.12.7-hotspot"                                                                                                                                     |                                                            | 0        | https://www.jenkins.io/doc/book/installing/windows/#silent-install-with-the-msi-installers                                                                                                                                                                 |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | INSTALLDIR="path"                                                                                                       |
| OBS Studio                 | OBS Studio                           | 0       | OBS-Studio-31.1.2-Windows-x64-Installer.exe                 | 0        | https://obsproject.com/                                                                | https://github.com/obsproject/obs-studio/releases/download/31.1.2/OBS-Studio-31.1.2-Windows-x64-Installer.exe                                                                                                           | C:\Apps\obs-studio                                  | /S                                                                                                                                                                                                                      |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | /D=path                                                                                                                 |
| VLC media player           | VLC                                  | 0       | vlc-3.0.21-win64.exe                                        | 0        | https://www.videolan.org/                                                              | https://download.videolan.org/pub/videolan/vlc/3.0.21/win64/vlc-3.0.21-win64.exe                                                                                                                                        | C:\Apps\VideoLAN\VLC                                | /L=1033 /S                                                                                                                                                                                                              |                                                            | 0        | https://wiki.videolan.org/Documentation:Installing_VLC/                                                                                                                                                                                                    |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        |                                                                                                                         |
| Acrobat Reader             | Acrobat Reader                       | 0       | AcroRdrDC2500120577_en_US.exe                               | 0        | https://get.adobe.com/reader/enterprise/                                               | https://ardownload3.adobe.com/pub/adobe/reader/win/AcrobatDC/2500120577/AcroRdrDC2500120577_en_US.exe                                                                                                                   | C:\Apps\Adobe\Acrobat Reader DC\Reader              | /sAll /rs /rps /sl "1033"                                                                                                                                                                                               |                                                            | 0        | https://www.adobe.com/devnet-docs/acrobatetk/tools/DesktopDeployment/cmdline.html                                                                                                                                                                          |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | INSTALLDIR="path"                                                                                                       |
| IntelliJ IDEA              | IntelliJ IDEA                        | 0       | ideaIC-2025.2.exe                                           | 0        | https://www.jetbrains.com/idea/                                                        | https://download.jetbrains.com/idea/ideaIC-2025.2.exe                                                                                                                                                                   | C:\Apps\JetBrains\IntelliJ IDEA 2025.2              | /S /CONFIG=.\IntelliJ IDEA\silent.config                                                                                                                                                                                |                                                            | 0        | https://www.jetbrains.com/help/idea/installation-guide.html#silent                                                                                                                                                                                         |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /D=path                                                                                                                 |
| Python                     | Python                               | 0       | python-3.13.6-amd64.exe                                     | 0        | https://www.python.org/                                                                | https://www.python.org/ftp/python/3.13.6/python-3.13.6-amd64.exe                                                                                                                                                        | C:\Apps\Python313                                   | /quiet InstallAllUsers=1 CompileAll=0 PrependPath=0 Shortcuts=0 Include_launcher=0 Include_test=0                                                                                                                       |                                                            | 0        | https://docs.python.org/3/using/windows.html#installing-without-ui                                                                                                                                                                                         |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | TargetDir="path"                                                                                                        |
| Everything                 | Everything                           | 0       | Everything-1.4.1.1028.x64-Setup.exe                         | 0        | https://www.voidtools.com/                                                             | https://www.voidtools.com/Everything-1.4.1.1028.x64-Setup.exe                                                                                                                                                           | C:\Apps\Everything                                  | /S -install-options "-app-data -enable-run-as-admin -disable-update-notification -uninstall-all-users-desktop-shortcut -uninstall-quick-launch-shortcut -uninstall-run-on-system-startup -language 2052"                |                                                            | 0        | https://www.voidtools.com/forum/viewtopic.php?t=5673                                                                                                                                                                                                       |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /D=path                                                                                                                 |
| Docker Desktop             | Docker Desktop                       | 0       | Docker Desktop Installer.exe                                | 0        | https://www.docker.com/                                                                | https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe                                                                                                                                              | C:\Apps\Docker\Docker                               | install --quiet --accept-license --backend=wsl-2 --no-windows-containers                                                                                                                                                |                                                            | 0        | https://docs.docker.com/desktop/setup/install/windows-install/#install-from-the-command-line                                                                                                                                                               |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | --installation-dir=path                                                                                                 |
| Neat Download Manager      | Neat Download Manager                | 0       | NeatDM_setup.exe                                            | 0        | https://www.neatdownloadmanager.com/                                                   | https://www.neatdownloadmanager.com/file/NeatDM_setup.exe                                                                                                                                                               | C:\Apps\Neat Download Manager                       | /VERYSILENT                                                                                                                                                                                                             |                                                            | 0        | https://jrsoftware.org/ishelp/index.php?topic=setupcmdline                                                                                                                                                                                                 |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /DIR="path"                                                                                                             |
| GeForce Drivers            | GeForce Drivers                      | 0       | 560.94-desktop-win10-win11-64bit-international-dch-whql.exe | 0        | https://www.nvidia.com/en-us/geforce/                                                  | https://us.download.nvidia.com/Windows/560.94/560.94-desktop-win10-win11-64bit-international-dch-whql.exe                                                                                                               |                                                     | -s -n Display.Driver                                                                                                                                                                                                    |                                                            | 0        | https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/#silent-installation                                                                                                                                                                    |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 |                                                                                                                         |
| Pandoc                     | Pandoc                               | 0       | pandoc-3.7.0.2-windows-x86_64.msi                           | 0        | https://pandoc.org/                                                                    | https://github.com/jgm/pandoc/releases/download/3.7.0.2/pandoc-3.7.0.2-windows-x86_64.msi                                                                                                                               | C:\Apps\Pandoc                                      | /passive                                                                                                                                                                                                                |                                                            | 0        | https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec                                                                                                                                                                   |                                                                                                                                                                      |                                   | pandoc --version |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | APPLICATIONFOLDER="path"                                                                                                |
| Apache Tomcat              | Apache Tomcat                        | 0       | apache-tomcat-9.0.108.exe                                   | 0        | https://tomcat.apache.org/                                                             | https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.108/bin/apache-tomcat-9.0.108.exe                                                                                                                                         | C:\Apps\apache-tomcat-9.0.108                       | /S                                                                                                                                                                                                                      |                                                            | 0        | https://tomcat.apache.org/tomcat-9.0-doc/setup.html#Windows                                                                                                                                                                                                |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /D=path                                                                                                                 |
| VMware Workstation         | VMware Workstation                   | 0       | VMware-workstation-full-17.6.4-24832109.exe                 | 0        | https://www.vmware.com/                                                                |                                                                                                                                                                                                                         | C:\Apps\VMware\VMware Workstation                   | /s                                                                                                                                                                                                                      |                                                            | 0        | https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/17-0/using-vmware-workstation-pro/installing-and-using-workstation-pro/installing-workstation-pro/run-an-unattended-workstation-pro-installation-on-a-windows-host.html | https://techdocs.broadcom.com/cn/zh-cn/vmware-cis/desktop-hypervisors/workstation-pro/17-0/using-vmware-workstation-pro/using-vmcli-to-control-virtual-machines.html |                                   |                  |          |       |                                                                                    | 0         |                        | /v"/qn EULAS_AGREED=1 INSTALLDIR="path" AUTOSOFTWAREUPDATE=0 DATACOLLECTION=0"                                          |
| MySQL                      | MySQL                                | 0       | mysql-8.4.6-winx64.msi                                      | 0        | https://www.mysql.com/                                                                 | https://cdn.mysql.com/Downloads/MySQL-8.4/mysql-8.4.6-winx64.msi                                                                                                                                                        | C:\Apps\MySQL\MySQL Server 8.4                      | /qn                                                                                                                                                                                                                     |                                                            | 0        | https://dev.mysql.com/doc/refman/8.4/en/windows-installation.html                                                                                                                                                                                          |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | INSTALLDIR="path"                                                                                                       |
| GnuPG                      | GnuPG                                | 0       | gpg4win-4.4.1.exe                                           | 0        | https://www.gpg4win.org/                                                               | https://files.gpg4win.org/gpg4win-4.4.1.exe                                                                                                                                                                             | C:\Apps\Gpg4win                                     | /S                                                                                                                                                                                                                      |                                                            | 0        | https://www.gpg4win.org/doc/en/gpg4win-compendium_35.html                                                                                                                                                                                                  |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /D=path                                                                                                                 |
| VirtualBox                 | VirtualBox                           | 0       | VirtualBox-7.2.0-170228-Win.exe                             | 0        | https://www.virtualbox.org/                                                            | https://download.virtualbox.org/virtualbox/7.2.0/VirtualBox-7.2.0-170228-Win.exe                                                                                                                                        | C:\Oracle\VirtualBox                                | --silent                                                                                                                                                                                                                |                                                            | 0        | https://www.virtualbox.org/manual/topics/installation.html#install-win-unattended                                                                                                                                                                          |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | --msiparams "ALLUSERS=1 VBOX_INSTALLDESKTOPSHORTCUT=0 VBOX_INSTALLQUICKLAUNCHSHORTCUT=0 VBOX_START=0 INSTALLDIR="path"" |
| MySQL 5.7                  | MySQL 5.7                            | 0       | mysql-installer-community-5.7.44.0.msi                      | 0        | https://www.mysql.com/                                                                 | https://cdn.mysql.com/Downloads/MySQLInstaller/mysql-installer-community-5.7.44.0.msi                                                                                                                                   |                                                     | /qn INSTALLLOCATION="" DATALOCATION=""                                                                                                                                                                                  |                                                            | 0        | https://dev.mysql.com/doc/mysql-installer/en/MySQLInstallerConsole.html                                                                                                                                                                                    |                                                                                                                                                                      | .\MySQL\after-install.ps1         |                  |          |       |                                                                                    | 0         |                        |                                                                                                                         |
| Erlang                     | Erlang                               | 0       | otp_win64_27.3.4.2.exe                                      | 0        | https://www.erlang.org/                                                                | https://github.com/erlang/otp/releases/download/OTP-27.3.4.2/otp_win64_27.3.4.2.exe                                                                                                                                     | C:\Apps\Erlang OTP                                  | /S                                                                                                                                                                                                                      |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | /D=path                                                                                                                 |
| RabbitMQ                   | RabbitMQ                             | 0       | rabbitmq-server-4.1.3.exe                                   | 0        | https://www.rabbitmq.com/                                                              | https://github.com/rabbitmq/rabbitmq-server/releases/download/v4.1.3/rabbitmq-server-4.1.3.exe                                                                                                                          | C:\Apps\RabbitMQ Server                             | /S                                                                                                                                                                                                                      |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      | .\RabbitMQ\after-install.ps1      |                  |          |       |                                                                                    | 0         |                        | /D=path                                                                                                                 |
| Zen Browser                | Zen Browser                          | 0       | zen.installer.exe                                           | 0        | https://zen-browser.app/                                                               | https://github.com/zen-browser/desktop/releases/latest/download/zen.installer.exe                                                                                                                                       | C:\Apps\Zen Browser                                 | /S                                                                                                                                                                                                                      |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | /D=path                                                                                                                 |
| Fiddler                    | Fiddler                              | 0       | FiddlerSetup.5.0.20253.3311-latest.exe                      | 0        | https://www.telerik.com/fiddler/fiddler-classic                                        | https://downloads.getfiddler.com/fiddler-classic/FiddlerSetup.5.0.20253.3311-latest.exe                                                                                                                                 | C:\Apps\Fiddler                                     | /S                                                                                                                                                                                                                      |                                                            | 0        | https://api.getfiddler.com/fc/latest                                                                                                                                                                                                                       |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /D=path                                                                                                                 |
| Redis Insight              | Redis Insight                        | 0       | Redis-Insight-win-installer.exe                             | 0        | https://redis.io/insight/                                                              | https://s3.amazonaws.com/redisinsight.download/public/latest/Redis-Insight-win-installer.exe                                                                                                                            | C:\Apps\Redis Insight                               | /S /allusers                                                                                                                                                                                                            |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /D="path"                                                                                                               |
| Ditto                      | Ditto                                | 0       | DittoSetup_3_25_76_0.exe                                    | 0        | https://github.com/sabrogden/Ditto                                                     | https://github.com/sabrogden/Ditto/releases/download/3.25.76.0/DittoSetup_3_25_76_0.exe                                                                                                                                 | C:\Apps\Ditto                                       | /VERYSILENT /ALLUSERS                                                                                                                                                                                                   |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | /DIR="path"                                                                                                             |
| FastStone Image Viewer     | FastStone Image Viewer               | 0       | FSViewerSetup81.exe                                         | 0        | https://www.faststone.org/index.htm                                                    | https://www.faststone.org/DN/FSViewerSetup81.exe                                                                                                                                                                        | C:\Apps\FastStone Image Viewer                      | /S                                                                                                                                                                                                                      |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | /D=path                                                                                                                 |
| TinyTask                   | TinyTask                             | 0       | with-editor.exe                                             | 0        | https://tinytask.net/                                                                  | https://dl.tinytask.net/with-editor.exe                                                                                                                                                                                 | C:\Apps\AutomaticSolution Software\ReMouse Standard | /VERYSILENT                                                                                                                                                                                                             |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /DIR="path"                                                                                                             |
| WSL                        | WSL                                  | 0       | wsl.2.5.10.0.x64.msi                                        | 0        | https://wsl.dev/                                                                       | https://github.com/microsoft/WSL/releases/download/2.5.10/wsl.2.5.10.0.x64.msi                                                                                                                                          |                                                     | /qn                                                                                                                                                                                                                     |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      | .\WSL2\after-install.ps1          |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 |                                                                                                                         |
| Podman                     | Podman                               | 0       | podman-5.6.0-setup.exe                                      | 0        | https://podman.io/                                                                     | https://github.com/containers/podman/releases/download/v5.6.0/podman-5.6.0-setup.exe                                                                                                                                    | C:\Apps\Podman                                      | /quiet MachineProvider=wsl AllowOldWin=1                                                                                                                                                                                |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 | InstallFolder="path"                                                                                                    |
| Vivaldi                    | Vivaldi                              | 0       | Vivaldi.7.5.3735.64.x64.exe                                 | 0        | https://vivaldi.com/                                                                   | https://downloads.vivaldi.com/stable/Vivaldi.7.5.3735.64.x64.exe                                                                                                                                                        |                                                     | --vivaldi-silent --do-not-launch-chrome --system-level                                                                                                                                                                  |                                                            | 0        |                                                                                                                                                                                                                                                            | https://vivaldi.com/download/archive/                                                                                                                                |                                   |                  |          |       |                                                                                    | 1         | http://127.0.0.1:10808 |                                                                                                                         |
| LibreOffice                | LibreOffice                          | 0       | LibreOffice_25.8.0_Win_x86-64.msi                           | 0        | https://www.libreoffice.org/                                                           | https://download.documentfoundation.org/libreoffice/stable/25.8.0/win/x86_64/LibreOffice_25.8.0_Win_x86-64.msi                                                                                                          | C:\Apps\LibreOffice                                 | /qn ALLUSERS=1 CREATEDESKTOPLINK=1 REGISTER_NO_MSO_TYPES=1 UI_LANGS=en_GB ISCHECKFORPRODUCTUPDATES=0 RebootYesNo=No QUICKSTART=0 ADDLOCAL=ALL VC_REDIST=0                                                               |                                                            | 0        | https://wiki.documentfoundation.org/Deployment_and_Migration                                                                                                                                                                                               |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | INSTALLLOCATION="path"                                                                                                  |
| Thunderbird                | Thunderbird                          | 0       | Thunderbird Setup 142.0.exe                                 | 0        | https://www.thunderbird.net/en-US/                                                     | https://download-installer.cdn.mozilla.net/pub/thunderbird/releases/142.0/win64/en-US/Thunderbird%20Setup%20142.0.exe                                                                                                   | C:\Apps\Mozilla Thunderbird                         | /S /DesktopShortcut=true /MaintenanceService=false /TaskbarShortcut=false                                                                                                                                               |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /InstallDirectoryPath="path"                                                                                            |
| EmEditor                   | EmEditor                             | 0       | emed64_25.3.0.msi                                           | 0        | https://www.emeditor.com/                                                              | https://download.emeditor.info/emed64_25.3.0.msi                                                                                                                                                                        | C:\Apps\EmEditor                                    | /qn NOCHECKUPDATES=1 DESKTOP=1 NOIEEDITOR=1 NOIEVIEW=1                                                                                                                                                                  |                                                            | 0        | https://www.emeditor.com/faq/installation-faq/how-can-i-install-emeditor-without-displaying-dialog-boxes/                                                                                                                                                  | https://www.emeditor.com/faq/installation-faq/how-can-i-change-the-install-folder/                                                                                   |                                   |                  |          |       |                                                                                    | 0         |                        | APPDIR="path"                                                                                                           |
| ImageMagick                | ImageMagick                          | 0       | ImageMagick-7.1.2-1-Q16-HDRI-x64-dll.exe                    | 0        | https://imagemagick.org/                                                               | https://imagemagick.org/archive/binaries/ImageMagick-7.1.2-1-Q16-HDRI-x64-dll.exe                                                                                                                                       | C:\Apps\ImageMagick-7.1.2-Q16-HDRI                  | /VERYSILENT /NORESTART /FORCECLOSEAPPLICATIONS /SUPPRESSMSGBOXES /NOICONS /MERGETASKS="modifypath,install_ffmpeg,install_perlmagick,legacy_support"                                                                     |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /DIR="path"                                                                                                             |
| MediaInfo                  | MediaInfo                            | 0       | MediaInfo_GUI_25.07_Windows_x64.exe                         | 0        | https://mediaarea.net/en/MediaInfo                                                     | https://mediaarea.net/download/binary/mediainfo-gui/25.07/MediaInfo_GUI_25.07_Windows_x64.exe                                                                                                                           | C:\Apps\MediaInfo                                   | /S                                                                                                                                                                                                                      |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /D=path                                                                                                                 |
| Honeyview                  | Honeyview                            | 0       | HONEYVIEW-SETUP.EXE                                         | 0        | https://www.bandisoft.com/honeyview/                                                   | https://bandisoft.app/honeyview/HONEYVIEW-SETUP.EXE                                                                                                                                                                     | C:\Apps\Honeyview                                   | /S                                                                                                                                                                                                                      |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /D=path                                                                                                                 |
| XnView MP                  | XnView MP                            | 0       | XnViewMP-win-x64.exe                                        | 0        | https://www.xnview.com/en/                                                             | https://download.xnview.com/XnViewMP-win-x64.exe                                                                                                                                                                        | C:\Apps\XnViewMP                                    | /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-                                                                                                                                                                           |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        | /DIR="path"                                                                                                             |
| Google Chrome              | Chrome                               | 0       | ChromeStandaloneSetup64.exe                                 | 0        | https://www.google.cn/intl/zh-CN/chrome/                                               | https://dl.google.com/tag/s/appguid=%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D&lang=zh-CN&usagestats=0&appname=Google%2520Chrome&needsadmin=prefers&ap=x64-stable-statsdef_1/chrome/install/ChromeStandaloneSetup64.exe |                                                     | --silent --do-not-launch-chrome --system-level                                                                                                                                                                          |                                                            | 0        |                                                                                                                                                                                                                                                            |                                                                                                                                                                      |                                   |                  |          |       |                                                                                    | 0         |                        |                                                                                                                         |

## CSV format file

```csv
app,name,install,package,download,home,curl,install_dir,params,ok_message,del_flag,link,link2,after_install,verification,codepage,admin,fetch_mirrors,use_proxy,proxy,spec_dir
7-Zip,7-Zip,0,7z2501-x64.exe,0,https://7-zip.org/,https://7-zip.org/a/7z2501-x64.exe,C:\Apps\7-Zip,/S,"",0,https://7-zip.org/faq.html,"","","","","","",0,"","/D=""path"""
DBeaver,DBeaver,0,dbeaver-ce-25.1.5-x86_64-setup.exe,0,https://dbeaver.io/,https://github.com/dbeaver/dbeaver/releases/download/25.1.5/dbeaver-ce-25.1.5-x86_64-setup.exe,C:\Apps\DBeaver,/S /allusers,"",0,https://dbeaver.com/docs/dbeaver/Windows-Silent-Install/,https://github.com/dbeaver/dbeaver/wiki/Windows-Silent-Install,"","","","","",1,http://127.0.0.1:10808,/D=path
Eudic,Eudic,0,eudic_win.exe,0,https://www.eudic.net/v4/en/app/eudic,https://www.eudic.net/download/eudic_win.zip?v=2025-07-25,"",/SD,"",0,"","","","","","","",0,"",""
FDM,Free Download Manager,0,fdm_x64_setup.exe,0,https://www.freedownloadmanager.org/,https://files2.freedownloadmanager.org/6/latest/fdm_x64_setup.exe,C:\Apps\Free Download Manager,/VERYSILENT /ALLUSERS,You have successfully installed FDM,0,https://jrsoftware.org/ishelp/index.php?topic=setupcmdline,"","","","","","",1,http://127.0.0.1:10808,"/DIR=""path"""
FileZilla Server,FileZilla Server,0,FileZilla_Server_1.10.5_win64-setup.exe,0,https://filezilla-project.org/,"",C:\Apps\FileZilla Server,/S /user=all,"",0,https://wiki.filezilla-project.org/Silent_Setup,"",.\FileZilla\after-install.ps1,"","","","",0,"",/D=path
Firefox,Mozilla Firefox,0,Firefox Setup 140.2.0esr.exe,0,https://www.firefox.com/en-US/,https://ftp.mozilla.org/pub/firefox/releases/140.2.0esr/win64/en-US/Firefox%20Setup%20140.2.0esr.exe,C:\Apps\Mozilla Firefox,/S /DesktopShortcut=true /MaintenanceService=false /TaskbarShortcut=false /PrivateBrowsingShortcut=false,"",0,https://firefox-source-docs.mozilla.org/browser/installer/windows/installer/FullConfig.html,"","","","","","",0,"","/InstallDirectoryPath=""path"""
FxSound,FxSound,0,fxsound_setup.exe,0,https://www.fxsound.com/,https://github.com/fxsound2/fxsound-app/releases/download/latest/fxsound_setup.exe,C:\Apps\FxSound,/exenoui /exenoupdates,"",0,https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec,"","","","","","",1,http://127.0.0.1:10808,"APPDIR=""path"""
Git,Git,0,Git-2.50.1-64-bit.exe,0,https://gitforwindows.org/,https://github.com/git-for-windows/git/releases/download/v2.50.1.windows.1/Git-2.50.1-64-bit.exe,C:\Apps\Git,/VERYSILENT,"",0,"","","",git version,"","","",1,http://127.0.0.1:10808,"/DIR=""path"""
IDM,Internet Download Manager,0,idman642build42.exe,0,https://www.internetdownloadmanager.com/,https://mirror2.internetdownloadmanager.com/idman642build42.exe,"",/skipdlgs,"",0,https://www.internetdownloadmanager.com/register/new_faq/functions21.html,"","","","","","",0,"",""
ImageGlass,ImageGlass,0,ImageGlass_9.3.2.520_x64.msi,0,https://imageglass.org/,https://github.com/d2phap/ImageGlass/releases/download/9.3.2.520/ImageGlass_9.3.2.520_x64.msi,C:\Apps\ImageGlass,/passive,"",0,https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec,"","","","","","",1,http://127.0.0.1:10808,"APPDIR=""path"""
Java,JRE,0,jre-8u461-windows-x64.exe,0,https://www.java.com/en/,https://javadl.oracle.com/webapps/download/AutoDL?BundleId=252322_68ce765258164726922591683c51982c,C:\Java\jre1.8.0_461,/s INSTALL_SILENT=1 WEB_JAVA=0 NOSTARTMENU=1,"",0,https://www.java.com/en/download/help/silent_install.html,"",.\Java\after-install-jre.ps1,java -version,1,0,"",0,"",INSTALLDIR=path
Java,JDK,0,jdk-8u202-windows-x64.exe,0,https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html,!!!important!!!Required login https://download.oracle.com/otn/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-windows-x64.exe,C:\Java\jdk1.8.0_202,"/s INSTALL_SILENT=1 ADDLOCAL=""ToolsFeature,SourceFeature"" NOSTARTMENU=1","",0,https://www.java.com/en/download/help/silent_install.html,"",.\Java\after-install.ps1,java -version,1,0,"",0,"",INSTALLDIR=path
MSYS2,MSYS2,0,msys2-base-x86_64-20250622.sfx.exe,0,https://www.msys2.org/,https://github.com/msys2/msys2-installer/releases/download/2025-06-22/msys2-base-x86_64-20250622.sfx.exe,C:\Apps\,-y,"",0,https://www.msys2.org/docs/installer/,"","","","","",https://mirrors.nju.edu.cn/msys2/distrib/x86_64/msys2-base-x86_64-20250622.sfx.exe,1,http://127.0.0.1:10808,-opath
Node.js,nodejs,0,node-v20.19.4-x64.msi,0,https://nodejs.org/en,https://nodejs.org/dist/v20.19.4/node-v20.19.4-x64.msi,C:\Apps\nodejs,/passive,"",0,https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec,"","",node -v,"","","",0,"","INSTALLDIR=""path"""
PeaZip,PeaZip,0,peazip-10.6.0.WIN64.exe,0,https://peazip.github.io/,https://github.com/peazip/PeaZip/releases/download/10.6.0/peazip-10.6.0.WIN64.exe,C:\Apps\PeaZip,"/VERYSILENT /ALLUSERS /MERGETASKS=""!desktopicon""","",0,https://peazip.github.io/peazip-help-faq.html#run_peazip_on_microsoft_windows,"","","","","","",1,http://127.0.0.1:10808,"/DIR=""path"""
Podman Desktop,Podman Desktop,0,podman-desktop-airgap-1.20.2-setup-x64.exe,0,https://podman-desktop.io/,https://github.com/podman-desktop/podman-desktop/releases/download/v1.20.2/podman-desktop-airgap-1.20.2-setup-x64.exe,C:\Apps\Podman Desktop,/S,"",0,https://podman-desktop.io/docs/installation/windows-install#silent-windows-installer,https://github.com/containers/podman/blob/main/build_windows.md,.\PodmanDesktop\after-install.ps1,"","","","",1,http://127.0.0.1:10808,"/D=""path"""
Postman,Postman,0,Postman-win64-9.31.28-Setup.exe,0,https://www.postman.com/,https://dl.pstmn.io/download/version/9.31.28/win64,"","","",0,https://learning.postman.com/docs/administration/enterprise/managing-enterprise-deployment/,"","","","","","",0,"",""
PowerToys,PowerToys,0,PowerToysSetup-0.93.0-x64.exe,0,https://learn.microsoft.com/en-us/windows/powertoys/,https://github.com/microsoft/PowerToys/releases/download/v0.93.0/PowerToysSetup-0.93.0-x64.exe,C:\Apps\PowerToys,/passive,"",0,https://learn.microsoft.com/en-us/windows/powertoys/install#command-line-installer-arguments,"","","","","","",1,http://127.0.0.1:10808,"InstallFolder=""path"""
Rime,Rime,0,weasel-0.17.4.0-installer.exe,0,https://rime.im/,https://github.com/rime/weasel/releases/download/0.17.4/weasel-0.17.4.0-installer.exe,"",/S /ls /du /toggleime /release,"",0,https://github.com/rime/weasel/blob/master/WeaselSetup/WeaselSetup.cpp#L163-L179,"","","","","","",1,http://127.0.0.1:10808,""
ShareX,ShareX,0,ShareX-18.0.1-setup.exe,0,https://getsharex.com/,https://github.com/ShareX/ShareX/releases/download/v18.0.1/ShareX-18.0.1-setup.exe,C:\Apps\ShareX,/VERYSILENT /NORUN,"",0,https://getsharex.com/docs/command-line-arguments#sharex-setup-cli,"","","","","","",1,http://127.0.0.1:10808,"/DIR=""path"""
SMPlayer,SMPlayer,0,smplayer-25.6.0-x64-unsigned.exe,0,https://smplayer.info/,https://github.com/smplayer-dev/smplayer/releases/download/v25.6.0/smplayer-25.6.0-x64-unsigned.exe,C:\Apps\SMPlayer,/S,SMPlayer has been successfully installed on your computer.,0,https://nsis.sourceforge.io/Docs/Chapter3.html#3.2.1,"","","","","","",1,http://127.0.0.1:10808,/D=path
Starship,starship,0,starship-x86_64-pc-windows-msvc.msi,0,https://starship.rs/,https://github.com/starship/starship/releases/download/v1.23.0/starship-x86_64-pc-windows-msvc.msi,C:\Apps\starship,/passive,"",0,https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec,"",.\starship\starship.bat,"","","","",1,http://127.0.0.1:10808,"APPLICATIONFOLDER=""path"""
Sumatra PDF,SumatraPDF,0,SumatraPDF-3.5.2-64-install.exe,0,https://www.sumatrapdfreader.org/free-pdf-reader,https://www.sumatrapdfreader.org/dl/rel/3.5.2/SumatraPDF-3.5.2-64-install.exe,C:\Apps\SumatraPDF,-s -with-preview -all-users,"",0,https://www.sumatrapdfreader.org/docs/Installer-cmd-line-arguments,"","","","","","",0,"","-d ""path"""
Tabby,Tabby,0,tabby-1.0.227-setup-x64.exe,0,https://tabby.sh/,https://github.com/Eugeny/tabby/releases/download/v1.0.227/tabby-1.0.227-setup-x64.exe,C:\Apps\Tabby,/S /allusers,"",0,https://github.com/Eugeny/tabby/issues,"","","","","","",1,http://127.0.0.1:10808,/D=path
ungoogled-chromium,ungoogled-chromium,0,ungoogled-chromium_139.0.7258.138-1.1_installer_x64.exe,0,https://github.com/ungoogled-software/ungoogled-chromium-windows,https://github.com/ungoogled-software/ungoogled-chromium-windows/releases/download/139.0.7258.138-1.1/ungoogled-chromium_139.0.7258.138-1.1_installer_x64.exe,"",--install --silent --do-not-launch-chrome --system-level,"",0,"","","","","","","",1,http://127.0.0.1:10808,""
Visual C++ Redistributable,Microsoft Visual C++ Redistributable,0,VC_redist.x64.exe,0,https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170,https://aka.ms/vs/17/release/vc_redist.x64.exe,"",/install /passive /norestart,"",0,https://learn.microsoft.com/en-us/cpp/windows/redistributing-visual-cpp-files?view=msvc-170#command-line-options-for-the-redistributable-packages,"","","","","","",0,"",""
Visual C++ Redistributable,Microsoft Visual C++ Redistributable,0,VC_redist.x86.exe,0,https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170,https://aka.ms/vs/17/release/vc_redist.x86.exe,"",/install /passive /norestart,"",0,https://learn.microsoft.com/en-us/cpp/windows/redistributing-visual-cpp-files?view=msvc-170#command-line-options-for-the-redistributable-packages,"","","","","","",0,"",""
VSCode,Microsoft VS Code,0,VSCodeSetup-x64-1.102.1.exe,0,https://code.visualstudio.com/,https://code.visualstudio.com/sha/download?build=stable&os=win32-x64,C:\Apps\Microsoft VS Code,"/VERYSILENT /mergetasks=""desktopicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,!runcode""","",0,https://jrsoftware.org/ishelp/index.php?topic=setupcmdline,https://github.com/Microsoft/vscode/blob/main/build/win32/code.iss,"","","","","",0,"","/DIR=""path"""
WinSCP,WinSCP,0,WinSCP-6.5.3-Setup.exe,0,https://winscp.net/eng/index.php,https://winscp.net/download/WinSCP-6.5.3-Setup.exe/download,C:\Apps\WinSCP,/VERYSILENT /ALLUSERS,"",0,https://winscp.net/eng/docs/installation,"","","","","","",0,"","/DIR=""path"""
XMind 8,XMind,0,xmind-8-update9-windows.exe,0,https://xmind.com/download/xmind8/,https://www.xmind.app/xmind/downloads/xmind-8-update9-windows.exe,C:\Apps\XMind,/VERYSILENT,"",0,https://jrsoftware.org/ishelp/index.php?topic=setupcmdline,"","","","","","",0,"","/DIR=""path"""
Zeal,Zeal,0,zeal-0.7.2-windows-x64.msi,0,https://zealdocs.org/,https://github.com/zealdocs/zeal/releases/download/v0.7.2/zeal-0.7.2-windows-x64.msi,C:\Apps\Zeal,/passive,"",0,https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec,"","","","","","",1,http://127.0.0.1:10808,"INSTALL_ROOT=""path"""
PostgreSQL,PostgreSQL,0,postgresql-15.13-3-windows-x64.exe,0,https://www.postgresql.org/,https://sbp.enterprisedb.com/getfile.jsp?fileid=1259617,C:\Apps\PostgreSQL\15,"--create_shortcuts 1 --mode unattended --unattendedmodeui none --superaccount postgres --superpassword postgres --serverport 5432 --disable-components pgAdmin,stackbuilder --enable-components server,commandlinetools","",0,https://www.enterprisedb.com/docs/supported-open-source/postgresql/installing/command_line_parameters/,"",.\PostgreSQL\after-install.ps1,"","","","",0,"","--prefix ""path"" --datadir ""path\data"""
Eclipse Adoptium,Eclipse Adoptium,0,OpenJDK17U-jdk_x64_windows_hotspot_17.0.12_7.msi,0,https://adoptium.net/,https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.12%2B7/OpenJDK17U-jdk_x64_windows_hotspot_17.0.12_7.msi,C:\Apps\Eclipse Adoptium\jdk-17.0.12.7-hotspot\,"/quiet ADDLOCAL=FeatureMain,FeatureEnvironment,FeatureJarFileRunWith,FeatureJavaHome","",0,https://adoptium.net/installation/windows#command-line-installation,"","","","","","",1,http://127.0.0.1:10808,"INSTALLDIR=""path"""
Jenkins,Jenkins,0,jenkins.msi,0,https://www.jenkins.io/,https://get.jenkins.io/windows-stable/2.516.1/jenkins.msi,C:\Apps\Jenkins,"/qn /norestart PORT=8080 JAVA_HOME=""C:\Apps\Eclipse Adoptium\jdk-17.0.12.7-hotspot""","",0,https://www.jenkins.io/doc/book/installing/windows/#silent-install-with-the-msi-installers,"","","","","","",0,"","INSTALLDIR=""path"""
OBS Studio,OBS Studio,0,OBS-Studio-31.1.2-Windows-x64-Installer.exe,0,https://obsproject.com/,https://github.com/obsproject/obs-studio/releases/download/31.1.2/OBS-Studio-31.1.2-Windows-x64-Installer.exe,C:\Apps\obs-studio,/S,"",0,"","","","","","","",1,http://127.0.0.1:10808,/D=path
VLC media player,VLC,0,vlc-3.0.21-win64.exe,0,https://www.videolan.org/,https://download.videolan.org/pub/videolan/vlc/3.0.21/win64/vlc-3.0.21-win64.exe,C:\Apps\VideoLAN\VLC,/L=1033 /S,"",0,https://wiki.videolan.org/Documentation:Installing_VLC/,"","","","","","",0,"",""
Acrobat Reader,Acrobat Reader,0,AcroRdrDC2500120577_en_US.exe,0,https://get.adobe.com/reader/enterprise/,https://ardownload3.adobe.com/pub/adobe/reader/win/AcrobatDC/2500120577/AcroRdrDC2500120577_en_US.exe,C:\Apps\Adobe\Acrobat Reader DC\Reader,"/sAll /rs /rps /sl ""1033""","",0,https://www.adobe.com/devnet-docs/acrobatetk/tools/DesktopDeployment/cmdline.html,"","","","","","",0,"","INSTALLDIR=""path"""
IntelliJ IDEA,IntelliJ IDEA,0,ideaIC-2025.2.exe,0,https://www.jetbrains.com/idea/,https://download.jetbrains.com/idea/ideaIC-2025.2.exe,C:\Apps\JetBrains\IntelliJ IDEA 2025.2,/S /CONFIG=.\IntelliJ IDEA\silent.config,"",0,https://www.jetbrains.com/help/idea/installation-guide.html#silent,"","","","","","",0,"",/D=path
Python,Python,0,python-3.13.6-amd64.exe,0,https://www.python.org/,https://www.python.org/ftp/python/3.13.6/python-3.13.6-amd64.exe,C:\Apps\Python313,/quiet InstallAllUsers=1 CompileAll=0 PrependPath=0 Shortcuts=0 Include_launcher=0 Include_test=0,"",0,https://docs.python.org/3/using/windows.html#installing-without-ui,"","","","","","",0,"","TargetDir=""path"""
Everything,Everything,0,Everything-1.4.1.1028.x64-Setup.exe,0,https://www.voidtools.com/,https://www.voidtools.com/Everything-1.4.1.1028.x64-Setup.exe,C:\Apps\Everything,"/S -install-options ""-app-data -enable-run-as-admin -disable-update-notification -uninstall-all-users-desktop-shortcut -uninstall-quick-launch-shortcut -uninstall-run-on-system-startup -language 2052""","",0,https://www.voidtools.com/forum/viewtopic.php?t=5673,"","","","","","",0,"",/D=path
Docker Desktop,Docker Desktop,0,Docker Desktop Installer.exe,0,https://www.docker.com/,https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe,C:\Apps\Docker\Docker,install --quiet --accept-license --backend=wsl-2 --no-windows-containers,"",0,https://docs.docker.com/desktop/setup/install/windows-install/#install-from-the-command-line,"","","","","","",0,"",--installation-dir=path
Neat Download Manager,Neat Download Manager,0,NeatDM_setup.exe,0,https://www.neatdownloadmanager.com/,https://www.neatdownloadmanager.com/file/NeatDM_setup.exe,C:\Apps\Neat Download Manager,/VERYSILENT,"",0,https://jrsoftware.org/ishelp/index.php?topic=setupcmdline,"","","","","","",0,"","/DIR=""path"""
GeForce Drivers,GeForce Drivers,0,560.94-desktop-win10-win11-64bit-international-dch-whql.exe,0,https://www.nvidia.com/en-us/geforce/,https://us.download.nvidia.com/Windows/560.94/560.94-desktop-win10-win11-64bit-international-dch-whql.exe,"",-s -n Display.Driver,"",0,https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/#silent-installation,"","","","","","",1,http://127.0.0.1:10808,""
Pandoc,Pandoc,0,pandoc-3.7.0.2-windows-x86_64.msi,0,https://pandoc.org/,https://github.com/jgm/pandoc/releases/download/3.7.0.2/pandoc-3.7.0.2-windows-x86_64.msi,C:\Apps\Pandoc,/passive,"",0,https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/msiexec,"","",pandoc --version,"","","",1,http://127.0.0.1:10808,"APPLICATIONFOLDER=""path"""
Apache Tomcat,Apache Tomcat,0,apache-tomcat-9.0.108.exe,0,https://tomcat.apache.org/,https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.108/bin/apache-tomcat-9.0.108.exe,C:\Apps\apache-tomcat-9.0.108,/S,"",0,https://tomcat.apache.org/tomcat-9.0-doc/setup.html#Windows,"","","","","","",0,"",/D=path
VMware Workstation,VMware Workstation,0,VMware-workstation-full-17.6.4-24832109.exe,0,https://www.vmware.com/,"",C:\Apps\VMware\VMware Workstation,/s,"",0,https://techdocs.broadcom.com/us/en/vmware-cis/desktop-hypervisors/workstation-pro/17-0/using-vmware-workstation-pro/installing-and-using-workstation-pro/installing-workstation-pro/run-an-unattended-workstation-pro-installation-on-a-windows-host.html,https://techdocs.broadcom.com/cn/zh-cn/vmware-cis/desktop-hypervisors/workstation-pro/17-0/using-vmware-workstation-pro/using-vmcli-to-control-virtual-machines.html,"","","","","",0,"","/v""/qn EULAS_AGREED=1 INSTALLDIR=""path"" AUTOSOFTWAREUPDATE=0 DATACOLLECTION=0"""
MySQL,MySQL,0,mysql-8.4.6-winx64.msi,0,https://www.mysql.com/,https://cdn.mysql.com/Downloads/MySQL-8.4/mysql-8.4.6-winx64.msi,C:\Apps\MySQL\MySQL Server 8.4,/qn,"",0,https://dev.mysql.com/doc/refman/8.4/en/windows-installation.html,"","","","","","",0,"","INSTALLDIR=""path"""
GnuPG,GnuPG,0,gpg4win-4.4.1.exe,0,https://www.gpg4win.org/,https://files.gpg4win.org/gpg4win-4.4.1.exe,C:\Apps\Gpg4win,/S,"",0,https://www.gpg4win.org/doc/en/gpg4win-compendium_35.html,"","","","","","",0,"",/D=path
VirtualBox,VirtualBox,0,VirtualBox-7.2.0-170228-Win.exe,0,https://www.virtualbox.org/,https://download.virtualbox.org/virtualbox/7.2.0/VirtualBox-7.2.0-170228-Win.exe,C:\Oracle\VirtualBox,--silent,"",0,https://www.virtualbox.org/manual/topics/installation.html#install-win-unattended,"","","","","","",0,"","--msiparams ""ALLUSERS=1 VBOX_INSTALLDESKTOPSHORTCUT=0 VBOX_INSTALLQUICKLAUNCHSHORTCUT=0 VBOX_START=0 INSTALLDIR=""path"""""
MySQL 5.7,MySQL 5.7,0,mysql-installer-community-5.7.44.0.msi,0,https://www.mysql.com/,https://cdn.mysql.com/Downloads/MySQLInstaller/mysql-installer-community-5.7.44.0.msi,"","/qn INSTALLLOCATION="""" DATALOCATION=""""","",0,https://dev.mysql.com/doc/mysql-installer/en/MySQLInstallerConsole.html,"",.\MySQL\after-install.ps1,"","","","",0,"",""
Erlang,Erlang,0,otp_win64_27.3.4.2.exe,0,https://www.erlang.org/,https://github.com/erlang/otp/releases/download/OTP-27.3.4.2/otp_win64_27.3.4.2.exe,C:\Apps\Erlang OTP,/S,"",0,"","","","","","","",1,http://127.0.0.1:10808,/D=path
RabbitMQ,RabbitMQ,0,rabbitmq-server-4.1.3.exe,0,https://www.rabbitmq.com/,https://github.com/rabbitmq/rabbitmq-server/releases/download/v4.1.3/rabbitmq-server-4.1.3.exe,C:\Apps\RabbitMQ Server,/S,"",0,"","",.\RabbitMQ\after-install.ps1,"","","","",0,"",/D=path
Zen Browser,Zen Browser,0,zen.installer.exe,0,https://zen-browser.app/,https://github.com/zen-browser/desktop/releases/latest/download/zen.installer.exe,C:\Apps\Zen Browser,/S,"",0,"","","","","","","",1,http://127.0.0.1:10808,/D=path
Fiddler,Fiddler,0,FiddlerSetup.5.0.20253.3311-latest.exe,0,https://www.telerik.com/fiddler/fiddler-classic,https://downloads.getfiddler.com/fiddler-classic/FiddlerSetup.5.0.20253.3311-latest.exe,C:\Apps\Fiddler,/S,"",0,https://api.getfiddler.com/fc/latest,"","","","","","",0,"",/D=path
Redis Insight,Redis Insight,0,Redis-Insight-win-installer.exe,0,https://redis.io/insight/,https://s3.amazonaws.com/redisinsight.download/public/latest/Redis-Insight-win-installer.exe,C:\Apps\Redis Insight,/S /allusers,"",0,"","","","","","","",0,"","/D=""path"""
Ditto,Ditto,0,DittoSetup_3_25_76_0.exe,0,https://github.com/sabrogden/Ditto,https://github.com/sabrogden/Ditto/releases/download/3.25.76.0/DittoSetup_3_25_76_0.exe,C:\Apps\Ditto,/VERYSILENT /ALLUSERS,"",0,"","","","","","","",1,http://127.0.0.1:10808,"/DIR=""path"""
FastStone Image Viewer,FastStone Image Viewer,0,FSViewerSetup81.exe,0,https://www.faststone.org/index.htm,https://www.faststone.org/DN/FSViewerSetup81.exe,C:\Apps\FastStone Image Viewer,/S,"",0,"","","","","","","",1,http://127.0.0.1:10808,/D=path
TinyTask,TinyTask,0,with-editor.exe,0,https://tinytask.net/,https://dl.tinytask.net/with-editor.exe,C:\Apps\AutomaticSolution Software\ReMouse Standard,/VERYSILENT,"",0,"","","","","","","",0,"","/DIR=""path"""
WSL,WSL,0,wsl.2.5.10.0.x64.msi,0,https://wsl.dev/,https://github.com/microsoft/WSL/releases/download/2.5.10/wsl.2.5.10.0.x64.msi,"",/qn,"",0,"","",.\WSL2\after-install.ps1,"","","","",1,http://127.0.0.1:10808,""
Podman,Podman,0,podman-5.6.0-setup.exe,0,https://podman.io/,https://github.com/containers/podman/releases/download/v5.6.0/podman-5.6.0-setup.exe,C:\Apps\Podman,/quiet MachineProvider=wsl AllowOldWin=1,"",0,"","","","","","","",1,http://127.0.0.1:10808,"InstallFolder=""path"""
Vivaldi,Vivaldi,0,Vivaldi.7.5.3735.64.x64.exe,0,https://vivaldi.com/,https://downloads.vivaldi.com/stable/Vivaldi.7.5.3735.64.x64.exe,"",--vivaldi-silent --do-not-launch-chrome --system-level,"",0,"",https://vivaldi.com/download/archive/,"","","","","",1,http://127.0.0.1:10808,""
LibreOffice,LibreOffice,0,LibreOffice_25.8.0_Win_x86-64.msi,0,https://www.libreoffice.org/,https://download.documentfoundation.org/libreoffice/stable/25.8.0/win/x86_64/LibreOffice_25.8.0_Win_x86-64.msi,C:\Apps\LibreOffice,/qn ALLUSERS=1 CREATEDESKTOPLINK=1 REGISTER_NO_MSO_TYPES=1 UI_LANGS=en_GB ISCHECKFORPRODUCTUPDATES=0 RebootYesNo=No QUICKSTART=0 ADDLOCAL=ALL VC_REDIST=0,"",0,https://wiki.documentfoundation.org/Deployment_and_Migration,"","","","","","",0,"","INSTALLLOCATION=""path"""
Thunderbird,Thunderbird,0,Thunderbird Setup 142.0.exe,0,https://www.thunderbird.net/en-US/,https://download-installer.cdn.mozilla.net/pub/thunderbird/releases/142.0/win64/en-US/Thunderbird%20Setup%20142.0.exe,C:\Apps\Mozilla Thunderbird,/S /DesktopShortcut=true /MaintenanceService=false /TaskbarShortcut=false,"",0,"","","","","","","",0,"","/InstallDirectoryPath=""path"""
EmEditor,EmEditor,0,emed64_25.3.0.msi,0,https://www.emeditor.com/,https://download.emeditor.info/emed64_25.3.0.msi,C:\Apps\EmEditor,/qn NOCHECKUPDATES=1 DESKTOP=1 NOIEEDITOR=1 NOIEVIEW=1,"",0,https://www.emeditor.com/faq/installation-faq/how-can-i-install-emeditor-without-displaying-dialog-boxes/,https://www.emeditor.com/faq/installation-faq/how-can-i-change-the-install-folder/,"","","","","",0,"","APPDIR=""path"""
ImageMagick,ImageMagick,0,ImageMagick-7.1.2-1-Q16-HDRI-x64-dll.exe,0,https://imagemagick.org/,https://imagemagick.org/archive/binaries/ImageMagick-7.1.2-1-Q16-HDRI-x64-dll.exe,C:\Apps\ImageMagick-7.1.2-Q16-HDRI,"/VERYSILENT /NORESTART /FORCECLOSEAPPLICATIONS /SUPPRESSMSGBOXES /NOICONS /MERGETASKS=""modifypath,install_ffmpeg,install_perlmagick,legacy_support""","",0,"","","","","","","",0,"","/DIR=""path"""
MediaInfo,MediaInfo,0,MediaInfo_GUI_25.07_Windows_x64.exe,0,https://mediaarea.net/en/MediaInfo,https://mediaarea.net/download/binary/mediainfo-gui/25.07/MediaInfo_GUI_25.07_Windows_x64.exe,C:\Apps\MediaInfo,/S,"",0,"","","","","","","",0,"",/D=path
Honeyview,Honeyview,0,HONEYVIEW-SETUP.EXE,0,https://www.bandisoft.com/honeyview/,https://bandisoft.app/honeyview/HONEYVIEW-SETUP.EXE,C:\Apps\Honeyview,/S,"",0,"","","","","","","",0,"",/D=path
XnView MP,XnView MP,0,XnViewMP-win-x64.exe,0,https://www.xnview.com/en/,https://download.xnview.com/XnViewMP-win-x64.exe,C:\Apps\XnViewMP,/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-,"",0,"","","","","","","",0,"","/DIR=""path"""
Google Chrome,Chrome,0,ChromeStandaloneSetup64.exe,0,https://www.google.cn/intl/zh-CN/chrome/,https://dl.google.com/tag/s/appguid=%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D&lang=zh-CN&usagestats=0&appname=Google%2520Chrome&needsadmin=prefers&ap=x64-stable-statsdef_1/chrome/install/ChromeStandaloneSetup64.exe,"",--silent --do-not-launch-chrome --system-level,"",0,"","","","","","","",0,"",""
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
                        if ( [String]::IsNullOrWhiteSpace($params))
                        {
                            Start-Process msiexec.exe -NoNewWindow -Wait -PassThru
                        }
                        else
                        {
                            $args = @("/i `"$package`"", $params)
                            if (-not [String]::IsNullOrWhiteSpace($arguments))
                            {
                                $args = @("/i `"$package`"", $params, $arguments)
                            }
                            Start-Process msiexec.exe -ArgumentList $args -NoNewWindow -Wait -PassThru
                        }
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
