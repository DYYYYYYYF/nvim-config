#!/bin/bash

INSTALL_PATH="$HOME/AppData/Local/nvim-data/site/pack/lazy/start/lazy.nvim"

if [ ! -d "$INSTALL_PATH" ]; then
  git clone https://github.com/folke/lazy.nvim.git "$INSTALL_PATH"
  echo "lazy.nvim 安装成功"
else
  echo "lazy.nvim 已存在，跳过安装"
fi
