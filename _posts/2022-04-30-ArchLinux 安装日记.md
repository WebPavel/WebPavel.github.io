---
layout: post
title: "ArchLinux 安装日记"
date: 2022-04-30
excerpt: "how to install archlinux on a new computer."
tags: [archlinux, arch, os]
comments: true
---

## ArchLinux 安装日记

### 检查uefi引导

```shell
ls /sys/firmware/efi/efivars
```

###  连网检查

```shell
ip -brief link
ping -c 5 archlinux.org
```

### 时间同步

```shell
timedatectl set-ntp true
timedatectl status
```

### 硬盘分区

```shell
fdisk -l
fdisk /dev/nvme0n1
# 创建GPT分区
g
n
+512M
n
w
fdisk -l /dev/nvme0n1
```

### 格式化并挂载分区

```shell
mkfs.fat -F 32 /dev/nvme0n1p1
mkfs.ext4 -b 4096 /dev/nvme0n1p2
mount -t ext4 -o discard,noatime /dev/nvme0n1p2 /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
df
```

### 修改镜像源

```shell
curl -L -o /etc/pacman.d/mirrorlist "https://archlinux.org/mirrorlist/?country=CN&protocol=http&use_mirror_status=on"
```

### 安装系统内核及其他软件包

```shell
pacstrap /mnt base linux linux-firmware
pacstrap /mnt base-devel sudo bash-completion e2fsprogs ntfs-3g
pacstrap /mnt vim networkmanager dhcpcd sof-firmware udev xfce4-terminal
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```

### 新系统初始化

```shell
# 设置时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 同步时间
hwclock --systohc
vim /etc/locale.gen
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo jelly > /etc/hostname
vim /etc/hosts
127.0.0.1        localhost
::1              localhost
127.0.1.1        jelly.localdomain jelly
mkinitcpio -P
passwd
useradd -m -G wheel -s /bin/bash karga
passwd kargah
EDITOR=vim visudo
kargah ALL=(ALL) ALL
```

### 安装引导程序

```shell
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```

### 重启清理

```shell
exit
umount -R /mnt
reboot
```

### 软件安装

```shell
# 开机自动联网
sudo systemctl enable --now NetworkManager
# 时间同步
sudo timedatectl set-ntp true
# 开启本地DSN服务
sudo systemctl enable --now systemd-resolved
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
# 优化固态硬盘
sudo systemctl enable fstrim.timer
sudo vim /etc/pacman.conf
[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
sudo pacman -Sy archlinuxcn-keyring
sudo pacman -S xorg xorg-xinit i3 dmenu
cp /etc/X11/xinit/xinitrc ~/.xinitrc
vim .xinitrc
exec i3
# 配置i3环境
sudo vim .config/i3/config
exec --no-startup-id fcitx5 -d
exec --no-startup-id compton -b
exec --no-startup-id feh --randomize --bg-fill ~/Pictures/*
sudo pacman -S yay firewalld net-tools
sudo systemctl enable --now firewalld
sudo pacman -S netork-manager-applet compton gwenview autotiling feh neofetch
# 安装声音，蓝牙驱动
sudo pacman -S alsa-utils pulseaudio pulseaudio-alsa bluedevil pulseaudio-bluetooth bluez-utils pavucontrol bluetoothctl
sudo systemctl enable --now bluetooth
vim /etc/pulse/default.pa
load-module module-switch-on-connect
vim /etc/bluetooth/main.conf
[General]
DiscoverableTimeout = 0
[Policy]
AutoEnable=true
# 安装显卡驱动
sudo pacman -S nvidia nvidia-settings cuda xorg-server-devel lib32-nvidia-utils lib32-opencl-nvidia
# 安装中文字体
sudo pacman -S ttf-dejavu wqy-zenhei wqy-microhei
# 安装解压缩软件
sudo pacman -S p7zip unrar
# 安装输入法
sudo pacman -S fcitx5-im fcitx5-pinyin-zhwiki fcitx5-chinese-addons fcitx5-qt fcitx5-gtk fcitx5-configtool
sudo vim /etc/environment
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
INPUT_METHOD=fcitx
SDL_IM_MODULE=fcitx
exec --no-startup-id fcitx5 -d
# 安装lantern
yay -S lantern-bin
cd /usr/lib
sudo ln -sf libpcap.so.1 libpcap.so.0.8
export https_proxy=127.0.0.1:33759
# 安装网易云音乐
yay -S netease-cloud-music
# 安装noto字体
sudo pacman -S noto-fonts noto-fonts-extra noto-fonts-emoji noto-fonts-cjk
# 安装WPS
yay -S wps-office-cn wps-office-mui-zh-cn ttf-wps-fonts
# 安装微信
yay -S wechat-uos
yay -S xt7-player-mpv
# 安装Markdown编辑器
yay -S typora-free
sudo pacman -S pandoc miktex
# 安装edge浏览器
yay -S microsoft-edge-dev-bin
# 开机自动挂载硬盘
sudo blkid
sudo vim /etc/fstab
UUID=8137BFAA1E822A59 /mnt ntfs3 defaults 0 0
# 或
echo "$(blkid -o export /dev/sda1|grep '^UUID') /mnt ntfs3 defaults 0 0" >> /mnt/etc/fstab
mkdir Pictures
cp /mnt/Share/Pictures/'_Konachan.com - 329324 2girls brown_hair building city close hatsune_miku long_hair megurine_luka signed spencer_sais stairs train vocaloid watermark.jpg' ~/Pictures/
# 安装Java开发环境
sudo pacman -S git jdk8-openjdk jdk11-openjdk maven
# 安装字体
sudo pacman -S nerd-fonts-complete
sudo archlinux-java set java-11-openjdk
sudo pacman -S docker
sudo systemctl enable --now docker
# 安装fastgithub
yay -S fastgithub-bin
sudo cp /opt/fastgithub-bin/cacert/fastgithub.crt /etc/ca-certificates/trust-source/anchors/
sudo update-ca-trust
# 修改中文环境
vim .bashrc
export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8
```



