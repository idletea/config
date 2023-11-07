return {
    -- colorscheme
    { "andersevenrud/nordic.nvim",
        lazy = false, priority = 1000,
        config = function() vim.cmd([[ colorscheme nordic ]]) end,
    },
    -- util
    { "lukas-reineke/indent-blankline.nvim",
        main = "ibl", opts = {},
    },
    -- syntax
    { "jvirtanen/vim-hcl" },
    { "NoahTheDuke/vim-just" },
}
