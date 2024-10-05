return { defer = function()
    MiniDeps.add{ source = "nvim-treesitter/nvim-treesitter" }
    MiniDeps.add{ source = "nvim-treesitter/nvim-treesitter-textobjects" }
    MiniDeps.add{ source = "nvim-treesitter/nvim-treesitter-context" }

    require("nvim-treesitter.configs").setup {
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = { query = "@function.outer", desc = "Select after function" },
                    ["if"] = { query = "@function.inner", desc = "Select inner function" },
                    ["ac"] = { query = "@class.outer", desc = "Select after class" },
                    ["ic"] = { query = "@class.inner", desc = "Select inner class" },
                    ["as"] = { query = "@scope", query_group = "locals", desc = "Select after scope" },
                },
            },
            move = {
                enable = true,
                goto_next_start = {
                    ["]]"] = { query = "@function.outer", desc = "Next function" },
                    ["]c"] = { query = "@class.outer", desc = "Next class" },
                },
                goto_previous_start = {
                    ["[["] = { query = "@function.outer", desc = "Previous function" },
                    ["[c"] = { query = "@class.outer", desc = "Previous class" },
                },
            }
        },
    }

    require("treesitter-context").setup{
        max_lines = 4,
        multiline_threshold = 2,
    }

    vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true })
end }
