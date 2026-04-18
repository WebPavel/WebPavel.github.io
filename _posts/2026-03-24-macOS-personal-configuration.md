---
layout: post
title: "macOS personal configuration"
date: 2026-03-24
excerpt: "Recently, I accidentally deleted my macOS user files, which caused the Photos app to fail to open and become unrepairable."
tags: [ macOS, Homebrew, App Store ]
comments: true
---

# macOS personal configuration

Recently, I accidentally deleted my macOS user files, which caused the Photos app to fail to open and become unrepairable.
I had to reinstall macOS and back up my frequently used apps and configuration settings.

## v2rayN

```shell
xattr -cr /Applications/v2rayN.app
#https://raw.githubusercontent.com/free18/v2ray/refs/heads/main/v.txt
#https://raw.githubusercontent.com/free18/v2ray/refs/heads/main/c.yaml
```

## Rosetta 2

```shell
/usr/sbin/softwareupdate --install-rosetta --agree-to-license
```

## Homebrew

### Install Xcode CLT

```shell
xcode-select --install
xcode-select --help
```

![Xcode CLT](/assets/photos/Snipaste_2026-03-24_01-45-51.png)

### Install Homebrew

```shell
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
echo 'export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"' >> ~/.zprofile
echo 'export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"' >> ~/.zprofile
echo 'export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"' >> ~/.zprofile
source ~/.zprofile
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
brew help
```

```shell
brew --version
brew update
brew doctor
brew install jq
brew install shfmt
brew install shellcheck
```

## git

```shell
git version
git config --global user.name "liubao"
git config --global user.email "paulluis.dev@gmail.com"
ssh-keygen -t rsa -b 4096 -C "paulluis.dev@gmail.com"
touch ~/.ssh/config
#Host alias
#  HostName localhost
#  User root
#  Port 22
#  IdentityFile ~/.ssh/id_rsa
```

## JDK 8

```shell
java -version
#java version "1.8.0_441"
#Java(TM) SE Runtime Environment (build 1.8.0_441-b07)
#Java HotSpot(TM) 64-Bit Server VM (build 25.441-b07, mixed mode)
```

## Maven

```shell
#!/usr/bin/env bash

bash --version 2>&1 | head -n 1

set -eo pipefail
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
echo "$SCRIPT_DIR"

MVN_GZ_URL="https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz"

if ! [[ -f "$SCRIPT_DIR//apache-maven-3.6.3-bin.tar.gz" ]]; then
    echo "Downloading from $MVN_GZ_URL"
    curl -Lsfo "$SCRIPT_DIR/apache-maven-3.6.3-bin.tar.gz" $MVN_GZ_URL
fi
if ! [[ -f "$SCRIPT_DIR//apache-maven-3.6.3-bin.tar.gz" ]]; then
    echo "Please download manually."
    exit -1
fi

if ! [[ -d "/opt/apache-maven-3.6.3" ]]; then
    echo "Extracting..."
    sudo tar xzvf apache-maven-3.6.3-bin.tar.gz -C /opt
fi

echo "$PATH"
echo 'export PATH="$PATH:/opt/apache-maven-3.6.3/bin"' >> ~/.zshenv
source ~/.zshenv
mvn -v
```

### Define a specified repository

```shell
sudo vim /opt/apache-maven-3.6.3/conf/settings.xml
#test
mvn help:system
#determine effective settings
mvn help:effective-settings
```

```xml

<mirror>
    <id>aliyunmaven</id>
    <mirrorOf>*</mirrorOf>
    <name>阿里云公共仓库</name>
    <url>https://maven.aliyun.com/repository/public</url>
</mirror>

```

## ~~Postman~~

