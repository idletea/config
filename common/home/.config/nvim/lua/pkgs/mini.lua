local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"

if not vim.loop.fs_stat(mini_path) then
    vim.cmd("echo 'Installing `mini.nvim`' | redraw")
    local clone_cmd = {
        "git", "clone", "--filter=blob:none",
        "https://github.com/echasnovski/mini.nvim", mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd("packadd mini.nvim | helptags ALL")
    vim.cmd("echo 'Installed `mini.nvim`' | redraw")
end

require("mini.deps").setup({
    path = { package = path_package }
})

MiniDeps.now(function()
    require("mini.basics").setup()
    require("mini.statusline").setup()
    require("mini.tabline").setup()
    require("mini.starter").setup({
        header = "",
        footer = "",
    })
end)

MiniDeps.later(function()
    MiniDeps.add({ source = "nvim-tree/nvim-web-devicons" })

    require("mini.pick").setup()
    require("mini.extra").setup()
    require("mini.comment").setup()
    require("mini.bufremove").setup()
    require("mini.completion").setup()
end)
