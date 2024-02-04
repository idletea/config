return {
    { "hrsh7th/nvim-cmp",
        version = false,
        event = "VeryLazy",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "dcampos/nvim-snippy",
            "dcampos/cmp-snippy",
        },
        opts = function()
            local cmp = require("cmp")
            local types = require("cmp.types")
            vim.opt.completeopt = "menu,menuone,noinsert"

            cmp.setup {
                preselect = types.cmp.PreselectMode.None,
                sources = cmp.config.sources {
                    { name = "buffer" },
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "snippy" },
                },
                snippet = {
                    expand = function(args)
                        require("snippy").expand_snippet(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ["<c-space>"] = cmp.mapping.complete(),
                    ["<c-e>"] = cmp.mapping.abort(),
                    ["<cr>"] = cmp.mapping.confirm{ select = false },
                    ["<tab>"] = function(fallback)
                        if cmp.visible() then cmp.select_next_item()
                        else fallback() end
                    end,
                    ["<s-tab>"] = function(fallback)
                        if cmp.visible() then cmp.select_prev_item()
                        else fallback() end
                    end,
                },
            }

            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources{
                    { name = "git" },
                }, {
                    { name = "buffer" },
                },
            })
        end,
    },
}
