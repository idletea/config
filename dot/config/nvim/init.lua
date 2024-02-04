-- globals
vim.g.mapleader   = ";"
vim.opt.number     = true
vim.opt.showmode   = false
vim.opt.signcolumn = "yes"
vim.opt.clipboard  = "unnamedplus"

-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load configs
require("lazy").setup("plugins")
require("keymap")
