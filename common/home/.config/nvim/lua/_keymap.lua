local keymap, lsp, which_key = vim.keymap, vim.lsp, require("which-key")
local map_n = function(k, c, desc)
    keymap.set("n", k, c, { silent = true, desc = desc })
end

vim.o.timeout = true
vim.o.timeoutlen = 200

map_n("<c-l>", [[<cmd>nohl<cr>]], "clear highlighting")
map_n("<c-p>", MiniPick.builtin.files, "files")

-- bare keys
require("which-key").register({
    g = {
        name = "goto",
        d = { lsp.buf.definition, "definition" },
        D = { lsp.buf.declaration, "declaration" },
    },
})

-- leader key
require("which-key").register({
    b = {
        name = "buffer",
        d = { MiniBufremove.delete, "delete buffer" },
        n = { [[<cmd>bnext<cr>]], "next buffer" },
        p = { [[<cmd>bprevious<cr>]], "previous buffer" },
    },
    f = {
        name = "files",
        t = { MiniFiles.open, "browse files" },
        m = { lsp.buf.format, "format buffer" },
    },
    l = {
        name = "lsp",
        a = { lsp.buf.code_action, "code action" },
        f = { lsp.buf.format, "format" },
        r = { lsp.buf.rename, "rename" },
        o = { [[<cmd>Outline<cr>]], "outline" },
    },
    r = {
        name = "misc",
        g = { MiniPick.builtin.grep_live, "grep" },
    },
    s = {
        name = "select",
        f = { MiniPick.builtin.files, "files" },
        b = { MiniPick.builtin.buffers, "buffers" },
        l = { MiniPick.registry.lsp, "lsp" },
        m = { MiniPick.registry.marks, "marks" },
    },
    t = {
        name = "tab",
        t = { [[<cmd>tabnew<cr>]], "new tab" },
        n = { [[<cmd>tabnext<cr>]], "next tab" },
        p = { [[<cmd>tabprevious<cr>]], "previous tab" },
        c = { [[<cmd>tabclose<cr>]], "close tab" },
    },
}, { prefix = "<leader>" })

which_key.setup{}
