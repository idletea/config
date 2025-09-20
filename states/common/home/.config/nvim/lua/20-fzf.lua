require("mini.deps").add { source = "ibhagwan/fzf-lua" }
local FzfLua = require("fzf-lua")

FzfLua.setup()
FzfLua.register_ui_select()
