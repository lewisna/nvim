return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local parsers = {
			"lua",
			"javascript",
			"html",
			"go",
			"swift",
			"gdscript",
			"python",
			"json",
			"dockerfile",
			"css",
			"cpp",
			"yaml",
		}
		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = parsers,
			callback = function()
				pcall(vim.treesitter.start)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
