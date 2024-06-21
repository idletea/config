---------
-- global
vim.g.mapleader    = ";"

vim.opt.cursorline = true
vim.opt.textwidth  = 88
vim.opt.showmode   = false
vim.opt.number     = true
vim.opt.signcolumn = "yes"
vim.opt.shortmess  = "aosTWAICF"
vim.opt.clipboard  = "unnamedplus"

-----------
-- packages
require("_mini")
local add, now, later =
    MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
    -- colorscheme + terminal bg sync
    add{ source = "typicode/bg.nvim" }
    add{ source = "catppuccin/nvim" }
    vim.cmd [[colorscheme catppuccin-mocha]]

    -- ui elements
    require("mini.notify").setup{}
    require("mini.statusline").setup{}
    require("mini.tabline").setup{}
end)

-- packages with deferred load
later(function()
    -- mini
    add { source = "nvim-tree/nvim-web-devicons" }
    require("mini.bracketed").setup{}
    require("mini.bufremove").setup()
    require("mini.extra").setup()
    require("mini.files").setup{}
    require("mini.jump2d").setup{}
    require("mini.pick").setup()
    vim.notify = MiniNotify.make_notify()
    vim.ui.select = MiniNotify.ui_select

    -- tab scoped buffers
    add{ source = "tiagovla/scope.nvim" }
    require("scope").setup{}

    -- treesitter
    add{ source = "nvim-treesitter/nvim-treesitter",
         hooks = { post_checkout = function() vim.cmd [[TSUpdate]] end } }
    add{ source = "nvim-treesitter/nvim-treesitter-context" }
    add{ source = "nvim-treesitter/nvim-treesitter-textobjects" }
    require("nvim-treesitter.configs").setup(require("_treesitter")["config"])
    require("treesitter-context").setup(require("_treesitter")["context"])

    -- lsp + completion
    add{ source = "neovim/nvim-lspconfig" }
    add{ source = "hrsh7th/nvim-cmp" }
    add{ source = "hrsh7th/cmp-nvim-lsp" }
    add{ source = "hrsh7th/cmp-buffer" }
    add{ source = "hrsh7th/cmp-path" }
    local lsp, cmp = require("lspconfig"), require("cmp")
    cmp.setup(require("_cmp"))

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    lsp.rust_analyzer.setup{ capabilities = capabilities }
    lsp.tsserver.setup{ capabilities = capabilities }
    lsp.bashls.setup{ capabilities = capabilities }
    lsp.pylsp.setup{ capabilities = capabilities }
    vim.cmd [[LspStart]]

    -- misc
    add{ source = "hedyhli/outline.nvim" }
    require("outline").setup{}

    -- keymap
    add{ source = "folke/which-key.nvim" }
    require("_keymap")
end)
