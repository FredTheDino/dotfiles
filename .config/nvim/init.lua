local function gh(src)
	return "https://github.com/" .. src
end
local function cb(src)
	return "https://codeberg.org/" .. src
end

vim.pack.add({
	gh("tpope/vim-fugitive"),
	gh("tpope/vim-repeat"),
	gh("tpope/vim-surround"),
	gh("tpope/vim-dispatch"),
	gh("tpope/vim-sensible"),
	gh("tpope/vim-eunuch"),
	gh("tpope/vim-speeddating"),

	gh("stevearc/oil.nvim"),
	gh("rmagatti/auto-session"),
	gh("catgoose/nvim-colorizer.lua"),
	cb("andyg/leap.nvim"),

	{ src = gh("catppuccin/nvim"), name = "catppuccin" },
	gh("ribru17/bamboo.nvim"),
	gh("jeffkreeftmeijer/vim-dim"),
	gh("ronny/birds-of-paradise.vim"),
	gh("EdenEast/nightfox.nvim"),
	gh("shaunsingh/seoul256.nvim"), -- no highlight in search
	gh("bluz71/vim-moonfly-colors"),
	gh("neanias/everforest-nvim"),
	gh("ellisonleao/gruvbox.nvim"),

	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-telescope/telescope-fzf-native.nvim"),
	gh("rafcamlet/nvim-luapad"),
	gh("stevearc/conform.nvim"),
})

vim.g.maplocalleader = ";"
vim.o.spelllang = "en_us"
vim.o.wrap = true
vim.o.inccommand = "split"
vim.o.scrolloff = 7
vim.o.tabstop = 2
vim.o.shiftwidth = vim.o.tabstop
vim.o.softtabstop = 0
vim.o.expandtab = true
vim.o.laststatus = 2
vim.o.number = true
vim.o.mouse = ""
vim.o.breakindent = true
vim.o.linebreak = true
vim.o.undofile = true
vim.o.exrc = true
vim.o.cmdheight = 0

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 100 })
	end,
})

vim.keymap.set({ "n", "x", "o" }, "<space>s", "<Plug>(leap-anywhere)")

require("catppuccin").setup({
	flavour = "macchiato",
	background = { light = "latte", dark = "mocha" },
	color_overrides = {
		all = {
			base = "#110011",
			mantle = "#110011",
			crust = "#110011",
		},
	},
})
require("gruvbox").setup({ contrast = "hard" })
vim.cmd.colorscheme("catppuccin")

require("colorizer").setup()

require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>")

require("auto-session").setup()

vim.keymap.set({ "n" }, "<space>g", '<cmd>Telescope live_grep search_dirs=["lib/","src/","tests/","crates/"]<CR>')
vim.keymap.set({ "n" }, "<space>f", "<cmd>Telescope git_files<cr>")
vim.keymap.set({ "n" }, "<space>F", "<cmd>Telescope find_files<cr>")
vim.keymap.set({ "n" }, "<space>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set({ "n" }, "<space>n", "<cmd>Telescope tags<cr>")
vim.keymap.set({ "n" }, "<space>w", "<cmd>Telescope diagnostics<cr>")
vim.keymap.set({ "n" }, "<space>o", "<cmd>Telescope git_branches<cr>")
vim.keymap.set({ "n" }, "<space>'", "<cmd>Telescope marks<cr>")
vim.keymap.set({ "n" }, "<space>?", "<cmd>Telescope keymaps<CR>")
vim.keymap.set({ "n" }, "<space>t", "<cmd>Telescope<CR>")
vim.keymap.set({ "n" }, "<c-space>", function()
	require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>"), word_match = "-w" })
end)

local opts = {}
vim.keymap.set({ "n" }, "<space><space>", vim.lsp.buf.hover, opts)
vim.keymap.set({ "n" }, "<space>a", vim.lsp.buf.code_action, opts)
vim.keymap.set({ "n" }, "<space>d", vim.lsp.buf.definition, opts)
vim.keymap.set({ "n" }, "<space>u", vim.lsp.buf.references, opts)
vim.keymap.set({ "n" }, "<space>c", vim.lsp.buf.incoming_calls, opts)
vim.keymap.set({ "n" }, "<space>r", vim.lsp.buf.rename, opts)
vim.keymap.set({ "n" }, "<space>e", vim.diagnostic.open_float, opts)

vim.keymap.set({ "n" }, "<space><home>", "<cmd>e $MYVIMRC<CR>")
vim.keymap.set({ "n" }, "<C-s>", "<cmd>update<CR>")

local conform = require("conform")
conform.formatters_by_ft = {
	lua = { "stylua" },
}

vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	root_markers = { ".git" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				library = { vim.env.VIMRUNTIME .. "/lua" },
			},
		},
	},
}

vim.lsp.enable("lua_ls")
vim.lsp.codelens.enable = true
vim.lsp.inlay_hint.enable = true

vim.api.nvim_create_user_command("LspInfo", function()
	vim.cmd("checkhealth vim.lsp")
end, { desc = "How is the LSP feeling?" })

vim.api.nvim_create_user_command("LspLog", function()
	vim.cmd("tabnew | e /home/ed/.local/state/nvim/lsp.log | normal GG")
end, { desc = "Show the LSP log" })

vim.api.nvim_create_user_command("Neoformat", function()
	conform.format()
end, { desc = "Format current buffer" })
