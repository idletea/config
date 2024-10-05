local _M = {}

local log = require("config.log")
local user_units = ".config/systemd/user/default.target.wants/"

function _M.enable(unit)
    local system = "/usr/lib/systemd/system/"
    local path = system .. unit
    if os.execute("test -e " .. path) then
        log.no_op(unit .. " already enabled")
    else
        log.exec("sudo systemctl enable --now " .. unit)
    end
end

function _M.user_enable(unit)
    local home = assert(os.getenv("HOME"))
    local path = home .. "/" .. user_units .. unit
    if os.execute("test -e " .. path) then
        log.no_op(unit .. " already enabled for user")
    else
        log.exec("systemctl --user enable --now " .. unit)
    end
end

return _M
