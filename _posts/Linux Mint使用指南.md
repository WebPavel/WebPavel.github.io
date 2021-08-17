---
layout: post
title:  "Linux Mint使用指南"
date:   2021-08-17
excerpt: "Linux Mint 使用指南，安装常用软件，满足日常使用"
tag: Linux
comments: false
---

#### Linux Mint使用指南

##### 重启蓝牙服务

```shell
sudo /etc/init.d/bluetooth restart
```

##### 录制GIF

```shell
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update && sudo apt-get install peek -y
```

##### Typora编辑器

```shell
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt-get update && sudo apt-get install typora
```

##### 推荐应用

- 科学上网Qv2ray
- 截图flameshot
- 复制粘贴历史记录copyQ
- 下载free download manager
- 视频播放vlc
- WPS
- Typora
- edge浏览器
- 解压缩PeaZip
- vscode编辑器
- RDM
- JetBrains Toolbox
- 思维导图xmind8
- 文件同步FreeFileSync

##### Linux上打开Windows上txt乱码

```shell
iconv -f gbk -t utf8 shujujiegou.txt > shujujiegou.txt.utf8
```

##### Linux mint默认禁止snap安装

解决方法:注释掉下面文件三行

```shell
sudo vim /etc/apt/preferences.d/nosnap.pref
sudo apt install snapd -y
# 证书问题 --dangerous
sudo snap install zy_2.8.5_amd64.snap --dangerous
# 运行snap程序
snap run zy
```

