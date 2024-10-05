local _M = {}

local log = require("config.log")
local quote = require("config.shell").quote

local query = function(pkgs)
    local pacman_q = function(pkgs)
        return os.execute("pacman -Q " .. quote(pkgs) .. " >/dev/null 2>&1")
    end

    -- if all already installed
    if pacman_q(table.concat(pkgs, " ")) then return pkgs, {} end

    -- sort installed from not
    local installed, uninstalled = {}, {}
    for _, pkg in ipairs(pkgs) do
        if pacman_q(pkg) then
            table.insert(installed, pkg)
        else
            table.insert(uninstalled, pkg)
        end
    end
    return installed, uninstalled
end

function _M.install(pkgs)
    local installed, uninstalled = query(pkgs)
    if #uninstalled == 0 then
        log.no_op("all packages already installed")
    else
        local to_install = table.concat(uninstalled, " ")
        log.exec("sudo pacman -S --needed --noconfirm " .. to_install)
    end
end

return _M
