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
bierner.github-markdown-preview
bierner.markdown-checkbox
bierner.markdown-emoji
bierner.markdown-footnotes
bierner.markdown-mermaid
bierner.markdown-preview-github-styles
bierner.markdown-yaml-preamble
davidanson.vscode-markdownlint
editorconfig.editorconfig
esbenp.prettier-vscode
johnpapa.read-time
ms-azuretools.vscode-docker
ms-edgedevtools.vscode-edge-devtools
ms-vscode-remote.remote-containers
ms-vscode-remote.remote-ssh
ms-vscode-remote.remote-ssh-edit
ms-vscode-remote.remote-wsl
ms-vscode-remote.vscode-remote-extensionpack
ms-vscode.remote-explorer
ms-vscode.remote-server
ms-vscode.wordcount
pkief.material-icon-theme
redhat.java
redhat.vscode-yaml
streetsidesoftware.code-spell-checker
vmware.vscode-boot-dev-pack
vmware.vscode-spring-boot
vscjava.vscode-java-debug
vscjava.vscode-java-dependency
vscjava.vscode-java-pack
vscjava.vscode-java-test
vscjava.vscode-maven
vscjava.vscode-spring-boot-dashboard
vscjava.vscode-spring-initializr
```

```shell
#!/bin/bash
filename="extensions.txt"
while read line
do
  echo "$line"
  code --install-extension "$line"
done < "$filename"
```

## settings

settings.json

```json
{
    "update.mode": "none",
    "telemetry.feedback.enabled": false,
    "security.workspace.trust.enabled": false,
    "redhat.telemetry.enabled": false,
    "files.autoSave": "afterDelay",
    "[java]": {
        "editor.defaultFormatter": "redhat.java"
    },
    "editor.formatOnPaste": true,
    "git.autofetch": true,
    "[markdown]": {
        "editor.wordWrap": "on"
    },
    "[json]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[jsonc]": {
        "editor.defaultFormatter": "vscode.json-language-features"
    },
    "[html]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[javascript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[typescript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "workbench.iconTheme": "material-icon-theme",
    "markdown.validate.enabled": true,
    "markdown.updateLinksOnFileMove.enabled": "prompt",
    "editor.inlineSuggest.enabled": true
}
```
