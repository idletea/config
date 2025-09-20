require("mini.deps").add {
    source = "saghen/blink.cmp",
    checkout = "v1.6.0",
}

require("blink.cmp").setup {
    keymap = {
        preset = "default",
        ["<tab>"] = { "select_next", "fallback" },
        ["<s-tab>"] = { "select_prev", "fallback" },
        ["<down>"] = { "select_next", "fallback" },
        ["<up>"] = { "select_prev", "fallback" },
        ["<enter>"] = { "accept", "fallback" },
    },
    completion = {
        menu = { draw = { treesitter = { "lsp" } } },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        list = { selection = { preselect = false } },
        accept = { auto_brackets = { enabled = false } },
    },
    sources = {
        default = { "lsp", "path", "buffer" },
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning"
    },
}
