return {
    "nvim-telescope/telescope.nvim", tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        defaults = {
            mappings = { i = { ["<c-h>"] = "which_key" }, },
        },
        pickers = {
            find_files = { theme = "dropdown" },
            live_grep = { theme = "dropdown" },
            lsp_document_symbols = { theme = "dropdown" },
        },
    },
}
