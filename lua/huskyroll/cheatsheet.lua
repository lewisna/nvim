-- :Cheatsheet — a one-screen, human-readable overview of this config's keymaps.
-- Kept as a hand-written summary grouped by category; the live source of truth
-- for every mapping is which-key (press <leader>) or :Telescope keymaps (<leader>fk).

local lines = {
    "# Keymap Cheatsheet",
    "",
    "(leader = <space>)   Press q or <Esc> to close this window.",
    "",
    "## Files",
    "  <leader>pv    Open file explorer (netrw)",
    "",
    "## Find (Telescope)",
    "  <leader>ff    Find files",
    "  <leader>fg    Live grep",
    "  <leader>fk    Search keymaps",
    "",
    "## Harpoon",
    "  <leader>a     Add file to harpoon list",
    "  <C-e>         Toggle harpoon quick menu",
    "  <C-h/t/n/s>   Go to harpoon file 1/2/3/4",
    "  <C-S-p>       Previous harpoon file",
    "  <C-S-n>       Next harpoon file",
    "  <C-S-v>       (in menu) open selected file in vsplit",
    "  <C-x>         (in menu) open selected file in split",
    "",
    "## LSP",
    "  K             Hover docs",
    "  <leader>gd    Go to definition",
    "  <leader>gr    List references",
    "  <leader>ca    Code action",
    "  <leader>rn    Rename symbol",
    "  <leader>gf    Format buffer",
    "",
    "## Tests (neotest)",
    "  <leader>tc    Run nearest test",
    "  <leader>tf    Run tests in file",
    "  <leader>ts    Run tests in suite (cwd)",
    "",
    "## Trouble (diagnostics)",
    "  <leader>tt    Toggle diagnostics list",
    "  <leader>[t    Previous item",
    "  <leader>]t    Next item",
    "",
    "## Debug (nvim-dap)",
    "  <leader>dt    Toggle breakpoint",
    "  <leader>dc    Continue",
    "",
    "## Snippets (LuaSnip)",
    "  <C-l>         Jump forward",
    "  <C-j>         Jump backward",
    "  <C-S-e>       Change snippet choice",
    "",
    "## AI (Codeium)",
    "  <S-Space>     Next completion",
    "  <M-Space>     Previous completion",
    "  X (insert)    Clear suggestion",
}

local function open_cheatsheet()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].filetype = "markdown"
    vim.bo[buf].modifiable = false
    vim.bo[buf].bufhidden = "wipe"

    local width = math.min(70, math.floor(vim.o.columns * 0.8))
    local height = math.min(#lines + 2, math.floor(vim.o.lines * 0.8))

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        style = "minimal",
        border = "rounded",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
    })
    vim.wo[win].wrap = false

    local close_opts = { buffer = buf, silent = true, desc = "Close cheatsheet" }
    vim.keymap.set("n", "q", "<cmd>close<CR>", close_opts)
    vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", close_opts)
end

vim.api.nvim_create_user_command("Cheatsheet", open_cheatsheet, {
    desc = "Open a human-readable keymap cheatsheet",
})

vim.keymap.set("n", "<leader>?", open_cheatsheet, { desc = "Open keymap cheatsheet" })
