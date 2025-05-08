local opt = vim.opt

opt.number = true
opt.relativenumber = true

vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

opt.scrolloff = 12

opt.hlsearch = false
opt.incsearch = true

opt.mouse = 'a'
opt.clipboard:append('unnamedplus')

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 4
opt.expandtab = true

opt.ignorecase = true
opt.smartcase = true

opt.swapfile = false
opt.autoread = true
vim.bo.autoread = true

opt.signcolumn = 'yes'
opt.list = true

opt.cursorline = true
opt.termguicolors = true

