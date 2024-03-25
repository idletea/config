MiniDeps.add({
    source = "nvim-treesitter/nvim-treesitter",
    hooks = {
        post_checkout = function()
            vim.cmd [[ TSUpdate ]]
        end,
    },
})

require("nvim-treesitter.configs").setup({
    indent = { enable = true },
    highlight = { enable = true },
    ensure_installed = {
        "bash",
        "c",
        "dockerfile",
        "elixir",
        "fish",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "go",
        "graphql",
        "hcl",
        "html",
        "http",
        "ini",
        "javascript",
        "jq",
        "json",
        "just",
        "lua",
        "passwd",
        "proto",
        "python",
        "ruby",
        "scss",
        "sql",
        "ssh_config",
        "terraform",
        "toml",
        "tsx",
        "typst",
        "yaml",
        "zig",
    },
})
