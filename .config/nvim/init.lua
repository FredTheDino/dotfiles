local function plugins()
  local Plug = vim.fn["plug#"]
  vim.call("plug#begin", "~/.config/nvim/plugged")
  do
    Plug("tpope/vim-fugitive")
    Plug("tpope/vim-repeat")
    Plug("tpope/vim-obsession")
    Plug("tpope/vim-dispatch")
    Plug("tpope/vim-vinegar")

    Plug("folke/noice.nvim")
    Plug("MunifTanjim/nui.nvim")
    Plug("lukas-reineke/indent-blankline.nvim", { as = "ibl" } )

    -- Language extensions
    Plug("FredTheDino/sylt.vim")
    Plug("elixir-editors/vim-elixir")
    Plug("purescript-contrib/purescript-vim")
    Plug("rhysd/rust-doc.vim")
    Plug("rust-lang/rust.vim")
    Plug("tikhomirov/vim-glsl")
    Plug("terrastruct/d2-vim")
    Plug("sputnick1124/uiua.vim")
    Plug("S1M0N38/love2d.nvim")
    Plug("kaarmu/typst.vim")
    Plug("nvim-treesitter/nvim-treesitter")

    Plug("ggandor/leap.nvim")

    Plug("mfussenegger/nvim-dap")
    Plug("nvim-neotest/nvim-nio")
    Plug("rcarriga/nvim-dap-ui")

    Plug("ribru17/bamboo.nvim")
    Plug("folke/tokyonight.nvim")
    Plug("jeffkreeftmeijer/vim-dim")
    -- Plug("ronny/birds-of-paradise.vim")
    -- Plug("EdenEast/nightfox.nvim")
    Plug("catppuccin/nvim", { as="catppuccin" })
    -- Plug("ellisonleao/gruvbox.nvim")
    -- Plug("shaunsingh/seoul256.nvim"), no highlight in search
    -- Plug("bluz71/vim-moonfly-colors", { as = "moonfly" })
    Plug("neanias/everforest-nvim", { as = "everforest" })
    Plug('bluz71/vim-moonfly-colors', { as = "moonfly" })
    Plug("nvim-lualine/lualine.nvim")

    -- Core workflow
    Plug("sbdchd/neoformat")

    Plug("nvim-lua/plenary.nvim") -- Needed by telescope
    Plug("nvim-telescope/telescope.nvim")
    Plug("nvim-telescope/telescope-ui-select.nvim")
    Plug("neovim/nvim-lspconfig")
    Plug("neovim/nvim-lspconfig")
    Plug("rafcamlet/nvim-luapad")
  end
  vim.call("plug#end")
end

plugins()

require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "nim" },
  sync_install = true,
  auto_install = true,
  ignore_install = { "purescript" },
}

require("nvim-treesitter.install").prefer_git = true

local highlight = {
    "CursorColumn",
}
require("ibl").setup {
    scope = { enabled = true },
}
vim.g.maplocalleader = ';'

-- vim.lsp.log.set_level("INFO")
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})

