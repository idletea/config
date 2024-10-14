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

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

require("mini.statusline").setup()
require("mini.tabline").setup()
require("mini.bufremove").setup()
require("mini.clue").setup()
