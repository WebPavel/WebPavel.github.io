---
layout: post
title: "Debian, my favorite"
date: 2023-04-26
excerpt: "Debian, something todo after installation"
tags: [Linux, Debian]
comments: false
---


# App installation

```shell

su - root
usermod -G sudo dev

sudo apt install -y vim vlc ffmpeg docker.io nodejs obs-studio telnet p7zip-full p7zip-rar flameshot git pandoc net-tools wireshark thunderbird smplayer ibus-rime curl firewalld nvidia-detect

# remove-preinstalled-gnome-applications
sudo apt autoremove -y gnome-games transmission-gtk evolution goldendict gnome-screenshot evince eog rhythmbox gnome-music totem

sudo chmod +x VMware-Workstation-Full-17.0.0-20800274.x86_64.bundle
sudo ./VMware-Workstation-Full-17.0.0-20800274.x86_64.bundle

sudo nvidia-detect
sudo apt install -y nvidia-driver

```

# Download Installation

```shell

sudo unzip ./fastgithub_linux-x64.zip -d /opt/
sudo tar -zxvf ./ideaIU-2021.1.3.tar.gz -C /opt/
sudo tar -zxvf ./ideaIC-2023.1.tar.gz -C /opt/
sudo tar -zxvf ./postman-linux-x64.tar.gz -C /opt/
sudo tar -zxvf ./apache-maven-3.6.2-bin.tar.gz -C /opt/
sudo tar -zxvf ./jdk-8u202-linux-x64.tar.gz -C /opt/
sudo vim /etc/profile
source /etc/profile
java -version

```

0. apache-maven-3.6.2-bin.tar.gz
1. code_1.77.3-1681292746_amd64.deb
2. drawio-amd64-21.2.1.deb
3. eudic.deb
4. fastgithub_linux-x64.zip
5. freedownloadmanager.deb
6. google-chrome-stable_current_amd64.deb
7. ideaIC-2023.1.tar.gz
8. ideaIU-2021.1.3.tar.gz
9. jdk-8u202-linux-x64.tar.gz
10. postman-linux-x64.tar.gz
11. uBlock0_1.49.0.firefox.xpi
12. VMware-Workstation-Full-17.0.0-20800274.x86_64.bundle
13. wps-office_11.1.0.11691.XA_amd64.deb
14. XnViewMP-linux-x64.deb

# Firefox configuration

SwitchyOmega在线恢复

https://github.com/FelisCatus/SwitchyOmega/wiki/GFWList.bak 

# im configuration

```shell

git clone https://github.com/iDvel/rime-ice.git
cp -rf ./rime-ice/* ~/.config/ibus/rime/
vim default.custom.yaml

```

- default.custom.yaml

```yaml

patch:
  __include: rime_ice_suggestion:/

```

- /etc/profile

```shell

export JAVA_HOME=/opt/jdk1.8.0_202/
export PATH=$PATH:$JAVA_HOME/bin

```
