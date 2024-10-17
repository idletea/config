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
local fzf = require("fzf-lua")

map("<c-p>", fzf.files, "Pick files")
map("<c-k>", vim.lsp.buf.signature_help, "Lsp signature help")
map("<leader>rg", fzf.live_grep, "Live grep")
map("<leader>fz", fzf.builtin, "Fzf")

-- goto
map("gd", vim.lsp.buf.definition, "Go to definition")
map("gD", vim.lsp.buf.declaration, "Go to declaration")
map("gi", vim.lsp.buf.implementation, "Go to implementation")
map("gr", vim.lsp.buf.references, "Go to references")
map("gt", vim.lsp.buf.type_definition, "Go to type def")

-- buffer
map("<leader>bd", cmd(":bd"), "Buffer delete")
map("<leader>bn", cmd(":bn"), "Buffer next")
map("<leader>bp", cmd(":bp"), "Buffer prev")

-- tab
map("<leader>tt", cmd(":tabnew"), "Tab new")
map("<leader>tc", cmd(":tabclose"), "Tab close")
map("<leader>tn", cmd(":tabnext"), "Tab next")
map("<leader>tp", cmd(":tabprevious"), "Tab previous")

-- filetree
map("<leader>ft", cmd(":NvimTreeOpen"), "Filetree open")
map("<leader>fc", cmd(":NvimTreeClose"), "Filetree close")

-- lsp
map("<leader>la", vim.lsp.buf.code_action, "Lsp code actions")
map("<leader>lf", vim.lsp.buf.format, "Lsp format")
map("<leader>lr", vim.lsp.buf.rename, "Lsp rename")
map("<leader>li", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, "Lsp inlay hints")

----------------
-- clue setup --
----------------
triggers = {}
for _, keys in ipairs({"<leader>", "'", "`", '"', "<c-r>", "<c-w>", "g", "z" }) do
    table.insert(triggers, { mode = "n", keys = keys })
    table.insert(triggers, { mode = "x", keys = keys })
end

clues = {
    MiniClue.gen_clues.g(),
    MiniClue.gen_clues.marks(),
    MiniClue.gen_clues.registers(),
    MiniClue.gen_clues.windows(),
    MiniClue.gen_clues.z(),
}
for _, args in ipairs({
    { "<leader>r", "+Misc" },
    { "<leader>b", "+Buffer" },
    { "<leader>f", "+Filetree" },
    { "<leader>l", "+Lsp" },
}) do
    table.insert(clues, { mode = "i", keys = args[1], desc = args[2] })
    table.insert(clues, { mode = "n", keys = args[1], desc = args[2] })
end

MiniClue.setup({
    triggers = triggers, clues = clues,
    window = {
        delay = 150 , config = { width = 80 },
    },
})
