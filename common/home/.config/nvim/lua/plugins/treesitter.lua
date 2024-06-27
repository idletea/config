local ensure_installed = {
    "bash", "c", "dockerfile", "elixir", "fish", "git_config", "git_rebase",
    "gitcommit", "gitignore", "go", "graphql", "hcl", "html", "http", "ini",
    "javascript", "jq", "json", "just", "lua", "passwd", "proto", "python",
    "ruby", "scss", "sql", "ssh_config", "starlark", "terraform", "toml", "tsx",
    "typst", "yaml", "zig", "lua"
}

return {
    { "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                auto_install = true,
                ensure_installed = ensured_installed,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    { "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
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
            })
        end,
    },
    { "nvim-treesitter/nvim-treesitter-context",
        opts = {
            enable = true,
            max_lines = 4,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 2,
            trim_scope = "outer",
            mode = "cursor",
            separator = "-",
            zindex = 20,
            on_attach = nil,
        },
    },
}
