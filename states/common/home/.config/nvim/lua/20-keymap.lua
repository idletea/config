local cmd = function(s) return function() vim.cmd(s) end end
local keymap = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end
local imap = function(lhs, rhs, desc) keymap("i", lhs, rhs, desc) end
local nmap = function(lhs, rhs, desc) keymap("n", lhs, rhs, desc) end
local map = function(lhs, rhs, desc)
    imap(lhs, rhs, desc)
    nmap(lhs, rhs, desc)
end

-------------
-- keymaps --
-------------
vim.g.mapleader = ";"

map("<c-p>", cmd [[:Pick files]], "Pick files")
map("<c-k>", vim.lsp.buf.signature_help, "Lsp signature help")

-- buffer
map("<leader>bd", require("mini.bufremove").delete, "Buffer delete")
map("<leader>bn", cmd(":bn"), "Buffer next")
map("<leader>bp", cmd(":bp"), "Buffer prev")

-- tabs
map("<leader>tt", cmd(":tabnew"), "Tab open")
map("<leader>tn", cmd(":tabnext"), "Tab next")
map("<leader>tc", cmd(":tabclose"), "Tab close")

-- filetree
map("<leader>ft", cmd(":NvimTreeOpen"), "Filetree open")
map("<leader>fc", cmd(":NvimTreeClose"), "Filetree close")

-- goto
nmap("gd", vim.lsp.buf.definition, "Go to definition")
nmap("gD", vim.lsp.buf.declaration, "Go to declaration")
nmap("gi", vim.lsp.buf.implementation, "Go to implementation")
nmap("gr", vim.lsp.buf.references, "Go to references")
nmap("gt", vim.lsp.buf.type_definition, "Go to type def")

-- ripgrep (search)
map("<leader>rg", cmd [[:Pick grep_live]], "Live grep")
map("<leader>rr", cmd [[:Pick resume]], "Live grep resume")

-- lsp
map("<leader>la", vim.lsp.buf.code_action, "Lsp code actions")
map("<leader>lf", vim.lsp.buf.format, "Lsp format")
map("<leader>lr", vim.lsp.buf.rename, "Lsp rename")

-- diagnostics
map("<leader>dv", function()
    local new = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config {
        virtual_text = not new, virtual_lines = new
    }
end, "Diagnostic toggle virtual")
map("<leader>do", vim.diagnostic.open_float, "Diagnostic open")
map("<leader>dl", vim.diagnostic.setloclist, "Diagnostic loclist")

----------------
-- clue setup --
----------------
local miniclue = require("mini.clue")

triggers = {}
for _, keys in ipairs({ "<leader>", "'", "`", '"', "<c-r>", "<c-w>", "g", "z" }) do
    table.insert(triggers, { mode = "n", keys = keys })
    table.insert(triggers, { mode = "x", keys = keys })
end

clues = {
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
}
for _, args in ipairs({
    { "<leader>r",  "+Grep" },
    { "<leader>b",  "+Buffer" },
    { "<leader>t",  "+Tab" },
    { "<leader>d",  "+Diagnostics" },
    { "<leader>f",  "+Filetree" },
    { "<leader>l",  "+Lsp" },
}) do
    table.insert(clues, { mode = "i", keys = args[1], desc = args[2] })
    table.insert(clues, { mode = "n", keys = args[1], desc = args[2] })
end

miniclue.setup({
    triggers = triggers,
    clues = clues,
    window = {
        delay = 0, config = { width = 80 },
    },
})

