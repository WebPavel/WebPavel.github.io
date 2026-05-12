---
layout: post
title: "bash scripts from XPipe Community script samples"
date: 2026-05-12
excerpt: "bash scripts from XPipe Community script samples."
tags: [ bash, XPipe ]
comments: true
---

## System health status

```shell
DELIMITER="-------------------------------------"

hostname -f &> /dev/null && printf "Hostname : $(hostname -f)" || printf "Hostname : $(hostname -s)"

echo -e "Kernel Version :" $(uname -r)
which arch && printf "OS Architecture :"$(arch | grep x86_64 &> /dev/null) && printf " 64 Bit OS\n"  || printf " 32 Bit OS\n"

echo -en "System Uptime : " $(uptime -p)
echo -e "\nCurrent System Date & Time : "$(date +%c)

echo -e "Total Swap Memory in MiB : "$(grep -w SwapTotal /proc/meminfo|awk '{print $2/1024}')", in GiB : "\
$(grep -w SwapTotal /proc/meminfo|awk '{print $2/1024/1024}')
echo -e "Swap Free Memory in MiB : "$(grep -w SwapFree /proc/meminfo|awk '{print $2/1024}')", in GiB : "\
$(grep -w SwapFree /proc/meminfo|awk '{print $2/1024/1024}')

echo -e "\n\nMost Recent 3 Reboots"
echo -e "$DELIMITER$DELIMITER"
last -x 2> /dev/null|grep reboot 1> /dev/null && /usr/bin/last -x 2> /dev/null|grep reboot|head -3 || \
echo -e "No reboot events are recorded."

echo -e "\n\nMost Recent 3 Shutdowns"
echo -e "$DELIMITER$DELIMITER"
last -x 2> /dev/null|grep shutdown 1> /dev/null && /usr/bin/last -x 2> /dev/null|grep shutdown|head -3 || \
echo -e "No shutdown events are recorded."

```

## Git Config

```shell
git config --global user.name "My name"
git config --global user.email "myemail@myorg.com"
git config --global core.autocrlf true
```

## CRLF to LF

crlf_to_lf.sh

```shell
for arg in "$@"
do
    file="$arg"
    temp_file=$(mktemp)
    awk '{ sub("\r$", ""); print }' "$file" > "$temp_file"
    cat "$temp_file" > "$file"
    rm "$temp_file"
done
```

## Apt upgrade

apt_upgrade.sh

```shell
sudo apt update && sudo apt upgrade
```
