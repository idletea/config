require("mini.deps").add { source = "ibhagwan/fzf-lua" }

local fzf = require("fzf-lua")
fzf.setup {}
fzf.register_ui_select()
