return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, opts)
        local lsp = require("lspconfig")
        local cap = vim.lsp.protocol.make_client_capabilities()
        cap = require("cmp_nvim_lsp").default_capabilities(cap)

        local servers = {
            "gopls", "pylsp", "clangd",
            "rust_analyzer", "tsserver",
            "dhall_lsp_server",
        }
        for _, server in ipairs(servers) do
            lsp[server].setup { capabilities = capabilities }
        end
    end,
}
