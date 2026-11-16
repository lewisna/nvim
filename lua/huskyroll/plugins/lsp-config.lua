return {
    {
        "mason-org/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "mason-org/mason-lspconfig.nvim",
        lazy = false,
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "lua_ls",
                "gopls",
                "pyright",
                "ts_ls",
                "html",
            },
            automatic_enable = {
                "lua_ls",
                "gopls",
                "pyright",
                "ts_ls",
                "html",
            },
        },
        config = function(_, opts)
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            vim.lsp.config("*", {
                capabilities = capabilities,
            })
            vim.lsp.config("html", {
                filetypes = { "html", "templ", "tmpl" },
            })

            require("mason-lspconfig").setup(opts)

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local map_opts = { buffer = args.buf }
                    vim.keymap.set("n", "K", vim.lsp.buf.hover,
                        vim.tbl_extend("force", map_opts, { desc = "LSP: Hover docs" }))
                    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition,
                        vim.tbl_extend("force", map_opts, { desc = "LSP: Go to definition" }))
                    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references,
                        vim.tbl_extend("force", map_opts, { desc = "LSP: List references" }))
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
                        vim.tbl_extend("force", map_opts, { desc = "LSP: Code action" }))
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
                        vim.tbl_extend("force", map_opts, { desc = "LSP: Rename symbol" }))
                end,
            })
        end,
    },
}
