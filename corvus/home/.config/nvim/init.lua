---------
-- global

local xdg_dir = os.getenv("XDG_STATE_HOME")
local default_dir = os.getenv("HOME").."/.local/state/nvim"
local state_dir = xdg_dir or default_dir

vim.g.mapleader    = ";"
vim.opt.clipboard  = "unnamedplus"
vim.opt.backupdir  = state_dir .. "backup/"
vim.opt.undodir    = state_dir .. "undo/"
vim.opt.cursorline = false
