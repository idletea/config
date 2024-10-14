local cmd = function(s) return function() vim.cmd(s) end end
local keymap = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end
local imap = function(lhs, rhs, desc) keymap("i", lhs, rhs, desc) end
local nmap = function(lhs, rhs, desc) keymap("n", lhs, rhs, desc) end

imap("<c-p>", cmd(":Pick files"), "Pick files")
nmap("<c-p>", cmd(":Pick files"), "Pick files")
nmap("<leader>rg", cmd(":Pick grep_live"), "Live grep")

imap("<leader>ft", cmd(":NvimTreeOpen"), "Filetree open")
nmap("<leader>ft", cmd(":NvimTreeOpen"), "Filetree open")
imap("<leader>fc", cmd(":NvimTreeClose"), "Filetree close")
nmap("<leader>fc", cmd(":NvimTreeClose"), "Filetree close")

-- buffer
nmap("<leader>bd", cmd(":bd"), "Buffer delete")
nmap("<leader>bn", cmd(":bn"), "Buffer next")
nmap("<leader>bp", cmd(":bp"), "Buffer prev")

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

        { mode = "n", keys = "<leader>b", desc = "+Buffer" },
        { mode = "f", keys = "<leader>b", desc = "+Filetree" },
    },
    window = {
        delay = 150 ,
        config = { width = 80 },
    },
})
