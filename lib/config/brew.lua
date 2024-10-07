local _M = {}

local path = require("pl.path")
local utils = require("pl.utils")
local log = require("config.log")

function _M.query(packages)
    local installed, uninstalled = {}, {}
    local prefix = "/opt/homebrew"

    for _, package in ipairs(packages) do
        local cellar = path.join(prefix, "Cellar", package)
        local cask = path.join(prefix, "Caskroom", package)
        if path.isdir(cellar) or path.isdir(cask) then
            table.insert(installed, package)
        else
            table.insert(uninstalled, package)
        end
    end

    return {
        installed = installed,
        uninstalled = uninstalled
    }
end

function _M.install(packages)
    local query = _M.query(packages)

    if #query.uninstalled == 0 then
        log.no_op("all brew packages already installed")
        return false
    end

    local to_install = utils.quote_arg(query.uninstalled)
    log.info("installing brew packages: " .. to_install)
    os.execute("brew install " .. to_install)
    return true
end

function _M.install_casks(casks)
    local query = _M.query(casks)

    if #query.uninstalled == 0 then
        log.no_op("all brew casks already installed")
        return false
    end

    local to_install = utils.quote_arg(query.uninstalled)
    log.info("installing brew casks: " .. to_install)
    os.execute("brew install --cask " .. to_install)
    return true
end

return _M
