---
layout: post
title: "Vim Configure"
date: 2022-06-02
excerpt: "how to configure vim."
tags: [vim]
comments: false
---


# set color scheme

```
cd ~/.vim/bundle
git clone git://github.com/altercation/vim-colors-solarized.git
mv vim-colors-solarized ~/.vim/bundle/
```

# vim plugin manager

## Vundle Installation

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

# _vimrc configure file

```
" 去除VI一致性
set nocompatible
filetype off
" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 让vundle管理插件版本
Plugin 'VundleVim/Vundle.vim'
Plugin 'iamcco/markdown-preview.nvim'
call vundle#end()
" 加载vim自带的和插件相应的语法和文件类型相关脚本
filetype plugin indent on

" 显示行号
set number
" 括号时匹配另一半
set showmatch
" 光标行高亮
set cursorline
" 高亮搜索关键字
set hlsearch
" 不产生swap文件
set noswapfile
" 不产生备份文件
set nobackup
" 自动加载外部修改
set autoread
" 搜索忽略大小写
set ignorecase
" 历史命令行数
set history=1000
" 设置文件编码utf-8
set encoding=utf-8
set termencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
" tab对应4个字符
set tabstop=4
set softtabstop=4
" 自动缩进
set autoindent
" 语法高亮
syntax enable 
set background=dark
" 设置主题
colorscheme solarized
" 设置字体
set guifont=Consolas:h12
" 设置vim下和外部的复制
vmap <C-c> "+y
```



# Reference Link
[Vundle.vim](https://github.com/VundleVim/Vundle.vim)  
[vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)
