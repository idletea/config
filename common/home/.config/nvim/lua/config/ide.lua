local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local lines = vim.api.nvim_buf_get_lines(0, line - 1, line, true)
    return col ~= 0 and lines[1]:sub(col, col):match("%s") == nil
end

local load_plugins = function()
    MiniDeps.add { source = "VonHeikemen/lsp-zero.nvim",
        checkout = "v4.x" }

    MiniDeps.add { source = "neovim/nvim-lspconfig" }

    MiniDeps.add { source = "hrsh7th/nvim-cmp" }
    MiniDeps.add { source = "hrsh7th/cmp-nvim-lsp" }
    MiniDeps.add { source = "hrsh7th/cmp-buffer" }
    MiniDeps.add { source = "hrsh7th/cmp-path" }
    MiniDeps.add { source = "hrsh7th/cmp-vsnip" }
    MiniDeps.add { source = "hrsh7th/vim-vsnip" }

    MiniDeps.add { source = "onsails/lspkind.nvim" }
    MiniDeps.add { source = "hedyhli/outline.nvim" }
end

local cmp_setup = function()
    local cmp = require("cmp")
    cmp.setup {
        view = { entries = "native" },
        formatting = { format = require("lspkind").cmp_format() },
        expand = function() vim.snippet.expand(args.body) end,
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources {
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
        },
        mapping = cmp.mapping.preset.insert {
            ["<c-b>"] = cmp.mapping.scroll_docs(-4),
            ["<c-f>"] = cmp.mapping.scroll_docs(4),
            ["<c-space>"] = cmp.mapping.complete(),
            ["<c-e>"] = cmp.mapping.abort(),
            ["<cr>"] = cmp.mapping({
                i = function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                        cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
                    else
                        fallback()
                    end
                end,
                s = cmp.mapping.confirm { select = true },
                c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
            }),
            ["<tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    if #cmp.get_entries() == 1 then
                        cmp.confirm({ select = true })
                    else
                        cmp.select_next_item()
                    end
                elseif has_words_before() then
                    cmp.complete()
                    if #cmp.get_entries() == 1 then
                        cmp.confirm({ select = true })
                    end
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
    }

    -- gray
    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
    -- blue
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
    -- light blue
    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
    vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
    vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
    -- pink
    vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
    vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
    -- front
    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
    vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
    vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
end

local lsp_setup = function()
    local lsp, lsp_zero = require("lspconfig"), require("lsp-zero")
    lsp_zero.extend_lspconfig {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        lsp_attach = function(_client, bufnr)
            lsp_zero.default_keymaps { buffer = bufnr }
        end,
        float_border = "rounded",
        sign_text = true,
    }

    for i, server in ipairs {
        "bashls", "html", "jsonls", "lua_ls", "pylsp", "ts_ls", "tilt_ls",
        "typst_lsp", "yamlls",
    } do
        lsp[server].setup {}
    end
end

-- Since we defer setting up lsp we need to manually start the lsp
-- server for the initial buffer, if an lsp server is availabile.
local initial_start_lsp = function()
    local lsp, ft = require("lspconfig"), vim.bo.filetype
    if #lsp.util.get_config_by_ft(ft) then
        vim.cmd [[LspStart]]
    end
end

local outline_setup = function()
    local filter = {
        "CONSTANT", "Class", "Method", "StaticMethod", "Function", "Interface", "Struct", "Macro",
    }
    require("outline").setup { symbols = { filter = filter } }
end

return {
    after = "telescope",
    defer = function()
        load_plugins()
        cmp_setup()
        lsp_setup()
        initial_start_lsp()
        outline_setup()
    end,
    provide = "ide",
}
