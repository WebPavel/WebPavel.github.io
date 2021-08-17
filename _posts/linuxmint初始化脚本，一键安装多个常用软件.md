---
layout: post
title:  "linux mint一键安装常用软件脚本"
date:   2021-08-17
excerpt: "Linux Mint 配置"
tag: Linux
comments: false
---

#### pre_install.sh

```shell
#!/usr/bin/env bash
# pre_install.sh

sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list'

sudo dpkg --add-architecture i386 && sudo apt-get update && sudo apt-get install -fy libc6:i386

mkdir deepin-wine && cd deepin-wine

wget https://packages.deepin.com/deepin/pool/main/libj/libjpeg-turbo/libjpeg62-turbo_1.5.1-2_amd64.deb && sudo apt-get install -fy $(dirname $0)/libjpeg62-turbo_1.5.1-2_amd64.deb
wget https://packages.deepin.com/deepin/pool/main/libj/libjpeg-turbo/libjpeg62-turbo_1.5.1-2_i386.deb && sudo apt-get install -fy $(dirname $0)/libjpeg62-turbo_1.5.1-2_i386.deb
wget http://packages.deepin.com/deepin/pool/non-free/u/udis86/udis86_1.72-2_i386.deb && sudo apt-get install -fy $(dirname $0)/udis86_1.72-2_i386.deb
wget http://packages.deepin.com/deepin/pool/non-free/d/deepin-wine/deepin-fonts-wine_2.18-22~rc0_all.deb && sudo apt-get install -fy $(dirname $0)/deepin-fonts-wine_2.18-22~rc0_all.deb
wget http://packages.deepin.com/deepin/pool/non-free/d/deepin-wine/deepin-libwine_2.18-22~rc0_i386.deb && sudo apt-get install -fy $(dirname $0)/deepin-libwine_2.18-22~rc0_i386.deb
wget http://packages.deepin.com/deepin/pool/non-free/d/deepin-wine/deepin-wine32_2.18-22~rc0_i386.deb && sudo apt-get install -fy $(dirname $0)/deepin-wine32_2.18-22~rc0_i386.deb
wget http://packages.deepin.com/deepin/pool/non-free/d/deepin-wine/deepin-wine_2.18-22~rc0_all.deb && sudo apt-get install -fy $(dirname $0)/deepin-wine_2.18-22~rc0_all.deb
wget http://packages.deepin.com/deepin/pool/non-free/d/deepin-wine/deepin-wine32-preloader_2.18-22~rc0_i386.deb && sudo apt-get install -fy $(dirname $0)/deepin-wine32-preloader_2.18-22~rc0_i386.deb
wget http://packages.deepin.com/deepin/pool/non-free/d/deepin-wine-plugin/deepin-wine-plugin_1.0deepin2_amd64.deb && sudo apt-get install -fy $(dirname $0)/deepin-wine-plugin_1.0deepin2_amd64.deb
wget http://packages.deepin.com/deepin/pool/non-free/d/deepin-wine-plugin-virtual/deepin-wine-plugin-virtual_1.0deepin3_all.deb && sudo apt-get install -fy $(dirname $0)/deepin-wine-plugin-virtual_1.0deepin3_all.deb
wget http://packages.deepin.com/deepin/pool/non-free/d/deepin-wine-helper/deepin-wine-helper_1.2deepin8_i386.deb && sudo apt-get install -fy $(dirname $0)/deepin-wine-helper_1.2deepin8_i386.deb
wget http://packages.deepin.com/deepin/pool/non-free/d/deepin-wine-uninstaller/deepin-wine-uninstaller_0.1deepin2_i386.deb && sudo apt-get install -fy $(dirname $0)/deepin-wine-uninstaller_0.1deepin2_i386.deb

# TIM
wget http://packages.deepin.com/deepin/pool/non-free/d/deepin.com.qq.office/deepin.com.qq.office_2.0.0deepin4_i386.deb && sudo apt-get install -fy $(dirname $0)/deepin.com.qq.office_2.0.0deepin4_i386.deb
# Wechat
wget http://packages.deepin.com/deepin/pool/non-free/d/deepin.com.wechat/deepin.com.wechat_2.6.8.65deepin0_i386.deb && sudo apt-get install -fy $(dirname $0)/deepin.com.wechat_2.6.8.65deepin0_i386.deb
# QQ
wget http://packages.deepin.com/deepin/pool/non-free/d/deepin.com.qq.im/deepin.com.qq.im_9.1.8deepin0_i386.deb && sudo apt-get install -fy $(dirname $0)/deepin.com.qq.im_9.1.8deepin0_i386.deb

wget http://packages.deepin.com/deepin/pool/non-free/j/jetbrains-toolbox/jetbrains-toolbox_1.7.3593+lion_amd64.deb && sudo apt-get install -fy $(dirname $0)/jetbrains-toolbox_1.7.3593+lion_amd64.deb

# --fix-broken
wget http://security.ubuntu.com/ubuntu/pool/main/i/icu/libicu60_60.2-3ubuntu3.1_amd64.deb && sudo apt-get install -fy $(dirname $0)/libicu60_60.2-3ubuntu3.1_amd64.deb
wget http://kr.archive.ubuntu.com/ubuntu/pool/universe/w/webkitgtk/libjavascriptcoregtk-1.0-0_2.4.11-3ubuntu3_amd64.deb && sudo apt-get install -fy $(dirname $0)/libjavascriptcoregtk-1.0-0_2.4.11-3ubuntu3_amd64.deb
wget http://kr.archive.ubuntu.com/ubuntu/pool/universe/w/webkitgtk/libwebkitgtk-1.0-0_2.4.11-3ubuntu3_amd64.deb && sudo apt-get install -fy $(dirname $0)/libwebkitgtk-1.0-0_2.4.11-3ubuntu3_amd64.deb
wget http://packages.deepin.com/deepin/pool/non-free/x/xmind/xmind_3.7.2deepin_all.deb && sudo apt-get install -fy $(dirname $0)/xmind_3.7.2deepin_all.deb

# --fix-broken
wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.6_amd64.deb && sudo apt-get install -fy $(dirname $0)/libssl1.0.0_1.0.2n-1ubuntu5.6_amd64.deb
wget http://packages.deepin.com/deepin/pool/main/libp/libpng/libpng12-0_1.2.54-6_amd64.deb && sudo apt-get install -fy $(dirname $0)/libpng12-0_1.2.54-6_amd64.deb
wget http://kr.archive.ubuntu.com/ubuntu/pool/main/libf/libffi/libffi6_3.2.1-8_amd64.deb && sudo apt-get install -fy $(dirname $0)/libffi6_3.2.1-8_amd64.deb
wget http://packages.deepin.com/deepin/pool/non-free/r/redis-desktop-manager/redis-desktop-manager_0.9.0.17_amd64.deb && sudo apt-get install -fy $(dirname $0)/redis-desktop-manager_0.9.0.17_amd64.deb

wget https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-beta/microsoft-edge-beta_93.0.961.18-1_amd64.deb && sudo apt-get install -fy $(dirname $0)/microsoft-edge-beta_93.0.961.18-1_amd64.deb

wget https://packages.microsoft.com/repos/code/pool/main/c/code/code_1.59.0-1628120042_amd64.deb && sudo apt-get install -fy $(dirname $0)/code_1.59.0-1628120042_amd64.deb

wget https://download.fastgit.org/flameshot-org/flameshot/releases/download/v0.10.1/flameshot-0.10.1-1.ubuntu-20.04.amd64.deb && sudo apt-get install -fy $(dirname $0)/flameshot-0.10.1-1.ubuntu-20.04.amd64.deb

wget https://download.fastgit.org/Qv2ray/Qv2ray/releases/download/v2.7.0-alpha1/qv2ray_2.7.0.alpha1-1stable1_amd64.deb && sudo apt-get install -fy $(dirname $0)/qv2ray_2.7.0.alpha1-1stable1_amd64.deb

wget https://download.fastgit.org/v2ray/v2ray-core/releases/download/v4.28.2/v2ray-linux-64.zip

wget https://wdl1.cache.wps.cn/wps/download/ep/Linux2019/10702/wps-office_11.1.0.10702_amd64.deb && sudo apt-get install -fy $(dirname $0)/wps-office_11.1.0.10702_amd64.deb

wget https://download.fastgit.org/hluk/CopyQ/releases/download/v4.1.0/copyq_4.1.0_Debian_10-1_amd64.deb && sudo apt-get install -fy $(dirname $0)/copyq_4.1.0_Debian_10-1_amd64.deb

wget https://packages.deepin.com/deepin/pool/main/p/peek/peek_1.3.1-6~deepin+1_amd64.deb && sudo apt-get install -fy $(dirname $0)/peek_1.3.1-6~deepin+1_amd64.deb

wget https://download.fastgit.org/peazip/PeaZip/releases/download/8.1.0/peazip_8.1.0.LINUX.x86_64.GTK2.deb && sudo apt-get install -fy $(dirname $0)/peazip_8.1.0.LINUX.x86_64.GTK2.deb

wget https://dn3.freedownloadmanager.org/6/latest/freedownloadmanager.deb && sudo apt-get install -fy $(dirname $0)/freedownloadmanager.deb

sudo apt-get install -fy git vim net-tools firewalld docker.io openjdk-11-jdk maven gdebi zip unzip p7zip-full p7zip-rar vlc openjdk-8-jdk xclip

# Typora
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
# add Typora's repository
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt-get update
# install typora
sudo apt-get install -fy typora

# NVIDIA
sudo add-apt-repository ppa:graphics-drivers/ppa
ubuntu-drivers devices
sudo ubuntu-drivers autoinstall

cd ~
git config --global user.name "pl"
git config --global user.email "paulluis.dev@gmail.com"
ssh-keygen -t rsa -b 4096 -C "paulluis.dev@gmail.com"
xclip -selection clipboard < ~/.ssh/id_rsa.pub

# sudo apt-get install -fy flatpak
# flatpak install flathub org.telegram.desktop -y
# flatpak run org.telegram.desktop
```