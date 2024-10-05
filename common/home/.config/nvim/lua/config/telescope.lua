return {
    defer = function()
        MiniDeps.add {
            source = "nvim-telescope/telescope.nvim",
            checkout = "0.1.x",
            depends = {
                { source = "nvim-lua/plenary.nvim" },
            },
        }
        MiniDeps.add {
            source = "nvim-telescope/telescope-ui-select.nvim",
        }

        local telescope = require("telescope")
        telescope.setup {
            defaults = { mappings = {
                i = { ["<C-h>"] = "which_key" },
            } }
        }

        telescope.load_extension("ui-select")
    end,
    provide = "telescope",
}