Download [Postman](https://dl.pstmn.io/download/version/9.31.28/osx_arm64)

## JetBrains Toolbox

The last version to support both Community and Unified updates is [Version 3.2](https://download.jetbrains.com/toolbox/jetbrains-toolbox-3.2.0.65851-arm64.dmg)

## Windows App

Download [Windows App from the Mac App Store](https://aka.ms/macOSWindowsApp).

You can also download Windows App outside of the Mac App Store as a .pkg file from [https://go.microsoft.com/fwlink/?linkid=868963](https://officecdnmac.microsoft.com/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/Windows_App_11.3.3_installer.pkg).

## Microsoft Office

Select the Office Home 2024 for Mac version from the [website](https://files.rg-adguard.net/category) → Applications → Office 2024 for Mac → Multi-Language → [Microsoft_365_and_Office_16.94.25020927_HomeStudent_Installer.pkg](https://officecdn.microsoft.com/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/Microsoft_365_and_Office_16.94.25020927_HomeStudent_Installer.pkg).

## Spotify

Download the arm64 version from the official [Spotify CDN](https://download.scdn.co/SpotifyARM64.dmg).

## Application Requirements

| name                        | url                                                                                           | Architecture | pros & cons                     |
|-----------------------------|-----------------------------------------------------------------------------------------------|--------------|---------------------------------|
| ~~Google Chrome~~           | https://www.google.cn/chrome/<br>https://www.google.com/chrome/                               | aarch64      | MV2 disabled                    |
| ~~Helium~~                  | https://helium.computer/<br>https://github.com/imputnet/helium                                | aarch64      | light & MV2 enabled             |
| Vivaldi                     | https://vivaldi.com/                                                                          | aarch64      | MV2 enabled && sync             |
| FDM                         | https://www.freedownloadmanager.org/                                                          | Intel64      |                                 |
| v2rayN                      | https://github.com/2dust/v2rayN                                                               | aarch64      |                                 |
| Clash Verge                 | https://github.com/clash-verge-rev/clash-verge-rev                                            | aarch64      |                                 |
| IDEA                        | https://www.jetbrains.com/idea/                                                               | aarch64      |                                 |
| Visual Studio Code          | https://code.visualstudio.com/<br>https://github.com/microsoft/vscode                         | aarch64      |                                 |
| Homebrew                    | https://brew.sh/<br>https://github.com/Homebrew/brew                                          | aarch64      |                                 |
| Stats                       | https://mac-stats.com/                                                                        | aarch64      |                                 |
| XnView MP                   | https://www.xnview.com/                                                                       | aarch64      |                                 |
| ~~Snipaste~~                | https://www.snipaste.com/                                                                     | aarch64      | purchase to unlock Pro features |
| Shottr                      | https://shottr.cc/                                                                            | aarch64      | free & OCR                      |
| Eudic                       | https://www.eudic.net/                                                                        | aarch64      |                                 |
| JDK 8                       | https://www.oracle.com/java/technologies/javase/javase8u211-later-archive-downloads.html      | aarch64      |                                 |
| Pandoc                      | https://pandoc.org/<br>https://github.com/jgm/pandoc                                          | aarch64      |                                 |
| Docker                      | https://www.docker.com/                                                                       | aarch64      |                                 |
| Maven                       | https://maven.apache.org/<br>https://github.com/apache/maven/                                 | aarch64      |                                 |
| Keka                        | https://www.keka.io/<br>https://github.com/aonez/Keka                                         | aarch64      |                                 |
| Spotify                     | https://www.spotify.com/                                                                      | Intel64      |                                 |
| IINA                        | https://iina.io/<br>https://github.com/iina/iina                                              | aarch64      |                                 |
| Maccy                       | https://maccy.app/<br>https://github.com/p0deje/Maccy                                         | aarch64      |                                 |
| ~~Postman~~                 | https://www.postman.com/                                                                      | aarch64      |                                 |
| JetBrains Toolbox           | https://www.jetbrains.com/toolbox-app/                                                        | aarch64      |                                 |
| Floorp Browser              | https://floorp.app/<br>https://github.com/Floorp-Projects/Floorp                              | aarch64      |                                 |
| Windows App                 | https://learn.microsoft.com/en-us/windows-app/                                                | aarch64      |                                 |
| Microsoft Office            | https://learn.microsoft.com/en-us/microsoft-365-apps<br>https://files.rg-adguard.net/category | aarch64      |                                 |
| UTM                         | https://getutm.app/<br>https://github.com/utmapp/UTM                                          | aarch64      |                                 |
| iTerm2                      | https://iterm2.com/<br>https://github.com/gnachman/iTerm2                                     | aarch64      |                                 |
| Raycast                     | https://www.raycast.com/                                                                      | aarch64      |                                 |
| Node.js                     | https://nodejs.org/<br>https://github.com/nodejs/node                                         | aarch64      |                                 |
| Starship                    | https://starship.rs/<br>https://github.com/starship/starship                                  | aarch64      |                                 |
| Git Credential Manager(GCM) | https://github.com/git-ecosystem/git-credential-manager                                       | aarch64      |                                 |
| DBeaver                     | https://dbeaver.io/<br>https://github.com/dbeaver/dbeaver                                     | aarch64      |                                 |

## For Chinese users

### WeChat

Old versions:

- [WeChat for Mac 4.1.8](https://dldir1v6.qq.com/weixin/Universal/Mac/WeChatMac_4.1.8.dmg)
- [WeChat for Mac 4.1.2](https://dldir1v6.qq.com/weixin/Universal/Mac/WeChatMac_4.1.2.dmg)

### Tencent Meeting

Old versions:

- [Tencent Meeting V3.31.2](https://updatecdn.meeting.qq.com/cos/3866bd6756af079a0ee3d555c0d6feff/TencentMeeting_0300000000_3.31.2.431.publish.arm64.officialwebsite.dmg)

### Sunlogin Remote Control

Old versions:

- [Sunlogin Remote Control V16.3.0.29006](https://d-cdn.oray.com/sl/mac/AweSun_arm64_16.3.0.29006.dmg)
- [Sunlogin Remote Control V16.1.0.25667](https://d-cdn.oray.com/sl/mac/AweSun_16.1.0.25667_arm64.dmg)

### Chinese Apps

| name                    | url                          | Architecture | pros & cons       |
|-------------------------|------------------------------|--------------|-------------------|
| WeChat                  | https://weixin.qq.com/       | aarch64      |                   |
| TencentMeeting          | https://meeting.tencent.com/ | aarch64      | mandatory account |
| Sunlogin Remote Control | https://sunlogin.oray.com/   | aarch64      | signup required   |

> **Note**:
> you can download older versions from [Homebrew Cask](https://github.com/Homebrew/homebrew-cask).

### Browser Plugin

| Plugin              | Links                                            | Chrome                                                                                              | Firefox                                                                     |
|---------------------|--------------------------------------------------|-----------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| Translate Web Pages | https://github.com/FilipePS/Traduzir-paginas-web | https://chrome.google.com/webstore/detail/gkkkcomfmldkigajkmljnbpiajbpbgdg                          | https://addons.mozilla.org/firefox/addon/traduzir-paginas-web/              |
| uBlock Origin       | https://github.com/gorhill/uBlock                | https://chromewebstore.google.com/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm             | https://addons.mozilla.org/addon/ublock-origin/                             |
| Vimium              | https://github.com/philc/vimium                  | https://chromewebstore.google.com/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb                    | https://addons.mozilla.org/en-GB/firefox/addon/vimium-ff/                   |
| FDM                 | https://www.freedownloadmanager.org/             | https://chromewebstore.google.com/detail/free-download-manager/ahmpjcflkgiildlgicmcieglgoilbfdp     | https://addons.mozilla.org/en-US/firefox/addon/free-download-manager-addon/ |
| Bitwarden           | https://bitwarden.com/                           | https://chromewebstore.google.com/detail/bitwarden-free-password-m/nngceckbapebfimnlniiiahkandclblb | https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/  |
| SwitchyOmega        | https://github.com/FelisCatus/SwitchyOmega       | ~~https://chrome.google.com/webstore/detail/padekgcemlokbadohgkifijomclgjgif~~                      | ~~https://addons.mozilla.org/en-US/firefox/addon/switchyomega/~~            |
| Imagus              | ~~https://tiny.cc/Imagus~~                       | ~~https://chromewebstore.google.com/detail/imagus/immpkjjlgappgfkkfieppnmlhakdmaab~~                | https://addons.mozilla.org/en-US/firefox/addon/imagus/                      |


*Usage*:

> SwitchyOmega → auto switch: [GFWList](https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt)

## Reference

- [v2rayN](https://github.com/2dust/v2rayN)
- [Clash Verge](https://github.com/clash-verge-rev/clash-verge-rev)
- [free18/v2ray](https://github.com/free18/v2ray)
- [Installation — Homebrew Documentation](https://docs.brew.sh/Installation)
- [Java SE 8 (8u211 and later)](https://www.oracle.com/java/technologies/javase/javase8u211-later-archive-downloads.html)
- [Difference Between M2_HOME, MAVEN_HOME and using the PATH variable](https://www.baeldung.com/java-maven-environment-variables)
- [How to Install Maven on Windows, Linux, and Mac](https://www.baeldung.com/install-maven-on-windows-linux-mac)
- [Homebrew 镜像使用帮助](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/)
- [What's new in Windows App](https://learn.microsoft.com/en-us/windows-app/whats-new)
- [Sample shell scripts for Intune admins.](https://github.com/microsoft/shell-intune-samples)
- [SSH config file format](https://man7.org/linux/man-pages/man5/ssh_config.5.html)
