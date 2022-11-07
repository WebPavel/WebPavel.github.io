---
layout: post
title: "Manjaro Xfce Installation"
date: 2022-11-07
excerpt: "Manjaro Xfce Installation."
tags: [Linux, Manjaro, Xfce, Archlinux]
comments: false
---


### 系统安装设置

```shell
timedatectl set-ntp true
sudo vi /etc/pacman.conf
sudo pacman -Sy archlinuxcn-keyring
sudo pacman -Sy base-devel
sudo pacman -Sy vim net-tools tmux yay
sudo pacman -Sy git jdk8-openjdk maven docker
sudo pacman -Sy obs-studio neofetch
sudo vim /usr/lib/systemd/system/docker.service
sudo systemctl enable --now docker
sudo gpasswd -a $USER docker
newgrp docker
docker run -d --name mysql --restart always -p 3306:3306 -e MYSQL_ROOT_PASSWORD=masterA@#1 mysql:5.7
docker run -d --name nginx-rtmp --restart always -p 1935:1935 tiangolo/nginx-rtmp
```

### 软件源设置

- [pacman.conf](/etc/pacman.conf)
```
[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
```

### Git 配置

```shell
git config --global https.proxy http://127.0.0.1:38457
git config --global http.sslVerify false
```

## maven 配置

```xml
<mirror>
    <id>aliyunmaven</id>
    <mirrorOf>*</mirrorOf>
    <name>阿里云公共仓库</name>
    <url>https://maven.aliyun.com/repository/public</url>
</mirror>
```

### docker 配置

```
-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
```

### 软件安装设置

```shell
sudo pacman -Sy ibus-rime fcitx5 fcitx5-rime rime-emoji fcitx5-qt fcitx5-gtk fcitx5-configtool
yay -Sy microsoft-edge-stable-bin
yay -Sy visual-studio-code-bin
yay -Sy postman-bin
yay -Sy lantern-bin
sudo ln -s /usr/lib64/libpcap.so /usr/lib64/libpcap.so.0.8
yay -Sy fastgithub-bin
\cp -rf fastgithub_linux-x64.zip /home/kargah/.cache/yay/fastgithub-bin/
sudo fastgithub start
sudo cp -rf /opt/fastgithub-bin/cacert/fastgithub.crt /etc/ca-certificates/trust-source/anchors/
sudo update-ca-trust
export https_proxy="http://127.0.0.1:38457"
sudo pacman -Sy nodejs-lts-fermium
sudo pacman -Sy npm
npm config set registry https://registry.npmmirror.com
export https_proxy="http://127.0.0.1:38457"
yay -Sy imgbrd-grabber
sudo pacman -Sy perl-image-exiftool
```

### 安装旧版 IDEA

```shell
wget https://aur.archlinux.org/cgit/aur.git/commit/?h=intellij-idea-ultimate-edition&id=b9b6d57d1a66eecf498cf8b1b261c6c0ee6e8fb2
tar -zxvf aur-b9b6d57d1a66eecf498cf8b1b261c6c0ee6e8fb2.tar.gz -C /tmp/
cd /tmp/aur-b9b6d57d1a66eecf498cf8b1b261c6c0ee6e8fb2/
makepkg -s
vim PKGBUILD
sha256sums=('SKIP'
            '83af2ba8f9f14275a6684e79d6d4bd9b48cd852c047dacfc81324588fa2ff92b')
sudo pacman -U *.pkg.tar.zst
```

### MSYS2

```shell
pacman -S git python vim p7zip curl wget tmux neofetch mingw-w64-x86_64-aria2 zsh winpty unrar zip unzip
pacman -S mingw-w64-x86_64-ffmpeg
git config --global core.autocrlf true
```
