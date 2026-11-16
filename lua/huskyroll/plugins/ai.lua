return {
    {
        "Exafunction/windsurf.vim",
        tag = "1.6.20",
        config = function()
            vim.keymap.set("i", "<S-Space>", function()
                return vim.fn["codeium#CycleCompletions"](1)
            end, { expr = true, silent = true, desc = "Codeium: next completion" })
            vim.keymap.set("i", "<M-Space>", function()
                return vim.fn["codeium#CycleCompletions"](-1)
            end, { expr = true, silent = true, desc = "Codeium: previous completion" })
            vim.keymap.set("i", "X", function()
                return vim.fn["codeium#Clear"]()
            end, { expr = true, silent = true, desc = "Codeium: clear suggestion" })
        end,
    },
}
