MiniDeps.add { source = "ibhagwan/fzf-lua" }
require("fzf-lua").setup()

vim.cmd [[FzfLua register_ui_select]]
