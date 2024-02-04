local _M = {}
local mini = function (name)
    table.insert(_M, { "echasnovski/mini."..name, version = "*", config = {},
}) end

mini("comment")
mini("tabline")
mini("bufremove")

return _M
