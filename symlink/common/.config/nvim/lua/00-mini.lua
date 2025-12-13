-- bootstrap
local path_package = vim.fn.stdpath("data") .. "/site"
local mini_path = path_package .. "/pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
    vim.cmd [[echo "Installing `mini.nvim`" | redraw]]
    vim.fn.system {
        "git", "clone", "--filter=blob:none",
        "https://github.com/echasnovski/mini.nvim", mini_path
    }
    vim.cmd [[packadd mini.nvim | helptags ALL]]
    vim.cmd [[echo "Installed `mini.nvim`" | redraw]]
end
require("mini.deps").setup({ path = { package = path_package } })

-- configure
local icons = require("mini.icons")
local keymap = require("mini.keymap")

icons.setup()
icons.mock_nvim_web_devicons()

require("mini.statusline").setup()
require("mini.tabline").setup()
require("mini.notify").setup()
require("mini.completion").setup()
require("mini.clue").setup()
require("mini.bufremove").setup({ silent = true})

keymap.map_multistep("i", "<tab>",   { "pmenu_next" })
keymap.map_multistep("i", "<s-tab>", { "pmenu_prev" })
keymap.map_multistep("i", "<cr>",    { "pmenu_accept" })
