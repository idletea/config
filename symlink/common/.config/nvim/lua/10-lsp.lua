require("mini.deps").add { source = "neovim/nvim-lspconfig" }

vim.lsp.config("*", {
    root_markers = { ".git", ".jj" },
})

vim.lsp.enable {
    "pylsp", "pyrefly", "yamlls", "cssls", "html", "ty",
    "ts_ls", "just", "rust_analyzer", "lua_ls", "terraformls",
}
