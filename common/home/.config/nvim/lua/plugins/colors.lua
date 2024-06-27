return {
    -- syncs the terminal bg with nvim's
    { "typicode/bg.nvim", lazy = false },
    -- dim inactive
    { "levouh/tint.nvim",
        opts = {
            tint = -25,
            saturation = 0.5,
            tint_background_colors = true,
        },
    },
    -- colorscheme
    { "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup()
            vim.cmd [[colorscheme gruvbox]]
        end,
    },
}
