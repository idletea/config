require("mini.deps").add { source = "neovim/nvim-lspconfig" }

vim.lsp.config("*", {
    root_markers = { ".git", ".jj" },
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        -- pyrefly overlaps pylsp features
        if client.config.name == "pyrefly" then
            client.server_capabilities.declarationProvider = false
            client.server_capabilities.definitionProvider = false
            client.server_capabilities.documentSymbolProvider = false
            client.server_capabilities.implementationProvider = false
            client.server_capabilities.referencesProvider = false
        end
    end,
})

vim.lsp.enable {
    "pylsp", "pyrefly", "yamlls", "cssls", "html", "ty",
    "ts_ls", "just", "rust_analyzer", "lua_ls", "terraformls",
}
