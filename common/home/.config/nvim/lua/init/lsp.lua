vim.g.coq_settings = {
    auto_start = "shut-up",
    clients = {
        snippets = { warn = {} },
    },
}

MiniDeps.add { source = "neovim/nvim-lspconfig" }
MiniDeps.add { source = "ms-jpq/coq_nvim" }

local lsp = require("lspconfig")
local coq = require("coq")

for _, server in ipairs {
    "pylsp", "rust_analyzer", "bashls", "clangd", "fish_lsp", "gopls",
    "graphql", "html", "tilt_ls", "ts_ls", "typst_lsp", "yamlls", "zls",
} do
    lsp[server].setup(coq.lsp_ensure_capabilities())
end
