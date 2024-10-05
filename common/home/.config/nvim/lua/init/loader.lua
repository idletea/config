--- Simple neovim module loader.
-- The idea is each module loaded can optionally return a table with a function
-- for deferred setup steps, and optionally order it with respect to other
-- modules using `after` and `provide`.
--
-- Modules with an `after` value will not run until another module with the
-- same value as its `provide` is complete. For example if module A has
-- `after = "colorscheme-set"`, and module B has `provide = "colorscheme-set"`,
-- then module A will only have its deferred function run after B's is complete.

local _M = {}

--- Get the fully qualified path to `path` under config/lua.
-- @param <string> path relative to config/lua
-- @return <string> fully qualified path
function config_lua_dir(path)
    return vim.fs.joinpath(vim.fn.stdpath("config"), "lua", path)
end

--- Get the `require`able module name for `file`
-- @param file <string> name of file
-- @return <string | nil> module name if `file` is a lua module
function module_name(file)
    if file:match(".+%.(.+)$") == "lua" then
        return file:sub(0, file:len() - 4)
    end
end

--- Iterate over lua modules in `dir`.
-- @param dir <string> directory relative to config/lua
function modules(dir)
    local filenames = vim.fs.dir(dir)

    return function()
        local file, module

        repeat
            file = filenames()
            if file == nil then return nil end
            module = module_name(file)
        until module ~= nil

        return module
    end
end

--- Check for a value's presence in a table.
-- @param tbl <table> table to check
-- @param key <string> value to check
-- @return <int | bool> false, or the value's index
function in_table(tbl, key)
    for i, val in ipairs(tbl) do
        if val == key then return i end
    end
    return false
end

--- Load all modules in `dir`.
-- @param dir <string> directory to load modules from
function _M.load(dir)
    local callbacks = { default = {} }

    for module in modules(config_lua_dir(dir)) do
        local load_spec = require(dir .. "." .. module)
        if load_spec ~= nil and type(load_spec) == "table" then
            local after = load_spec["after"] or "default"
            if callbacks[after] == nil then callbacks[after] = {} end
            table.insert(callbacks[after], load_spec)
        end
    end

    vim.api.nvim_create_autocmd("UIEnter", { callback = function()
        -- provided values yet to have dependent callbacks called for
        local provided_todo = {"default"}
        -- provided values for which callbacks were called
        local provided_processed = {}

        local current_provided = "default"
        repeat
            for _, load_spec in ipairs(callbacks[current_provided] or {}) do
                if load_spec["defer"] ~= nil then load_spec["defer"]() end
                local provide = load_spec["provide"]
                if provide ~= nil and not in_table(provided_todo, provide) then
                    table.insert(provided_todo, provide)
                end
            end

            table.remove(provided_todo, in_table(provided_todo, current_provided))
            table.insert(provided_processed, current_provided)
            current_provided = provided_todo[1]
        until current_provided == nil

        for after, load_specs in pairs(callbacks) do
            if #load_specs > 0 and not in_table(provided_processed, after) then
                vim.notify("loader: no module provided '" .. after .. "'")
            end
        end
    end, once = true })
end

return _M
