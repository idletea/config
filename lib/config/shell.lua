local _M = {}

-- heavily copied from pl.utils.quote_arg
function _M.quote(cmd)
    if type(cmd) == "table" then
        local stack = {}
        for i, arg in ipairs(cmd) do
            stack[i] = _M.quote(arg)
        end
        return table.concat(stack, " ")
    end

    if cmd == "" or cmd:find('[^a-zA-Z0-9_@%+=:,./-]') then
        cmd = "'" .. cmd:gsub("'", [['\'']]) .. "'"
    end

    return cmd
end

return _M
