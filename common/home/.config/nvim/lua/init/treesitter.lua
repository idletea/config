MiniDeps.add { source = "nvim-treesitter/nvim-treesitter" }
MiniDeps.add { source = "nvim-treesitter/nvim-treesitter-context" }
MiniDeps.add { source = "nvim-treesitter/nvim-treesitter-textobjects" }

require("nvim-treesitter.configs").setup({
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = {
        select = {
            enable = true,
            keymaps  = {
                ["ac"] = "@class.outer", ["ic"] = "@class.inner",
                ["af"] = "@function.outer", ["if"] = "@function.inner",
            },
        },
        move = {
            enable = true,
            goto_next_start = {
                ["]]"] = { query = "@function.outer", desc = "Next function" },
                ["]c"] = { query = "@class.outer", desc = "Next class" },
                ["]b"] = { query = "@block.outer", desc = "Next block" },
            },
            goto_previous_start = {
                ["[["] = { query = "@function.outer", desc = "Previous function" },
                ["[c"] = { query = "@class.outer", desc = "Previous class" },
                ["[b"] = { query = "@block.outer", desc = "Previous block" },
            },
        },
    },
})

require("treesitter-context").setup({
    max_lines = 4,
    multiline_threshold = 2,
})
vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true })
