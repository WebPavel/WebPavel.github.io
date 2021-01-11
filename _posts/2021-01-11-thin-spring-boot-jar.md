---
layout: post
title: "thin spring-boot jar for packaging"
date: 2021-01-11
excerpt: "spring-boot."
tags: [spring-boot, thin, deploy]
comments: true
---

#### spring-boot打包fat，如何瘦身

spring-boot默认打全量依赖包，将所有依赖都打进lib/下，可以解压打包的jar包，或者参考官方文档`https://docs.spring.io/spring-boot/docs/current/reference/html/appendix-executable-jar-format.html`，查看打包后的目录结构。
MANIFEST.MF,如果想加载外部依赖jar，可以设置环境变量LOADER_PATH来实现

pom.xml
```xml

```

assembly.xml
```xml

```

#### 参考链接
1. https://docs.spring.io/spring-boot/docs/current/reference/html/appendix-executable-jar-format.html