vim.g.typst_pdf_viewer = "zathura"
vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
vim.keymap.set('n', 's', '<Plug>(leap)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

-- Color scheme
require('everforest').setup {
  background = "hard",
}
require('bamboo').setup {
  -- Main options --
  -- NOTE: to use the light theme, set `vim.o.background = 'light'`
  style = 'vulgaris',                          -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
  toggle_style_key = "<space>tt",              -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
  toggle_style_list = { 'light', 'vulgaris' }, -- List of styles to toggle between
  transparent = false,                         -- Show/hide background
  dim_inactive = true,                         -- Dim inactive windows/buffers
  term_colors = true,                          -- Change terminal color as per the selected theme style
  ending_tildes = false,                       -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false,                -- reverse item kind highlights in cmp menu

  -- Change code style ---
  -- Options are anything that can be passed to the `vim.api.nvim_set_hl` table
  -- You can also configure styles with a string, e.g. keywords = 'italic,bold'
  code_style = {
    comments = { italic = true },
    conditionals = { italic = true },
    keywords = {},
    functions = {},
    namespaces = { italic = true },
    parameters = { italic = true },
    strings = {},
    variables = {},
  },

  -- Lualine options --
  lualine = {
    transparent = false,
  },

  -- Custom Highlights --
  colors = {},
  highlights = {},

  -- Plugins Config --
  diagnostics = {
    darker = false,
    undercurl = true,
    background = true,
  },
}

-- vim.o.background = "dark"
require('tokyonight').setup {}
vim.cmd[[colorscheme bamboo]]
require('lualine').setup {
  options = {
    theme = "bamboo",
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    icons_enabled = true,
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'encoding', { 'fileformat', symbols = { unix = '', dos = 'dos', mac = 'mac' } }, 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { 'FugitiveHead', 'diff' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'encoding', { 'fileformat', symbols = { unix = '', dos = 'dos', mac = 'mac' } }, 'filetype' },
    lualine_y = {},
    lualine_z = { 'location' }
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require('telescope').setup({
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  },
  defaults = {
    layout_config = {
      -- other layout configuration here
    },
    -- other defaults configuration here
  },
})

-- Formatter configs
vim.g.neoformat_enabled_purescript = {"purstidy"}
vim.g.neoformat_enabled_haskell = { "ormolu" }
vim.g.neoformat_enabled_lua = { "lua-format" }
vim.g.neoformat_enabled_python = { "black" }
vim.g.neoformat_enabled_nim = { "nph" }


-- Vim options
vim.o.number = false
vim.o.mouse = ""
vim.o.breakindent = true
vim.o.linebreak = true
vim.o.undofile = true
vim.o.exrc = true

-- vim.o.showbreak = "|"
vim.o.wrap = true
vim.o.inccommand = "split"
vim.o.scrolloff = 7
vim.o.tabstop = 2
vim.o.shiftwidth = vim.o.tabstop
vim.o.softtabstop = 0
vim.o.expandtab = true

vim.g.clipboard = {
  name = "copyq",
  copy = {
    ['+'] = { 'wl-copy' },
    ['*'] = { 'wl-copy' },
  },
  paste = {
    ['+'] = { 'wl-paste' },
    ['*'] = { 'wl-paste' },
  },
  cache_enabled = 1,
}

vim.o.spell = false
vim.keymap.set("n", "<space>ss", function()
  vim.o.spell = not vim.o.spell
end, { noremap = true, expr = true, silent = true })
vim.o.spelllang = "en_us"

vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.updatetime = 150
vim.o.termguicolors = true

vim.g["lesslie_auto_fold"] = true

-- Custom keymap
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- TODO[et]: Should this be in a callback from the language server?

vim.api.nvim_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

function replace_text_after_cursor(cmd)
  return function()
    local to_insert = vim.fn.system(cmd):gsub("%s+$", ""):gsub("^%s", "")
    local pos = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_get_current_line()
    local nline = line:sub(0, pos[2]) .. to_insert .. line:sub(pos[2] + 1)
    vim.api.nvim_set_current_line(nline)
    pos[2] = pos[2] + string.len(to_insert)
    vim.api.nvim_win_set_cursor(0, pos)
  end
end

vim.keymap.set('n', "<SPACE>id", replace_text_after_cursor { "date", "--iso-8601=date" })
vim.keymap.set('n', "<SPACE>it", replace_text_after_cursor { "date", "--iso-8601=seconds" })

vim.cmd([[
  nnoremap <C-g> <cmd>Telescope live_grep search_dirs=["lib/","src/","tests/","crates/"]<CR>
  nnoremap <C-f> <cmd>Telescope find_files<CR>
  nnoremap <C-b> <cmd>Telescope buffers<CR>
  nnoremap <C-n> <cmd>Telescope tags<CR>
  nnoremap <C-e> <cmd>Telescope diagnostics<CR>
  " nnoremap <C-o> <cmd>Telescope git_branches<CR>
  nnoremap <C-SPACE> <cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand("<cword>"), search_dirs={"lib/", "src/", "tests/", "crates/"}, word_match="-w"})<cr>
  " nnoremap <C-q> <cmd>:Lines<CR>
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l
  nnoremap <C-'> <cmd>Telescope marks<CR>
  nnoremap <C-w><C-n> <ESC>:vert new<CR>
  nnoremap <C-w>m <ESC><C-w>_<C-w>|
  nnoremap <C-s> :update<CR>
  inoremap <C-s> <ESC>:update<CR>i
  tnoremap <C-C> <C-\><C-n>
  nnoremap <SPACE><SPACE> :lua vim.lsp.buf.hover()<CR>
  nnoremap <SPACE>a :lua vim.lsp.buf.code_action()<CR>
  nnoremap <SPACE>s :lua vim.lsp.buf.document_symbol()<CR>
  nnoremap <SPACE>S :lua vim.lsp.buf.workspace_symbol()<CR>
  nnoremap <SPACE>d :lua vim.lsp.buf.definition()<CR>
  nnoremap <SPACE>u :lua vim.lsp.buf.references()<CR>
  nnoremap <SPACE>r :lua vim.lsp.buf.rename()<CR>
  nnoremap <SPACE>c :lua vim.lsp.buf.incoming_calls()<CR>
  nnoremap <SPACE>q :lua vim.lsp.buf.format()<CR>
  inoremap <C-o> <A-k>:lua vim.lsp.buf.completion()<CR>
  nnoremap <SPACE>nn :e $MYVIMRC<CR>
  nnoremap <SPACE>tt :vnew<CR>:e ~/Sync/todo/todo.txt<CR>

  nnoremap <SPACE>p :lua require("precognition").peek()<CR>

  let g:purescript_disable_indent = 1
  let g:purescript_unicode_conceal_enable = 0
  " Sick-ass editing in command mode? :D
  " nnoremap : q:i
  au TextYankPost * silent! lua vim.highlight.on_yank()

  augroup fmt
    autocmd!
    autocmd BufWritePre *.purs undojoin | Neoformat
  augroup END

  augroup fmt
    autocmd!
    autocmd BufWritePost *.dot undojoin | !dot -Tpdf % > %.pdf
  augroup END
]])

