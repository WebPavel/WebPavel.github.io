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

#### project structure

hello  
|---bin  
|---src  
|------main  
|---------java  
|---------resources  
|------test  
|---assembly.xml  
|---pom.xml  

#### package structure

hello-0.0.1-SNAPSHOT.tar.gz  
|---lib  
|---resources  
|---hello-0.0.1-SNAPSHOT.jar  
|---startup.sh  
|---shutdown.sh  
|---restart.sh  

#### more and detail

1. pom.xml  

```xml
<repositories>
    <!-- 阿里云仓库 -->
    <repository>
        <id>aliyun</id>
        <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
        <releases>
            <enabled>true</enabled>
        </releases>
        <snapshots>
            <enabled>false</enabled>
        </snapshots>
    </repository>
</repositories>

<pluginRepositories>
    <pluginRepository>
        <id>aliyun</id>
        <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
        <releases>
            <enabled>true</enabled>
        </releases>
        <snapshots>
            <enabled>false</enabled>
        </snapshots>
    </pluginRepository>
</pluginRepositories>

<!-- 1.local（默认）:本地 2.dev:开发环境 3.prod:生产环境 -->
<profiles>
    <profile>
        <id>local</id>
        <properties>
            <profileActive>local</profileActive>
        </properties>
        <activation>
            <activeByDefault>true</activeByDefault>
        </activation>
    </profile>
    <profile>
        <id>dev</id>
        <properties>
            <profileActive>dev</profileActive>
        </properties>
        <activation>
            <activeByDefault>false</activeByDefault>
        </activation>
    </profile>
    <profile>
        <id>prod</id>
        <properties>
            <profileActive>prod</profileActive>
        </properties>
        <activation>
            <activeByDefault>false</activeByDefault>
        </activation>
    </profile>
</profiles>

<build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
            <configuration>
                <layout>ZIP</layout>
                <includes>
                    <include>
                        <groupId>non-exists</groupId>
                        <artifactId>non-exists</artifactId>
                    </include>
                </includes>
            </configuration>
        </plugin>

        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-jar-plugin</artifactId>
            <configuration>
                <archive>
                    <manifest>
                        <addClasspath>true</addClasspath>
                        <!-- MANIFEST.MF 中 Class-Path 加入前缀 -->
                        <classpathPrefix>lib/</classpathPrefix>
                        <!-- jar包不包含唯一版本标识 -->
                        <useUniqueVersions>false</useUniqueVersions>
                    </manifest>
                    <manifestEntries>
                        <!-- 指定配置文件目录，这样jar运行时会到同目录下的resources文件夹下查找 -->
                        <Class-Path>resources/</Class-Path>
                    </manifestEntries>
                </archive>
                <!-- 不打包资源文件 -->
                <excludes>
                    <exclude>**/*.properties</exclude>
                    <exclude>**/*.xml</exclude>
                    <exclude>**/*.yml</exclude>
                    <include>mapper/**/*.xml</include>
                    <include>static/**</include>
                    <include>templates/**</include>
                </excludes>
            </configuration>
        </plugin>

        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-assembly-plugin</artifactId>
            <configuration>
                <appendAssemblyId>false</appendAssemblyId>
                <descriptors>
                    <descriptor>${project.basedir}/assembly.xml</descriptor>
                </descriptors>
            </configuration>
            <executions>
                <execution>
                    <id>make-assembly</id>
                    <phase>package</phase>
                    <goals>
                        <goal>single</goal>
                    </goals>
                </execution>
            </executions>
        </plugin>
    </plugins>
</build>
```

2. assembly.xml  

