local _M = {}
local mini = function (name) table.insert(_M, { "echasnovski/mini."..name,
    version = "*", init = function() require("mini."..name).setup() end
}) end

mini("comment")
mini("tabline")
mini("files")
mini("bufremove")

return _M
