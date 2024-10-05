local _M = {}

local reset  = "\27[0m"
local bold   = "\27[1m"
local dim    = "\27[2m"
local italic = "\27[3m"

local black   = "\27[30m"
local red     = "\27[31m"
local green   = "\27[32m"
local yellow  = "\27[33m"
local blue    = "\27[34m"
local magenta = "\27[35m"
local cyan    = "\27[36m"
local white   = "\27[37m"

local writeln = function(text)
    io.write(text .. reset .. "\n")
end

function _M.section(title)
    writeln(bold .. "[- " .. title .. " -]")
end

function _M.info(title)
    writeln(bold .. "[>] " .. title)
end

function _M.warn(msg)
    writeln(bold .. yellow .. "[!] " .. msg)
end

function _M.error(msg)
    writeln(bold .. red .. "[x] " .. msg)
end

function _M.no_op(msg)
    writeln(dim .. "[-] " .. msg)
end

function _M.exec(cmd)
    local prompt = bold .. blue .. "[$] "
    writeln(prompt .. reset .. italic .. cmd)
    io.flush()

    local _, _, status = os.execute(cmd)
    if status ~= 0 then os.exit(status) end
end

return _M