```xml
<?xml version='1.0' encoding='UTF-8'?>
<assembly xmlns="http://maven.apache.org/ASSEMBLY/2.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/ASSEMBLY/2.0.0 http://maven.apache.org/xsd/assembly-2.0.0.xsd">
    <id>distribution</id>

    <formats>
        <format>tar.gz</format>
    </formats>

    <includeBaseDirectory>true</includeBaseDirectory>

    <fileSets>
        <fileSet>
            <directory>${project.basedir}/bin</directory>
            <outputDirectory>/</outputDirectory>
            <lineEnding>unix</lineEnding>
            <fileMode>0755</fileMode>
            <includes>
                <include>*.sh</include>
            </includes>
        </fileSet>

        <fileSet>
            <directory>${project.basedir}/src/main/resources</directory>
            <outputDirectory>resources</outputDirectory>
            <!-- 指定参与构建的resources -->
            <includes>
                <include>application.properties</include>
                <include>application-${profileActive}.properties</include>
                <include>mapper/**/*.xml</include>
                <include>static/**</include>
                <include>templates/**</include>
                <include>*.properties</include>
                <include>*.xml</include>
            </includes>
        </fileSet>
    </fileSets>

    <dependencySets>
        <dependencySet>
            <outputDirectory>lib</outputDirectory>
            <excludes>
                <exclude>${project.groupId}:${project.artifactId}</exclude>
            </excludes>
        </dependencySet>
        <dependencySet>
            <outputDirectory>/</outputDirectory>
            <includes>
                <include>${project.groupId}:${project.artifactId}</include>
            </includes>
        </dependencySet>
    </dependencySets>
</assembly>
```

3. startup.sh  

```shell
#!/bin/sh
# startup.sh

APPLICATION="sign-0.0.1-SNAPSHOT"
APPLICATION_JAR="${APPLICATION}.jar"

LOG_DIR=logs
LOG_BACKUP_DIR=logs/backup/
LOG_PATH=logs/catalina.out
JAVA_OPT='-Dspring.profiles.active=prod'

# 当前时间
NOW=`date +'%Y%m%d%H%M%S'`
NOW_PRETTY=`date +'%Y-%m-%d %H:%M:%S'`

# 如果logs文件夹不存在,则创建文件夹
if [ ! -d "${LOG_DIR}" ]; then
  mkdir "${LOG_DIR}"
fi

# 如果logs/backup文件夹不存在,则创建文件夹
if [ ! -d "${LOG_BACKUP_DIR}" ]; then
  mkdir "${LOG_BACKUP_DIR}"
fi

# 如果项目运行日志存在,则重命名备份
if [ -f "${LOG_PATH}" ]; then
	mv ${LOG_PATH} "${LOG_BACKUP_DIR}/${APPLICATION}_back_${NOW}.log"
fi

java -Xmx1024m -XX:-HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./ -jar ${JAVA_OPT} ${APPLICATION_JAR} >${LOG_PATH} 2>&1 &

```

4.shutdown.sh  

```shell
#!/bin/sh
# shutdown.sh

APPLICATION="sign-0.0.1-SNAPSHOT"
APPLICATION_JAR="${APPLICATION}.jar"

PID_LIST=`jps -l | grep ${APPLICATION_JAR} | awk '{print $1}'`
if [ -n ${PID_LIST} ]; then
  for PID in ${PID_LIST}; do
      echo "kill -15 ${PID}"
      kill -15 ${PID}
  done
fi

PID_LIST=`ps -ef | grep ${APPLICATION_JAR} | awk '{print $2}'`
if [ -z PID_LIST ]; then
  echo "${APPLICATION} is already stopped"
else
  for PID in ${PID_LIST}; do
      echo "kill -9 ${PID}"
      kill -9 ${PID}
      echo "${APPLICATION} stopped successfully"
  done
fi

```

5.restart.sh  

```shell
#!/bin/sh
# restart.sh

APPLICATION="sign-0.0.1-SNAPSHOT"

echo "stop ${APPLICATION} Application..."
sh shutdown.sh
sleep 5
echo "start ${APPLICATION} Application..."
sh startup.sh

```

#### 参考链接
1. https://docs.spring.io/spring-boot/docs/current/reference/html/appendix-executable-jar-format.html  