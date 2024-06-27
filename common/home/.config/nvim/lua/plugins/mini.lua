return {
    "echasnovski/mini.nvim",
    version = "*",
    init = function()
        for _, mod in ipairs({
            "notify", "tabline", "statusline",
            "bracketed", "files", "jump2d", "bufremove",
        }) do
            require("mini." .. mod).setup()
        end
        vim.notify = MiniNotify.make_notify()
    end,
}
