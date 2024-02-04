local which = require("which-key")
local keymap_opts = { silent = true }
local map_n = function (k, c) vim.keymap.set("n", k, c, keymap_opts) end

-- no-which keys
map_n("<c-n>", "<cmd>bnext<cr>")
map_n("<c-l>", "<cmd>nohl<cr>")
map_n("<c-k>", vim.lsp.buf.signature_help)
map_n("<c-p>", "<cmd>Telescope find_files<cr>")

-- no-leader keys
which.register({
    ["]"] = {
        d = { vim.diagnostic.goto_next, "Goto next diagnostic" }
    },
    ["["] = {
        d = { vim.diagnostic.goto_prev, "Goto prev diagnostic" }
    },
    g = {
        D = { vim.lsp.buf.declaration, "Goto declaration" },
        d = { vim.lsp.buf.definition, "Goto definition" },
        i = { vim.lsp.buf.implementation, "Goto implementation" },
        r = { vim.lsp.buf.references, "Goto references" },
        t = { vim.lsp.buf.type_definition, "Goto type definition" },
    },
    K = { vim.lsp.buf.hover, "LSP hover" },
})

-- leader keys
which.register({
    b = { d = { MiniBufremove.delete, "Delete buffer" }, },
    c = { a = { vim.lsp.buf.code_action, "Code actions" }, },
    d = { s = { "<cmd>Telescope lsp_document_symbols<cr>", "LSP Symbols" }, },
    f = {
        d = { "<cmd>Telescope find_files<cr>", "Find files" },
        m = { function() vim.lsp.buf.format { async = true } end, "Format" },
    },
    l = {
        a = { vim.lsp.buf.code_action, "Code actions" },
        f = { function() vim.lsp.buf.format { async = true } end, "Format" },
        r = { vim.lsp.buf.rename, "Rename" },
    },
    r = {
        g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
        n = { vim.lsp.buf.rename, "Rename" },
    },
    t = {
        d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Toggle document trouble" },
        l = { "<cmd>TroubleToggle quickfix<cr>", "Toggle loclist trouble" },
        q = { "<cmd>TroubleToggle quickfix<cr>", "Toggle quickfix trouble" },
        t = { "<cmd>TroubleToggle<cr>", "Toggle trouble" },
        w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Toggle workspace trouble" },
    },
}, { prefix = "<leader>" })

