---
layout: post
title: "VS Code user profile"
date: 2026-05-08
excerpt: "VS Code user profile, including extensions, themes and settings."
tags: [VS Code, profile]
comments: true
---

## extensions

Please execute the following command to find out which extensions you have installed.

```shell
code --list-extensions
```

The output is as follows:

```text
aaron-bond.better-comments
adpyke.codesnap
alefragnani.project-manager
anthropic.claude-code
bbenoist.shell
bierner.markdown-checkbox
bierner.markdown-emoji
bierner.markdown-preview-github-styles
bruno-api-client.bruno
chaselen.v2ex-playground
christian-kohler.path-intellisense
codezombiech.gitignore
csholmq.excel-to-markdown-table
darian-benam.vscode-robots-dot-txt-support
darkriszty.markdown-table-prettify
davidanson.vscode-markdownlint
dhruv.maven-dependency-explorer
dineug.vuerd-vscode
docker.docker
donjayamanne.git-extension-pack
donjayamanne.githistory
dotjoshjohnson.xml
dracula-theme.theme-dracula
eamodio.gitlens
editorconfig.editorconfig
esbenp.prettier-vscode
firefox-devtools.vscode-firefox-debug
formulahendry.auto-rename-tag
formulahendry.code-runner
foxundermoon.shell-format
funkyremi.vscode-google-translate
github.github-vscode-theme
github.vscode-pull-request-github
gitlab.gitlab-workflow
gruntfuggly.todo-tree
hashhar.gitattributes
hediet.vscode-drawio
huacnlee.autocorrect
intellsmi.comment-translate
joffreykern.markdown-toc
johnpapa.vscode-peacock
k--kato.intellij-idea-keybindings
kisstkondoros.vscode-gutter-preview
leetcode.vscode-leetcode
luyuhuang.rss
mdickin.markdown-shortcuts
mechatroner.rainbow-csv
meganrogge.template-string-converter
mhutchie.git-graph
microprofile-community.mp-rest-client-generator-vscode-ext
microprofile-community.mp-starter-vscode-ext
microprofile-community.vscode-microprofile-pack
miguelsolorio.fluent-icons
ms-azuretools.vscode-containers
ms-azuretools.vscode-docker
ms-ceintl.vscode-language-pack-zh-hans
ms-edgedevtools.vscode-edge-devtools
ms-kubernetes-tools.vscode-kubernetes-tools
ms-ossdata.vscode-pgsql
ms-vscode-remote.remote-containers
ms-vscode-remote.remote-ssh
ms-vscode-remote.remote-ssh-edit
ms-vscode-remote.remote-wsl
ms-vscode-remote.vscode-remote-extensionpack
ms-vscode.live-server
ms-vscode.remote-explorer
ms-vscode.remote-server
ms-vscode.vscode-speech
ms-vscode.vscode-speech-language-pack-zh-cn
ms-vsliveshare.vsliveshare
oderwat.indent-rainbow
openai.chatgpt
oracle.mysql-shell-for-vs-code
oracle.oracle-java
pkief.material-icon-theme
pomdtr.excalidraw-editor
reactreedev.reactree
redhat.fabric8-analytics
redhat.java
redhat.vscode-community-server-connector
redhat.vscode-microprofile
redhat.vscode-quarkus
redhat.vscode-rsp-ui
redhat.vscode-xml
redhat.vscode-yaml
redis.redis-for-vscode
ritwickdey.liveserver
shd101wyy.markdown-preview-enhanced
shengchen.vscode-checkstyle
sonarsource.sonarlint-vscode
streetsidesoftware.code-spell-checker
telesoho.vscode-markdown-paste-image
timonwong.shellcheck
tldraw-org.tldraw-vscode
tonybaloney.vscode-pets
ultram4rine.vscode-choosealicense
vivaxy.vscode-conventional-commits
vmware.vscode-boot-dev-pack
vmware.vscode-spring-boot
vscjava.vscode-gradle
vscjava.vscode-java-debug
vscjava.vscode-java-dependency
vscjava.vscode-java-pack
vscjava.vscode-java-test
vscjava.vscode-lombok
vscjava.vscode-maven
vscjava.vscode-spring-boot-dashboard
vscjava.vscode-spring-initializr
vscode-icons-team.vscode-icons
waderyan.gitblame
wayou.vscode-todo-highlight
yzane.markdown-pdf
yzhang.markdown-all-in-one
zainchen.json
ziyasal.vscode-open-in-github
```

## settings

settings.json

```json
{
    "update.mode": "none",
    "telemetry.feedback.enabled": false,
    "security.workspace.trust.enabled": false,
    "workbench.colorTheme": "Dracula Theme",
    "redhat.telemetry.enabled": false,
    "jdk.jdkhome": "/Library/Java/JavaVirtualMachines/jdk-1.8.jdk/Contents/Home",
    "xml.java.home": "/Library/Java/JavaVirtualMachines/jdk-1.8.jdk/Contents/Home",
    "xml.server.preferBinary": true,
    "files.autoSave": "afterDelay",
    "[markdown]": {
        "editor.defaultFormatter": "yzhang.markdown-all-in-one"
    },
    "[dockercompose]": {
        "editor.defaultFormatter": "redhat.vscode-yaml"
    },
    "workbench.iconTheme": "vscode-icons",
    "vscodeGoogleTranslate.preferredLanguage": "Chinese (Simplified)",
    "rss.accounts": {
        "e6604ee0-4b0f-11f1-9841-9b21496cddcb": {
            "name": "Default",
            "type": "local",
            "feeds": []
        }
    },
    "jdk.telemetry.enabled": false,
    "[json]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "commentTranslate.source": "Bing",
    "commentTranslate.hover.string": true,
    "workbench.productIconTheme": "fluent-icons"
}
```
