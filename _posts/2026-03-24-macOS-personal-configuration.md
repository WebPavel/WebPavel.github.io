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
#https://raw.bgithub.xyz/free18/v2ray/refs/heads/main/v.txt
#https://raw.bgithub.xyz/free18/v2ray/refs/heads/main/c.yaml
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

## Postman

Download [Postman](https://dl.pstmn.io/download/version/9.31.30/osx_arm64)

## JetBrains Toolbox

The last version to support both Community and Unified updates is [Version 3.2](https://download.jetbrains.com/toolbox/jetbrains-toolbox-3.2.0.65851-arm64.dmg)

## Windows App

Download [Windows App from the Mac App Store](https://aka.ms/macOSWindowsApp).

You can also download Windows App outside of the Mac App Store as a .pkg file from https://go.microsoft.com/fwlink/?linkid=868963.

## Application Requirements

| name               | url                                                                                      | Architecture |
|--------------------|------------------------------------------------------------------------------------------|--------------|
| Google Chrome      | https://www.google.cn/chrome/                                                            | aarch64      |
| FDM                | https://www.freedownloadmanager.org/                                                     | Intel64      |
| v2rayN             | https://github.com/2dust/v2rayN                                                          | aarch64      |
| Clash Verge        | https://github.com/clash-verge-rev/clash-verge-rev                                       | aarch64      |
| IDEA               | https://www.jetbrains.com/idea/                                                          | aarch64      |
| Visual Studio Code | https://code.visualstudio.com/                                                           | aarch64      |
| Homebrew           | https://brew.sh/                                                                         | aarch64      |
| Stats              | https://mac-stats.com/                                                                   | aarch64      |
| XnView MP          | https://www.xnview.com/                                                                  | aarch64      |
| Snipaste           | https://www.snipaste.com/                                                                | aarch64      |
| Eudic              | https://www.eudic.net/                                                                   | aarch64      |
| JDK 8              | https://www.oracle.com/java/technologies/javase/javase8u211-later-archive-downloads.html | aarch64      |
| Pandoc             | https://pandoc.org/                                                                      | aarch64      |
| Docker             | https://www.docker.com/                                                                  | aarch64      |
| Maven              | https://maven.apache.org/                                                                | aarch64      |
| Keka               | https://www.keka.io/                                                                     | aarch64      |
| Spotify            | https://www.spotify.com/                                                                 | Intel64      |
| IINA               | https://iina.io/                                                                         | aarch64      |
| Maccy              | https://maccy.app/                                                                       | aarch64      |
| Postman            | https://www.postman.com/                                                                 | aarch64      |
| JetBrains Toolbox  | https://www.jetbrains.com/toolbox-app/                                                   | aarch64      |
| Floorp Browser     | https://floorp.app/                                                                      | aarch64      |

### Browser Plugin

| Plugin              | Links                                            | Chrome                                                                                               | Firefox                                                                        |
|---------------------|--------------------------------------------------|------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------|
| Translate Web Pages | https://github.com/FilipePS/Traduzir-paginas-web | https://chrome.google.com/webstore/detail/gkkkcomfmldkigajkmljnbpiajbpbgdg                           | https://addons.mozilla.org/firefox/addon/traduzir-paginas-web/                 |
| uBlock Origin       | https://github.com/gorhill/uBlock                | https://chromewebstore.google.com/detail/ublock-origin-lite/ddkjiahejlhfcafbddmgiahcphecmpfh         | https://addons.mozilla.org/addon/ublock-origin/                                |
| Vimium              | https://github.com/philc/vimium                  | https://chromewebstore.google.com/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb                     | https://addons.mozilla.org/en-GB/firefox/addon/vimium-ff/                      |
| FDM                 | https://www.freedownloadmanager.org/             | https://chromewebstore.google.com/detail/free-download-manager/ahmpjcflkgiildlgicmcieglgoilbfdp      | https://addons.mozilla.org/en-US/firefox/addon/free-download-manager-addon/    |
| Bitwarden           | https://bitwarden.com/                           | https://chromewebstore.google.com/detail/bitwarden-free-password-m/nngceckbapebfimnlniiiahkandclblb  | https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/     |
| Inoreader           | https://www.inoreader.com/                       | https://chrome.google.com/webstore/detail/rss-reader-extension-by-i/kfimphpokifbjgmjflanmfeppcjimgah | https://addons.mozilla.org/en-US/firefox/addon/rss-reader-extension-inoreader/ |
| ~~SwitchyOmega~~    | https://github.com/FelisCatus/SwitchyOmega       | ~~https://chrome.google.com/webstore/detail/padekgcemlokbadohgkifijomclgjgif~~                       | ~~https://addons.mozilla.org/en-US/firefox/addon/switchyomega/~~               |
| Imagus              | ~~https://tiny.cc/Imagus~~                       | ~~https://chromewebstore.google.com/detail/imagus/immpkjjlgappgfkkfieppnmlhakdmaab~~                 | https://addons.mozilla.org/en-US/firefox/addon/imagus/                         |


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
