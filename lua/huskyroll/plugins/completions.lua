return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()

            local ls = require("luasnip")
            vim.keymap.set({ "i", "s" }, "<C-L>", function()
                ls.jump(1)
            end, { silent = true, desc = "Snippet: jump forward" })
            vim.keymap.set({ "i", "s" }, "<C-J>", function()
                ls.jump(-1)
            end, { silent = true, desc = "Snippet: jump backward" })

            vim.keymap.set({ "i", "s" }, "<C-S-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, { silent = true, desc = "Snippet: change choice" })
        end,
    },
    {
        "saghen/blink.cmp",
        version = "*",
        opts = {
            snippets = { preset = "luasnip" },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            completion = {
                documentation = { auto_show = true },
            },
            keymap = { preset = "default" },
        },
        opts_extend = { "sources.default" },
    },
}
