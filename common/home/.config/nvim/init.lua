---------
-- global

local xdg_dir = os.getenv("XDG_STATE_HOME")
local default_dir = os.getenv("HOME") .. "/.local/state/nvim/"
local state_dir = xdg_dir or default_dir

vim.g.mapleader    = ";"
vim.opt.clipboard  = "unnamedplus"
vim.opt.backupdir  = state_dir .. "backup/"
vim.opt.undodir    = state_dir .. "undo/"
vim.opt.cursorline = false

require("pkgs/mini")

MiniDeps.now(function()
    MiniDeps.add({ source = "rose-pine/neovim" })
    require("rose-pine").setup()
    vim.cmd [[ colorscheme rose-pine ]]
end)

MiniDeps.later(function()
    require("pkgs/nvim-lspconfig")
    require("pkgs/nvim-treesitter")
    require("pkgs/nvim-treesitter-context")
    require("pkgs/gitsigns")
    require("pkgs/oil")

    require("keymap")
end)
