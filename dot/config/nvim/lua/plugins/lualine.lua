return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            theme = "nord",
            section_separators = { left = "", right = "" },
            component_separators = "",
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "filetype" },
            lualine_y = {},
            lualine_z = { "location" },
        },
    },
}
