MiniDeps.add({ source = "neovim/nvim-lspconfig" })

local lspconfig = require("lspconfig")
local servers = {
    "pylsp", "gopls", "clangd", "rust_analyzer", "tsserver",
}

for _, server in ipairs(servers) do
    lspconfig[server].setup{}
end
