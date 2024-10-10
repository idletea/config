vim.g.mapleader      = ";"
vim.g.maplocalleader = ";"

vim.opt.inccommand  = "split"
vim.opt.clipboard   = "unnamedplus"
vim.opt.cursorline  = true
vim.opt.number      = true
vim.opt.signcolumn  = "yes"
vim.opt.showmode    = false
vim.opt.scrolloff   = 4

vim.loader.enable()
require("init.mini")
require("init.loader")
    .load("config")

vim.cmd [[au BufNewFile,BufRead *.tofu set ft=terraform]]
