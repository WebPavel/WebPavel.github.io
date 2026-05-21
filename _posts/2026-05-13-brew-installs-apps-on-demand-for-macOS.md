---
layout: post
title: "brew installs apps on demand for macOS"
date: 2026-05-13
excerpt: "brew installs apps on demand for macOS."
tags: [ brew, macOS ]
comments: true
---

## brew install

```shell
#!/bin/bash
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if a command exists
has_command() {
  command -v "$1" > /dev/null 2>&1
}

/usr/sbin/softwareupdate --install-rosetta --agree-to-license
xcode-select --install

if ! command -v brew > /dev/null 2>&1; then
    echo -e "${RED}ERROR: Homebrew is not installed or not in PATH${NC}"
    echo "Please install Homebrew: https://brew.sh/"
    exit 1
fi

app_list=(git python@3.11 node@22 ffmpeg pyenv jq llama.cpp pandoc shellcheck shfmt starship)
app_list_j=(openjdk@8 maven)
app_list=("${app_list[@]}" "${app_list_j[@]}")
for app in "${app_list[@]}"
do
  brew install --formula $app
done

app_list=(clash-verge-rev codex cursor dbeaver-community docker-desktop eudic floorp font-jetbrains-mono-nerd-font font-meslo-lg-nerd-font free-download-manager git-credential-manager google-chrome jordanbaird-ice iina intellij-idea iterm2 keka lulu maccy raycast shottr spotify stats tabby utm visual-studio-code vivaldi windows-app xnviewmp)
app_list_ms=(microsoft-office windows-app)
app_list_cn=(wechat tencent-meeting awesun)
app_list=("${app_list[@]}" "${app_list_ms[@]}" "${app_list_cn[@]}")
for app in "${app_list[@]}"
do
    brew install --cask $app
done

git version
git config --global user.name "liubao"
git config --global user.email "paulluis.dev@gmail.com"
ssh-keygen -t rsa -b 4096 -C "paulluis.dev@gmail.com"

echo 'eval "$(starship init zsh)"' >> ~/.zshrc && source ~/.zshrc

starship preset catppuccin-powerline -o ~/.config/starship.toml

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
echo 'export PATH="$PATH:/opt/apache-maven-3.6.3/bin"' >> ~/.zshrc && source ~/.zshrc
mvn -v

cat >> ~/.zshrc << 'EOF'
if [ -d ~/bin ]; then
    PATH="$PATH:~/bin"
fi
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-1.8.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

function proxy {
  export http_proxy="http://127.0.0.1:10808"
  export https_proxy="$http_proxy"
  export all_proxy="socks5://127.0.0.1:10808"
  export no_proxy="localhost,127.0.0.1,::1"
}

function unproxy {
  unset http_proxy
  unset https_proxy
  unset all_proxy
  unset no_proxy
}
EOF

source ~/.zshrc
```
