local theme = "dropdown"

return {
    "nvim-telescope/telescope.nvim", tag = "0.1.3",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        defaults = {
            mappings = { i = { ["<c-h>"] = "which_key" }, },
        },
        pickers = {
            find_files = { theme = theme },
            live_grep = { theme = theme },
            lsp_document_symbols = { theme = theme },
        },
    },
}
