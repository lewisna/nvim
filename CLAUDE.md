# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal NeoVim configuration (Lua), plugin-managed via lazy.nvim.

## Commands

There is no build/test/lint pipeline in this repo — it's config, validated by loading it in Neovim itself.

- Apply changes: open/restart Neovim, or `:source %` on the edited file, or `:Lazy reload <plugin>`.
- Manage plugins: `:Lazy` (open UI), `:Lazy sync` (install/update/clean), `:Lazy log`.
- Check LSP/formatter/linter tool installs: `:Mason`.
- Check for Lua errors/config issues: `:checkhealth`.
- Lua diagnostics assume a global `vim` (see `.luarc.json`) — if using `lua-language-server`/`stylua` locally, no other config is needed.
- Formatting: `stylua` formats `*.lua` files (wired in as a null-ls formatting source, see `plugins/none-ls.lua`); some files use tabs, others spaces — match the surrounding file rather than assuming one style repo-wide.

## Architecture

Entry point chain: `init.lua` → `lua/huskyroll/init.lua` → requires `set` (options), `remap` (keymaps), `cheatsheet` (`:Cheatsheet` / `<leader>?` keymap overview), then `lazy_init` (bootstraps lazy.nvim and loads the plugin spec).

Plugin loading: `lazy_init.lua` calls `require("lazy").setup({ spec = "huskyroll.plugins" })`. This makes lazy.nvim import both `lua/huskyroll/plugins.lua` (currently an empty spec table) *and* every file under `lua/huskyroll/plugins/*.lua` as plugin specs — this is the mechanism, not two unrelated things. **New plugins go in their own file under `lua/huskyroll/plugins/`**, not in `plugins.lua`.

Each file under `plugins/` returns one lazy.nvim plugin spec (or a list of specs) and is self-contained: plugin declaration, `opts`/`config` setup function, and any keymaps specific to that plugin all live together (e.g. LSP keymaps are set inside `plugins/lsp-config.lua`'s `config`, not in `remap.lua`). `remap.lua` only holds global keymaps not tied to a specific plugin.

Key plugin files and their role:
- `plugins/lsp-config.lua` — mason.nvim + mason-lspconfig (v2, native `vim.lsp.config`/`vim.lsp.enable`) + nvim-lspconfig; per-language server setup (`lua_ls`, `gopls`, `pyright`, `ts_ls`, `html`) via `LspAttach` keymaps. `ensure_installed`/`automatic_enable` are both scoped to the same explicit server list — don't let one drift from the other, or mason-lspconfig will auto-enable *every* installed mason package instead of just these five.
- `plugins/completions.lua` — blink.cmp (LSP/path/snippet/buffer sources) + LuaSnip + autopairs.
- `plugins/none-ls.lua` — null-ls.nvim; formatting/diagnostics sources (stylua, gofmt, goimports_reviser, flake8, isort, eslint, actionlint) plus the `<leader>gf` format keymap.
- `plugins/gopher.lua`, `plugins/neotest.lua`, `plugins/debugging.lua` — Go tooling, test runner, and DAP debugging integrations. gopher.lua uses upstream `olexsmir/gopher.nvim` (not the old huskyroll fork) and defines async `:GoRun` / `:GoBuild` on top of it.
- `plugins/telescope.lua`, `plugins/neotree.lua`, `plugins/harpoon.lua`, `plugins/trouble.lua` — fuzzy finding, file tree, buffer/mark navigation, diagnostics list.
- `plugins/treesitter.lua`, `plugins/colors.lua`, `plugins/lualine.lua` — syntax highlighting, colorscheme, statusline.
- `plugins/ai.lua` — `Exafunction/windsurf.vim` (the plugin still exposes `codeium#...` functions, so keymaps call those). copilot.vim and the `CODEIUM_URL`/`CODEIUM_URL_API` server override were removed; don't reintroduce env-var dependencies for it.
- `plugins/which-key.lua` + `cheatsheet.lua` — keymap discovery. **Every `vim.keymap.set` should pass a `desc`** so which-key and `:Telescope keymaps` can show it; when adding or changing a keymap, update the matching line in `cheatsheet.lua` too.

`lazy-lock.json` pins exact plugin commit versions; it's updated automatically by `:Lazy sync`/`:Lazy update` — don't hand-edit it.

Leader key is `<space>` (set in `remap.lua`).
