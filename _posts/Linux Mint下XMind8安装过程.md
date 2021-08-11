#### Linux Mint下XMind8安装过程



###### 1. 官网下载

```http
https://www.xmind.net/download/xmind8/
```

##### 2. 解压缩

```shell
unzip xmind-8-update9-linux.zip [-d] dir
```

##### 3. 安装必要组件

```shell
java --version
sudo apt install openjdk-8-jdk -y
# 安装目录/home/pl/下载/xmind-8-update9-linux
sudo ./setup.sh
```

##### 4. 安装出错，缺少依赖

ubuntu下载地址

```http
https://packages.ubuntu.com/
```

```shell
# 安装libwebkitgtk-1.0-0，而其依赖libjavascriptcoregtk-1.0-0，而后者依赖libicu60
sudo apt install libicu60_60.2-3ubuntu3.1_amd64.deb libjavascriptcoregtk-1.0-0_2.4.11-3ubuntu3_amd64.deb libwebkitgtk-1.0-0_2.4.11-3ubuntu3_amd64.deb -y
```

##### 5. 配置并创建快捷方式

```shell
# 安装目录/home/pl/下载/xmind-8-update9-linux
sudo vim XMind_amd64/XMind.ini
cd XMind_amd64
sudo ./XMind
```

> 修改../和./为绝对路径
>
> 指定jdk路径

XMind.ini

```ini
-configuration
/home/pl/下载/xmind-8-update9-linux/XMind_amd64/configuration
-data
/home/pl/下载/xmind-8-update9-linux/workspace
-startup
/home/pl/下载/xmind-8-update9-linux/plugins/org.eclipse.equinox.launcher_1.3.200.v20160318-1642.jar
--launcher.library
/home/pl/下载/xmind-8-update9-linux/plugins/org.eclipse.equinox.launcher.gtk.linux.x86_64_1.1.400.v20160518-1444
--launcher.defaultAction
openFile
--launcher.GTK_version
2
-eclipse.keyring
@user.home/.xmind/secure_storage_linux
-vm
/usr/lib/jvm/java-8-openjdk-amd64/bin
-vmargs
-Dfile.encoding=UTF-8
```

创建快捷方式

```shell
cd /usr/share/applications
sudo vim xmind8.desktop
```

```sh
[Desktop Entry]
Name=XMind8
Exec=/home/pl/下载/xmind-8-update9-linux/XMind_amd64/XMind
Terminal=false
Type=Application
Icon=xmind
StartupNotify=true
Comment=XMind - The most popular mind mapping software.
MimeType=application/xmind;x-scheme-handler/xmind;
Categories=Office;
```

##### 6. 参考

```http
https://blog.csdn.net/weixin_42287867/article/details/108925282
https://blog.csdn.net/weixin_34409357/article/details/88802513
```