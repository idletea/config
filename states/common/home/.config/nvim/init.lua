vim.g.mapleader      = ";"
vim.g.maplocalleader = ";"

vim.opt.clipboard  = "unnamedplus"
vim.opt.signcolumn = "yes"
vim.opt.number     = true
vim.opt.cursorline = true
vim.opt.showmode   = false
vim.opt.scrolloff  = 4
vim.opt.laststatus = 3

vim.loader.enable()
vim.diagnostic.config{ virtual_text = true }

require("00-bootstrap")

require("mini.deps").now(function()
    require("10-mini")
    require("mini.deps").add { source = "rebelot/kanagawa.nvim" }
    vim.cmd [[:colorscheme kanagawa-dragon]]
end)

require("mini.deps").later(function()
    require("20-mini")
    require("20-fzf")
    require("20-lsp")
    require("20-nvim-tree")
    require("20-tabscope")
    require("20-treesitter")
    require("20-blink")
    require("20-gitsigns")
    require("30-keymap")
end)

