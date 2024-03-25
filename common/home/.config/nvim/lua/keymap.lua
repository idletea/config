local lsp = vim.lsp
local keymap = vim.keymap
local map_n = function(k, c, desc)
    keymap.set("n", k, c, { silent = true, desc = desc })
end

local MiniPick = require("mini.pick")
local MiniBufremove = require("mini.bufremove")
local git = require("gitsigns")

-- misc
map_n("K", lsp.buf.hover, "LSP hover")

-- ctrl
map_n("<c-l>", [[<cmd>nohl<cr>]], "Clear highlighting")
map_n("<c-k>", lsp.buf.signature_help, "LSP signature help")
map_n("<c-n>", [[<cmd>bnext<cr>]], "Next buffer")
map_n("<c-j>", MiniPick.builtin.buffers, "Pick buffer")
map_n("<c-p>", MiniPick.builtin.files, "Pick files")

-- goto
map_n("]d", vim.diagnostic.goto_next, "Goto next diagnostic")
map_n("[d", vim.diagnostic.goto_prev, "Goto prev diagnostic")
map_n("gD", lsp.buf.declaration, "Goto declaration")
map_n("gd", lsp.buf.definition, "Goto definition")
map_n("gi", lsp.buf.implementation, "Goto implementation")
map_n("gr", lsp.buf.references, "Goto references")
map_n("gt", lsp.buf.type_definition, "Goto type definition")

-- leader
map_n("<leader>fm", lsp.buf.format, "LSP Format")
map_n("<leader>rg", MiniPick.builtin.grep_live, "Select live grep")

map_n("<leader>bd", MiniBufremove.delete, "Delete Buffer")
map_n("<leader>bg", MiniPick.registry.buf_lines, "Grep in buffer")
map_n("<leader>bf", MiniPick.builtin.buffers, "Grep for buffer")

map_n("<leader>la", lsp.buf.code_action, "LSP Code actions")
map_n("<leader>lf", lsp.buf.format, "LSP Format")
map_n("<leader>lr", lsp.buf.rename, "LSP Rename")

map_n("<leader>sf", MiniPick.builtin.files, "Select files")
map_n("<leader>sg", MiniPick.builtin.grep, "Select grep")
map_n("<leader>sr", MiniPick.builtin.grep_live, "Select live grep")
map_n("<leader>sm", MiniPick.registry.marks, "Select marks")

map_n("<leader>gs", git.stage_hunk, "Git stage hunk")
map_n("<leader>gr", git.reset_hunk, "Git reset hunk")
map_n("<leader>gS", git.stage_buffer, "Git stage buffer")
map_n("<leader>gR", git.reset_buffer, "Git reset buffer")
map_n("<leader>gb", function() git.blame_line { full = true } end, "Git blame line")
map_n("<leader>gl", git.toggle_current_line_blame, "Git blame toggle")
map_n("<leader>gd", git.diffthis, "Git diff this")

-- tab completion
keymap.set("i", "<tab>", [[pumvisible() ? "\<c-n>" : "\<tab>"]],   { expr = true })
keymap.set("i", "<s-tab>", [[pumvisible() ? "\<c-p>" : "\<s-tab>"]], { expr = true })

-- clue
local MiniClue = require("mini.clue")
require("mini.clue").setup({
    window = { delay = 125 },
    clues = {
        MiniClue.gen_clues.builtin_completion(),
        MiniClue.gen_clues.g(),
        MiniClue.gen_clues.marks(),
        MiniClue.gen_clues.registers(),
        MiniClue.gen_clues.windows(),
        MiniClue.gen_clues.z(),
        { mode = "n", keys = "<leader>b", desc = "+Buffers" },
        { mode = "n", keys = "<leader>l", desc = "+LSP" },
        { mode = "n", keys = "<leader>s", desc = "+Selectors" },
        { mode = "n", keys = "<leader>g", desc = "+Git" },
        { mode = "n", keys = "<leader>f", desc = "+File" },
        { mode = "n", keys = "<leader>r", desc = "+Ripgrep" },
    },
    triggers = {
        -- custom groups
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },

        -- defaults

        -- leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },
        -- built-in completion
        { mode = "i", keys = "<C-x>" },
        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },
        -- marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },
        -- registers
        { mode = "n", keys = "\"" },
        { mode = "x", keys = "\"" },
        { mode = "i", keys = "<c-r>" },
        { mode = "c", keys = "<c-r>" },
        -- window commands
        { mode = "n", keys = "<c-w>" },
        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
    },
})
