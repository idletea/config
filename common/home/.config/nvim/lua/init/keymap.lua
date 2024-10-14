local cmd = function(s) return function() vim.cmd(s) end end
local keymap = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end
local imap = function(lhs, rhs, desc) keymap("i", lhs, rhs, desc) end
local nmap = function(lhs, rhs, desc) keymap("n", lhs, rhs, desc) end
local bmap = function(lhs, rhs, desc)
    imap(lhs, rhs, desc)
    nmap(lhs, rhs, desc)
end

bmap("<c-p>", cmd(":FzfLua files"), "Pick files")
bmap("<c-k>", vim.lsp.buf.signature_help, "Lsp signature help")
bmap("<leader>rg", cmd(":FzfLua live_grep"), "Live grep")
bmap("<leader>fz", cmd(":FzfLua builtin"), "Fzf")

-- buffer
bmap("<leader>bd", cmd(":bd"), "Buffer delete")
bmap("<leader>bn", cmd(":bn"), "Buffer next")
bmap("<leader>bp", cmd(":bp"), "Buffer prev")

-- filetree
bmap("<leader>ft", cmd(":NvimTreeOpen"), "Filetree open")
bmap("<leader>fc", cmd(":NvimTreeClose"), "Filetree close")

-- lsp
bmap("<leader>la", vim.lsp.buf.code_action, "Lsp code actions")
bmap("<leader>lf", vim.lsp.buf.format, "Lsp format")
bmap("<leader>lr", vim.lsp.buf.rename, "Lsp rename")
bmap("<leader>li", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, "Lsp inlay hints")

MiniClue.setup({
    triggers = {
        -- leader
        { mode = "n", keys = "<leader>" },
        { mode = "x", keys = "<leader>" },

        -- marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<c-r>" },
        { mode = "c", keys = "<c-r>" },

        -- window
        { mode = "n", keys = "<c-w>" },

        -- window
        { mode = "n", keys = "<c-w>" },

        -- g / z
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
    },
    clues = {
        MiniClue.gen_clues.g(),
        MiniClue.gen_clues.marks(),
        MiniClue.gen_clues.registers(),
        MiniClue.gen_clues.windows(),
        MiniClue.gen_clues.z(),

        { mode = "i", keys = "<leader>r", desc = "+Misc" },
        { mode = "n", keys = "<leader>r", desc = "+Misc" },
        { mode = "i", keys = "<leader>b", desc = "+Buffer" },
        { mode = "n", keys = "<leader>b", desc = "+Buffer" },
        { mode = "i", keys = "<leader>f", desc = "+Filetree" },
        { mode = "n", keys = "<leader>f", desc = "+Filetree" },
        { mode = "i", keys = "<leader>l", desc = "+Lsp" },
        { mode = "n", keys = "<leader>l", desc = "+Lsp" },
    },
    window = {
        delay = 150 ,
        config = { width = 80 },
    },
})
