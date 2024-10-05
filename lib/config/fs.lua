local _M = {}

local lfs = require("lfs")
local log = require("config.log")
local quote = require("config.shell").quote

local function children(dir)
    local ps = io.popen("fd --hidden . " .. quote(dir))
    return ps:lines()
end

local function path_join(base, join)
    if string.find(base, "/$") == nil then
        base = base .. "/"
    end

    if string.find(join, "^/") ~= nil then
        join = string.sub(join, 2)
    end

    return base .. join
end

-- the path of `child_path` relative to `local_dir`
local function relative_path(local_dir, child_path)
    local trailing_slash = local_dir
    if string.find(local_dir, "/$") ~= nil then
        trailing_slash = local_dir .. "/"
    end
    local pattern = "^" .. local_dir .. "*"
    return string.gsub(child_path, pattern, "")
end

function _M.dir(path)
    if os.execute("test -e " .. quote(path)) then
        if os.execute("test -d " .. quote(path)) then
            log.no_op(path .. " already exists")
        else
            log.error(path .. " is not a directory")
        end
        return false
    else
        log.exec("mkdir -p " .. quote(path))
        return true
    end
end

function _M.recursive(dir)
    local home, pwd = os.getenv("HOME"), lfs.currentdir()
    assert(home and pwd)

    for child in children(dir) do
        local rel_path = relative_path(dir, child)
        local link_path = path_join(home, rel_path)
        local target_path = path_join(pwd, child)

        local target_info = lfs.symlinkattributes(target_path)
        local link_info = lfs.symlinkattributes(link_path)

        if assert(target_info)["mode"] == "directory" then
            -- create dir to contain links if one doesn't exist
            if link_info == nil then
                log.exec("mkdir -p " .. link_path)
            elseif assert(link_info)["mode"] ~= "directory" then
                log.error(link_path .. " is not a directory")
            end
        else
            -- create link if one doesn't exist
            if link_info == nil then
                log.exec("ln -s " .. target_path .. " " .. link_path)
            elseif link_info["target"] == nil then
                log.error(link_path .. " is not a symlink")
            elseif link_info["target"] == target_path then
                log.no_op(link_path .. " already linked")
            else
                log.error(link_path .. " is a symlink to the wrong target")
            end
        end
    end
end

function _M.sys_file(args)
    local src, dst = args["src"], args["dst"]
    local _, _, status = os.execute("sudo test -e " .. dst)
    local file_exists = status == 0

    if file_exists then
        local _, _, hashes_match = os.execute(
            [[test "$(md5sum ]] .. src
            .. [[| awk '{print $1}')" = ]]
            .. [["$(sudo md5sum ]] .. dst
            .. [[| awk '{print $1}')"]]
        )
        if hashes_match == 0 then
            log.no_op(dst .. " already in place")
        else
            log.error(dst .. " exists, but in inconsistent state")
        end
    else
        local cp = "sudo cp " .. src .. " " .. dst
        local chmod = "sudo chown root:root " .. dst
        log.exec(cp .. " && " .. chmod)
    end
end

return _M
