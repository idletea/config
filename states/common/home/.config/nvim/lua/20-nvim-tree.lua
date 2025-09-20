vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("mini.deps").add { source = "nvim-tree/nvim-tree.lua" }

require("nvim-tree").setup {
    sort = { sorter = "case_sensitive" },
    view = { width = 30 },
    renderer = { group_empty = true },
    filters = { dotfiles = true },
}
