---
layout: post
title: "thin spring-boot jar for packaging"
date: 2021-01-11
excerpt: "spring-boot package."
tags: [spring-boot, thin, deploy]
comments: true
---

#### spring-boot打包fat，如何瘦身

spring-boot默认打全量依赖包，将所有依赖都打进lib/下，可以解压打包的jar包，或者参考官方文档`https://docs.spring.io/spring-boot/docs/current/reference/html/appendix-executable-jar-format.html`，查看打包后的目录结构。
MANIFEST.MF,如果想加载外部依赖jar，可以设置环境变量LOADER_PATH来实现

#### project structure

sms  
|---bin  
|------restart.sh  
|------start.sh  
|------stop.sh  
|---src  
|------main  
|---------java  
|------------SmsApplication.java  
|---------resources  
|------------application.properties  
|------------logback-spring.xml  
|------test  
|---assembly.xml  
|---.gitignore  
|---pom.xml  

#### package structure

sms.tar.gz  
|---lib  
|---resources  
|---sms-CANARY.jar  
|---start.sh  
|---stop.sh  
|---restart.sh  

#### more and detail

- pom.xml

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
    <finalName>${project.artifactId}</finalName>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
            <configuration>
                <!--<layout>ZIP</layout>-->
                <includes>
                    <include>
                        <groupId>null</groupId>
                        <artifactId>null</artifactId>
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

- assembly.xml

```xml
<?xml version='1.0' encoding='UTF-8'?>
<assembly xmlns="http://maven.apache.org/ASSEMBLY/2.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/ASSEMBLY/2.0.0 http://maven.apache.org/xsd/assembly-2.0.0.xsd">
    <id>dist</id>

    <formats>
        <format>tar.gz</format>
    </formats>

    <includeBaseDirectory>true</includeBaseDirectory>

    <fileSets>
        <fileSet>
            <directory>${project.basedir}/bin</directory>
            <outputDirectory>${file.separator}</outputDirectory>
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
            <outputDirectory>${file.separator}</outputDirectory>
            <includes>
                <include>${project.groupId}:${project.artifactId}</include>
            </includes>
        </dependencySet>
    </dependencySets>
</assembly>
```

- start.sh

```shell
#!/bin/sh
# start.sh

APP_NAME="sms-CANARY"
JAR_NAME="${APP_NAME}.jar"

java -Xmx1024m -XX:-HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./ -jar ${JAR_NAME}>/dev/null 2>&1 &

```

- stop.sh

```shell
#!/bin/sh
# stop.sh

APP_NAME="sms-CANARY"
JAR_NAME="${APP_NAME}.jar"

PID_LIST=`jps -l | grep ${JAR_NAME} | awk '{print $1}'`
if [ -n ${PID_LIST} ]; then
  for PID in ${PID_LIST}; do
      echo "kill -15 ${PID}"
      kill -15 ${PID}
  done
fi

PID_LIST=`ps -ef | grep ${JAR_NAME} | awk '{print $2}'`
if [ -z PID_LIST ]; then
  echo "${APP_NAME} is already stopped"
else
  for PID in ${PID_LIST}; do
      echo "kill -9 ${PID}"
      kill -9 ${PID}
      echo "${APP_NAME} stopped successfully"
  done
fi

```

- restart.sh

```shell
#!/bin/sh
# restart.sh

APP_NAME="sms-CANARY"

echo "stop ${APP_NAME} Application..."
sh stop.sh
sleep 5
echo "start ${APP_NAME} Application..."
sh start.sh

```

- application.properties

```properties
server.port=39873
spring.main.banner-mode=off
```

- logback-spring.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration scan="true" scanPeriod="60 seconds" debug="false">
    <!-- 定义日志文件的存储地址, 勿在 LogBack 的配置中使用相对路径 -->
    <property name="LOG_HOME" value="./logs" />
    <property name="APP_NAME" value="sms" />

    <!-- 控制台日志, 控制台输出 -->
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
            <!--格式化输出：%d表示日期，%thread表示线程名，%-5level：级别从左显示5个字符宽度,%msg：日志消息，%n是换行符-->
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>
        </encoder>
    </appender>

    <!--文件日志， 按照每天生成日志文件 -->
    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <!--日志文件输出的文件名-->
            <FileNamePattern>${LOG_HOME}/${APP_NAME}.%d{yyyy-MM-dd}.log</FileNamePattern>
            <!--日志文件保留天数-->
            <MaxHistory>30</MaxHistory>
        </rollingPolicy>
        <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
            <!--格式化输出：%d表示日期，%thread表示线程名，%-5level：级别从左显示5个字符宽度%msg：日志消息，%n是换行符-->
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{50} - %msg%n</pattern>
            <charset>UTF-8</charset>
        </encoder>
        <!--日志文件最大的大小-->
        <triggeringPolicy class="ch.qos.logback.core.rolling.SizeBasedTriggeringPolicy">
            <MaxFileSize>10MB</MaxFileSize>
        </triggeringPolicy>
    </appender>

    <!-- show parameters for hibernate sql 专为 Hibernate 定制 -->
    <logger name="org.hibernate.type.descriptor.sql.BasicBinder" level="TRACE"/>
    <logger name="org.hibernate.type.descriptor.sql.BasicExtractor" level="DEBUG"/>
    <logger name="org.hibernate.SQL" level="DEBUG"/>
    <logger name="org.hibernate.engine.QueryParameters" level="DEBUG"/>
    <logger name="org.hibernate.engine.query.HQLQueryPlan" level="DEBUG"/>

    <!--myibatis log configure-->
    <logger name="com.apache.ibatis" level="TRACE"/>
    <logger name="java.sql.Connection" level="DEBUG"/>
    <logger name="java.sql.Statement" level="DEBUG"/>
    <logger name="java.sql.PreparedStatement" level="DEBUG"/>

    <!-- 日志输出级别 -->
    <root level="DEBUG">
        <appender-ref ref="STDOUT"/>
        <appender-ref ref="FILE"/>
    </root>
</configuration>
```


#### 参考链接
1. https://docs.spring.io/spring-boot/docs/current/reference/html/appendix-executable-jar-format.html  
