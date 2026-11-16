return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"fredrikaverpil/neotest-golang",
        "nvim-neotest/nvim-nio",
	},
	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
				}),
				require("neotest-golang")({}),
			},
		})
		vim.keymap.set("n", "<leader>tc", function()
			neotest.run.run()
		end, { desc = "Test: run nearest" })

		vim.keymap.set("n", "<leader>tf", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "Test: run file" })

		vim.keymap.set("n", "<leader>ts", function()
			neotest.run.run(vim.fn.getcwd())
		end, { desc = "Test: run suite (cwd)" })
	end,
}