-- Highlight on yank
vim.highlight.on_yank()

-- LSP Configs
local nvim_lsp = require("lspconfig")
nvim_lsp.fennel_ls.setup {}
nvim_lsp.rust_analyzer.setup {}
nvim_lsp.jedi_language_server.setup {}
nvim_lsp.ruff.setup {}
nvim_lsp.texlab.setup {}
nvim_lsp.hls.setup {}
nvim_lsp.elmls.setup {}
nvim_lsp.ols.setup {}
nvim_lsp.zls.setup {}
nvim_lsp.gopls.setup {}
nvim_lsp.uiua.setup {}
nvim_lsp.sylt.setup {}
nvim_lsp.hemlis.setup {}
nvim_lsp.tinymist.setup {}
nvim_lsp.nim_langserver.setup{}
nvim_lsp.nimls.setup{}


local settings = {
  Lua = {
    runtime = { version = "LuaJIT" },
    workspace = {
      checkThirdParty = false,
      library = { vim.env.VIMRUNTIME .. "/lua" },
    },
  },
}
nvim_lsp.lua_ls.setup({
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
      client.config.settings = vim.tbl_deep_extend("force", client.config.settings, settings)
    end
  end,
})

require("telescope.actions")
require("telescope").setup { pickers = { buffers = { sort_lastused = true } } }
require("telescope").load_extension("ui-select")

local love2d = require "love2d"
love2d.setup {}
