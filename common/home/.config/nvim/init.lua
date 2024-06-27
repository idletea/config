local xdg_dir = os.getenv("XDG_STATE_HOME")
local default_dir = os.getenv("HOME") .. "/.local/state/nvim/"
local state_dir = xdg_dir or default_dir

vim.g.mapleader      = ";"
vim.g.maplocalleader = "\\"

vim.o.timeout = true
vim.o.timeoutlen = 200

vim.opt.clipboard  = "unnamedplus"
vim.opt.backupdir  = state_dir .. "backup/"
vim.opt.undodir    = state_dir .. "undo/"
vim.opt.cursorline = true
vim.opt.wrap       = true
vim.opt.mouse      = "a"
vim.opt.shortmess  = "aosTWAICF"
vim.opt.showmode   = false
vim.opt.textwidth  = 88
vim.opt.signcolumn = "yes"
vim.opt.number     = true

require("config.lazy")
require("config.keymap")
