MiniDeps.add { source = "rebelot/kanagawa.nvim" }
vim.cmd [[colorscheme kanagawa-dragon]]

MiniDeps.add { source = "lewis6991/gitsigns.nvim" }
require("gitsigns").setup()

MiniDeps.add{ source = "tiagovla/scope.nvim" }
require("scope").setup()

MiniDeps.add {
    source = "j-hui/fidget.nvim",
    checkout = "v1.4.5",
}
require("fidget").setup({
    notification = { override_vim_notify = true }
})
