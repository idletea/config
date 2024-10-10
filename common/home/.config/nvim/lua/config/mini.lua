require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

require("mini.statusline").setup()
require("mini.tabline").setup()
require("mini.starter").setup()

return {
    defer = function()
        require("mini.bufremove").setup()
    end,
    provide = "mini",
}
