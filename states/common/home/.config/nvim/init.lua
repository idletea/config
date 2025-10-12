vim.opt.number = true
vim.opt.cursorline = true
vim.opt.scrolloff = 6
vim.opt.signcolumn = "yes:1"
vim.opt.inccommand = "nosplit"

vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undo"
vim.opt.undofile = true

require("00-mini")
require("10-nvim-tree")
require("10-treesitter")
require("10-lsp")
require("20-keymap")
