local _M = {}

_M["config"] = {
    indent = { enable = true },
    highlight = { enable = true },
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
        "starlark",
        "terraform",
        "toml",
        "tsx",
        "typst",
        "yaml",
        "zig",
    },
}

_M["context"] = {
    enable = true,
    max_lines = 4, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 2, -- Maximum number of lines to show for a single context
    trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = "cursor",  -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20, -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

return _M
