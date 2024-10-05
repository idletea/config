return { defer = function()
    MiniDeps.add{ source = "tiagovla/scope.nvim" }
    require("scope").setup()
end }
