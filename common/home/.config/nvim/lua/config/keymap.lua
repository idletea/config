return { after = "ide", defer = function()
    MiniDeps.add { source = "folke/which-key.nvim" }
    local which = require("which-key")
    local telescope = require("telescope.builtin")

    -- ctrl keys
    vim.keymap.set("n", "<c-p>", telescope.find_files, { desc = "Find files" })

    which.setup {
        preset = "helix",
    }

    which.add {
        -- bare keys
        { "gd",         vim.lsp.buf.definition,            desc = "Lsp definition" },
        { "gD",         vim.lsp.buf.declaration,           desc = "Lsp declaration" },
        { "gi",         vim.lsp.buf.implementation,        desc = "Lsp implementation" },
        { "gr",         vim.lsp.buf.references,            desc = "Lsp references" },
        { "gs",         vim.lsp.buf.signature_help,        desc = "Lsp signature help" },

        { "<leader>b",  group = "Buffer" },
        { "<leader>bd", MiniBufremove.delete,              desc = "Delete buffer" },
        { "<leader>bn", [[<cmd>bnext<cr>]],                desc = "Next buffer" },
        { "<leader>bp", [[<cmd>bprevious<cr>]],            desc = "Previous buffer" },

        { "<leader>f",  group = "Files" },
        { "<leader>ft", [[<cmd>NvimTreeFocus<cr>]],        desc = "File tree focus" },
        { "<leader>fc", [[<cmd>NvimTreeClose<cr>]],        desc = "File tree close" },
        { "<leader>fm", vim.lsp.buf.format,                desc = "Format buffer" },

        { "<leader>l",  group = "Lsp",                     icon = MiniIcons.get("lsp", "string") },
        { "<leader>la", vim.lsp.buf.code_action,           desc = "Code action" },
        { "<leader>lf", vim.lsp.buf.format,                desc = "Format" },
        { "<leader>lr", vim.lsp.buf.rename,                desc = "Rename" },
        { "<leader>lo", [[<cmd>Outline<cr>]],              desc = "Outline" },

        { "<leader>n",  group = "Notification" },
        { "<leader>nh", [[<cmd>Fidget history<cr>]],       desc = "History" },
        { "<leader>nc", [[<cmd>Fidget clear<cr>]],         desc = "Clear" },

        { "<leader>s",  group = "Select",                  icon = MiniIcons.get("lsp", "array") },
        { "<leader>sf", telescope.find_files,              desc = "Files" },
        { "<leader>sb", telescope.buffers,                 desc = "Buffers" },
        { "<leader>sl", telescope.lsp_document_symbols,    desc = "Lsp symbols" },
        { "<leader>sm", telescope.marks,                   desc = "Marks" },

        { "<leader>t",  group = "Tab" },
        { "<leader>tt", [[<cmd>tabnew<cr>]],               desc = "New tab" },
        { "<leader>tn", [[<cmd>tabnext<cr>]],              desc = "Next tab" },
        { "<leader>tp", [[<cmd>tabprevious<cr>]],          desc = "Previous tab" },
        { "<leader>tc", [[<cmd>tabclose<cr>]],             desc = "Close tab" },

        { "<leader>r",  group = "Misc",                    icon = MiniIcons.get("filetype", "mason") },
        { "<leader>rg", telescope.live_grep,               desc = "Grep" },
    }
end }
