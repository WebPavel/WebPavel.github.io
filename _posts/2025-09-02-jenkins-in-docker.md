---
layout: post
title: "Downloading and running Jenkins in Docker"
date: 2025-09-02
excerpt: "Downloading and running Jenkins in Docker on macOS."
tags: [ Jenkins, Docker, macOS ]
comments: true
---


# Jenkins docker 部署文档

## prepare 环境要求

1.已安装 docker 运行环境

2.docker pull image 访问 Docker Hub 网络通畅

## 安装步骤

### 安装

1. 搜索 Jenkins 镜像

2. 拉取 Jenkins 镜像

3. 运行 Jenkins 镜像

   参数说明：

   -p 端口映射，Jenkins 内部有 8080 和 50000 两个通讯端口

   -v 数据卷挂载，/var/jenkins_home 所有插件数据配置保存在这个目录下，另外 2 个是将宿主机 docker 和 Jenkins 联动起来，这样 Jenkins 不用下载 docker 插件

   -u 指定用户，Jenkins 镜像内部使用用户是 Jenkins，我们运行容器账户是 root，导致没权限操作内部目录，-u 覆盖容器内置账户，0 代表 root 账户 id

   --restart=on-failure:3 容器非正常退出时尝试重启最多 3 次

```shell
docker search jenkins # jenkins OFFICIAL 镜像被官方标记为 DEPRECATED; use "jenkins/jenkins:lts" instead
docker pull jenkins/jenkins:lts-jdk17 # pull 镜像
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 \
-v $HOME/jenkins:/var/jenkins_home -v $(which docker):/usr/bin/docker \
-v /var/run/docker.sock:/var/run/docker.sock -u 0 --restart=on-failure:3 jenkins/jenkins:lts-jdk17
docker logs -f jenkins # 查看初始密码
```

## 配置

### 关闭 CSRF（Cross-Site Request Forgery 跨站请求伪造）保护

修改配置文件 `/var/jenkins_home/config.xml` 属性

```xml
<!--把 excludeClientIPFromCrumb 属性值 false 改成 true-->
<crumbIssuer class="hudson.security.csrf.DefaultCrumbIssuer">
    <excludeClientIPFromCrumb>false</excludeClientIPFromCrumb>
</crumbIssuer>
```

### 设置插件下载源

使用腾讯云镜像源 https://mirrors.cloud.tencent.com/jenkins/updates/update-center.json

```shell
# 进入容器
docker exec -it jenkins /bin/bash
# backup 文件 /var/jenkins_home/updates/default.json
cp /var/jenkins_home/updates/default.json /var/jenkins_home/updates/default.json.bak
# 将 www.google.com 替换成 www.bing.com，将 updates.jenkins-ci.org/download 替换成 mirrors.cloud.tencent.com/jenkins
sed -i 's/www.google.com/www.bing.com/g' /var/jenkins_home/updates/default.json
sed -i 's/updates.jenkins-ci.org\/download/mirrors.cloud.tencent.com\/jenkins/g' /var/jenkins_home/updates/default.json
# 退出容器
exit
# 重启容器
docker restart jenkins
```

### 访问测试

浏览器打开 http://127.0.0.1:8080，输入密码后，安装插件一般选择社区推荐
