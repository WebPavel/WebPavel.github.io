---
layout: post
title:  "docker ubuntu20.04"
date:   2021-04-28
excerpt: "docker DevOps"
tag: docker
comments: false
---

##### docker时区问题

```shell
date
# man ln -f,--force;-n,--no-dereference
ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
date
```
##### ubuntu20.04安装docker

```shell
sudo apt-get install -fy docker.io && sudo docker version
sudo systemctl enable docker && sudo systemctl start docker && sudo docker info
```

##### ubuntu20.04安装jdk

```shell
sudo apt-get install -fy openjdk-11-jdk && java -version
```

##### ubuntu20.04无法播放bilibili等网站视频

```shell
# # 下载flash_player_npapi_linux.x86_64.tar.gz
# cd flash_player_npapi_linux.x86_64/
# ls -la
# sudo cp libflashplayer.so /usr/lib/firefox-addons/plugins/
# sudo cp -r ./usr/* /usr/
# sudo apt update
# sudo apt-get install -fy flashplugin-installer
sudo apt-get install -fy ffmpeg
```

##### vscode无法连接本地docker,报错EACCES

​    原因是docker使用unix socket通讯，但unix socket属于root用户
```shell
sudo chmod o=rw /var/run/docker.sock
ls -la /var/run/docker.sock
systemctl restart docker && systemctl status docker
```

##### docker开启远程连接

```shell
sudo vim /usr/lib/systemd/system/docker.service
# ExecStart 最后加 -H tcp://0.0.0.0:2375
#重启docker
systemctl daemon-reload && systemctl restart docker
# 安装防火墙
sudo apt-get install -fy firewalld
firewall-cmd --zone=public --add-port=2375/tcp --permanent
# firewall-cmd --zone=public --remove-port=2375/tcp --permanent
firewall-cmd --reload
```

##### 当前用户不用每次都输入sudo docker，直接输入docker

```shell
# # 添加docker用户组
# sudo groupadd docker
# # 将当前用户添加到docker用户组
# sudo gpasswd -a $USER docker
# # 将当前用户从docker用户组删除
# # sudo gpasswd -d $USER docker
# # 更新docker用户组
# newgrp docker
```

##### docker指定阿里云镜像加速

```shell
sudo vim /etc/docker/daemon.json
# {"registry-mirrors": ["https://地址.mirror.aliyuncs.com"]}
```

##### docker mysql8.0连接问题

```shell
docker run --restart always -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456  mysql:8.0
docker exec -it 6cd43a3f579f bash
mysql -u root -p
# 进入mysql
use mysql;
alter user 'root'@'%' identified with mysql_native_password by '123456';
flush privileges;
select host,user,plugin from mysql.user;
```

##### ubuntu20.04安装完，啥都不干，第一件事换源

```shell
sudo rm -rf /etc/apt/sources.list
sudo vi /etc/apt/sources.list
sudo apt-get update && sudo apt-get upgrade
# 遇到错误的话
sudo apt-get upgrade --fix-missing
sudo apt-get install -fy gdebi git net-tools
git --version
```

sources.list示例
```
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
```