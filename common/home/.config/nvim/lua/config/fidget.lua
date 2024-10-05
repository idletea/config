return { defer = function()
    MiniDeps.add {
        source = "j-hui/fidget.nvim",
        checkout = "v1.4.5" }

    require("fidget").setup {
        notification = { override_vim_notify = true } }
end }
