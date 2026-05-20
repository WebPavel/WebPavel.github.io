---
layout: post
title: "shell snippets"
date: 2026-05-20
excerpt: "shell snippets I collected from Github."
tags: [ shell, snippet ]
comments: true
---

## Common

```shell
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if a command exists
has_command() {
  command -v "$1" > /dev/null 2>&1
}

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "ERROR: This script must be run as root"
    exit 1
fi
```

## download file

```shell
# Function to download file
download_file() {
    local url="$1"
    local output="$2"
    
    # Create directory if it doesn't exist
    mkdir -p "$(dirname "$output")"
    
    echo "Downloading: $url"
    if curl -fsSL "$url" -o "$output"; then
        echo -e "${GREEN}✓${NC} Downloaded: $output"
        return 0
    else
        echo -e "${RED}✗${NC} Failed: $output"
        return 1
    fi
}
```

## OS

```shell
# Detect platform
OS=$(uname -s)
platform=$(uname -m)

case "$OS" in
  Linux)  OS_NAME="linux" ;;
  Darwin) OS_NAME="macos" ;;
  *)      log_error "Unsupported OS: $OS"; exit 1 ;;
esac

case "$platform" in
  x86_64|amd64)   platform_NAME="amd64" ;;
  aarch64|arm64)  platform_NAME="arm64" ;;
  *)              log_error "Unsupported architecture: $platform"; exit 1 ;;
esac
```

```shell
# Currently supporting:
#   - macos
#   - linux
#   - freebsd
detect_platform() {
    local platform
    platform="$(uname -s | tr '[:upper:]' '[:lower:]')"
    
    case "${platform}" in
        linux) platform="linux" ;;
        darwin) platform="macos" ;;
        freebsd) platform="freebsd" ;;
    esac
    
    printf '%s' "${platform}"
}
```

```shell
# Currently supporting:
#   - x86_64
#   - arm
#   - aarch64
detect_arch() {
    local arch
    arch="$(uname -m | tr '[:upper:]' '[:lower:]')"
    
    case "${arch}" in
        amd64) arch="x86_64" ;;
        armv*) arch="arm" ;;
        arm64) arch="aarch64" ;;
    esac
    
    # `uname -m` in some cases mis-reports 32-bit OS as 64-bit, so double check
    if [ "${arch}" = "x86_64" ] && [ "$(getconf LONG_BIT)" -eq 32 ]; then
        arch="i686"
    elif [ "${arch}" = "aarch64" ] && [ "$(getconf LONG_BIT)" -eq 32 ]; then
        arch="arm"
    fi
    
    printf '%s' "${arch}"
}
```

```shell
PLATFORM="$(detect_platform)"
ARCH="$(detect_arch)"

if [ "$PLATFORM" != "macos" ]; then
    echo "only available on MacOs systems"
    exit 1
fi
```

## docker

```shell
if ! command -v docker &> /dev/null; then
    echo -e "${RED}ERROR: Docker is not installed or not in PATH${NC}"
    echo "Please install Docker: https://docs.docker.com/get-docker/"
    exit 1
fi

if ! docker info &> /dev/null; then
    echo -e "${RED}ERROR: Docker daemon is not running${NC}"
    echo "Please start Docker Desktop or the Docker daemon"
    exit 1
fi

if ! command -v docker compose &> /dev/null; then
    echo -e "${RED}ERROR: Docker Compose is not available${NC}"
    echo "Please install Docker Compose v2"
    exit 1
fi

echo -e "${GREEN}✓ Docker and Docker Compose are available${NC}"
```

## add to PATH

```shell
shell_name=$(basename "${SHELL:-}" 2>/dev/null || echo "")

case "$shell_name" in
  zsh)
    profile_files="$HOME/.zshrc $HOME/.zprofile"
    ;;
  bash)
    if [ "$OS_NAME" == "macos" ]; then
        profile_files="$HOME/.bash_profile $HOME/.profile"
    else
        profile_files="$HOME/.bashrc $HOME/.profile"
    fi
    ;;
  fish)
    profile_files="$HOME/.config/fish/config.fish"
    ;;
  *)
    profile_files="$HOME/.profile"
    ;;
esac
```
