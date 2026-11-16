return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        spec = {
            { "<leader>f", group = "find" },
            { "<leader>g", group = "goto/format" },
            { "<leader>t", group = "test/trouble" },
            { "<leader>d", group = "debug" },
            { "<leader>c", group = "code" },
            { "<leader>r", group = "rename" },
        },
    },
}
