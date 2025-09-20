require("mini.deps").add { source = "neovim/nvim-lspconfig" }

vim.lsp.config("*", {
    root_markers = { ".git" },
})

vim.lsp.enable {
    "pylsp", "pyrefly", "yamlls", "cssls", "html",
    "ts_ls", "just", "rust_analyzer", "lua_ls", "terraformls",
}
