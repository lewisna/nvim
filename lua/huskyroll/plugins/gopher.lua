return {
	"olexsmir/gopher.nvim",
	version = "*",
    ft = { "go", "gomod", "gowork" },
	config = function()
		require("gopher").setup()

		local runner = require("gopher._utils.runner")

		---@param subcmd string
		---@param args string[]
		local function go_run_async(subcmd, args)
			local cmd = vim.list_extend({ "go", subcmd }, args)
			runner.async(cmd, function(out)
				vim.schedule(function()
					if out.code ~= 0 then
						vim.notify(
							("go %s failed: %s"):format(subcmd, out.stderr),
							vim.log.levels.ERROR
						)
						return
					end
					vim.notify(("go %s ran successfully\n%s"):format(subcmd, out.stdout), vim.log.levels.INFO)
				end)
			end, { timeout = 60000 })
		end

		vim.api.nvim_create_user_command("GoRun", function(opts)
			local args = #opts.fargs > 0 and opts.fargs or { vim.fn.expand("%") }
			go_run_async("run", args)
		end, { nargs = "*" })

		vim.api.nvim_create_user_command("GoBuild", function(opts)
			go_run_async("build", opts.fargs)
		end, { nargs = "*" })
	end,
}
