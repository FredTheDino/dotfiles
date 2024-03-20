function plugins()
  local Plug = vim.fn["plug#"]
  vim.call("plug#begin", "~/.config/nvim/plugged")
  do
    Plug("tpope/vim-fugitive")
    -- Plug("tpope/vim-repeat")
    -- Plug("tpope/vim-surround")
    Plug("tpope/vim-obsession")
    Plug("tpope/vim-dispatch")
    -- Plug("tpope/vim-rhubarb")

    -- Language extensions
    Plug("FredTheDino/sylt.vim")
    Plug("elixir-editors/vim-elixir")
    Plug("purescript-contrib/purescript-vim")
    Plug("rhysd/rust-doc.vim")
    Plug("rust-lang/rust.vim")
    Plug("tikhomirov/vim-glsl")
    Plug("alaviss/nim.nvim")
    Plug("terrastruct/d2-vim")

    -- To minimize distractions
    Plug("junegunn/goyo.vim")

    -- Making it look good
    Plug("ribru17/bamboo.nvim")
    Plug("jeffkreeftmeijer/vim-dim")
    -- Plug("ronny/birds-of-paradise.vim")
    -- Plug("EdenEast/nightfox.nvim")
    -- Plug("catppuccin/nvim", { as="catppuccin" })
    -- Plug("ellisonleao/gruvbox.nvim")
    -- Plug("shaunsingh/seoul256.nvim"), no highlight in search
    -- Plug("bluz71/vim-moonfly-colors", { ["as"] = "moonfly" })
    -- Plug("neanias/everforest-nvim", { ["as"] = "everforest" })
    Plug("nvim-lualine/lualine.nvim")

    -- Core workflow
    Plug("neovim/nvim-lspconfig")
    Plug("sbdchd/neoformat")

    Plug("nvim-lua/plenary.nvim") -- Needed by telescope
    Plug("nvim-telescope/telescope.nvim")
    Plug("nvim-telescope/telescope-ui-select.nvim")

    -- Treesitter
    -- Plug("nvim-treesitter/nvim-treesitter")
    -- Plug("nvim-treesitter/highlight.lua")
    -- Plug("nvim-treesitter/nvim-treesitter-refactor")
    -- Plug('nvim-treesitter/playground')

    -- Under review
    Plug("rafcamlet/nvim-luapad")
    -- Plug("lukas-reineke/indent-blankline.nvim")
    -- Plug("stevearc/aerial.nvim")
    -- Plug("mvllow/modes.nvim")

    -- Plug("FredTheDino/ma-pur-ma.nvim")

    -- On thin ice
    -- Plug 'easymotion/vim-easymotion'

    -- Candidates
    -- https://github.com/dcampos/nvim-snippy
  end
  vim.call("plug#end")
end

plugins()

-- Color scheme
-- require('everforest').setup {
--   background = "hard",
-- }
vim.o.background = "dark"
require('bamboo').setup {
  -- Main options --
  -- NOTE: to use the light theme, set `vim.o.background = 'light'`
  style = 'vulgaris', -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
  toggle_style_key = "<space>tt", -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
  toggle_style_list = { 'light', 'vulgaris' }, -- List of styles to toggle between
  transparent = false, -- Show/hide background
  dim_inactive = true, -- Dim inactive windows/buffers
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

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
vim.cmd([[colorscheme bamboo]])
-- vim.cmd([[
--   hi Comment guifg=#877c6e guibg=NONE
--   hi Cursor guifg=#5e442f guibg=NONE
--   set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr:hor20,o:hor50
-- ]])

--[[
local colors = {
  blue   = '#dc9e31',
  cyan   = '#c3c05a',
  black  = '#493a35',
  white  = '#d7d2b7',
  red    = '#ef5d32',
  violet = '#6a94b5',
  grey   = '#7d7265',
}

local lua_line_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.red },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.grey, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.violet } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}
]]--

require('lualine').setup {
  options = {
    theme = "bamboo",
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
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
    lualine_a = {'mode'},
    lualine_b = {'FugitiveHead', 'diff'},
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = {'encoding', { 'fileformat', symbols = { unix = '', dos = 'dos',  mac = 'mac' } }, 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = {'encoding', { 'fileformat', symbols = { unix = '', dos = 'dos',  mac = 'mac' } }, 'filetype'},
    lualine_y = {},
    lualine_z = {'location'}
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
-- vim.g.neoformat_enabled_purescript = {"purstidy"}
vim.g.neoformat_enabled_haskell = {"ormolu"}
vim.g.neoformat_enabled_lua = {"lua-format"}

-- Vim options
vim.o.number = true
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

local xclip_clipboard_name = "clipboard"  
vim.g.clipboard = {
  name = "goodxclip",
  copy = {
    ['+'] = {'xclip', '-quiet', '-i', '-selection', xclip_clipboard_name},
    ['*'] = {'xclip', '-quiet', '-i', '-selection', xclip_clipboard_name},
  },
  paste = {
    ['+'] = {'xclip', '-o', '-selection', xclip_clipboard_name},
    ['*'] = {'xclip', '-o', '-selection', xclip_clipboard_name},
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
  nnoremap <SPACE>d :lua vim.lsp.buf.definition()<CR>
  nnoremap <SPACE>u :lua vim.lsp.buf.references()<CR>
  nnoremap <SPACE>c :lua vim.lsp.buf.incoming_calls()<CR>
  nnoremap <SPACE>nn :e $MYVIMRC<CR>

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

  autocmd bufwritepost ~/.config/kitty/kitty.conf :silent !kill -SIGUSR1 $(pgrep kitty) && notify-send "Kitty config updated"
]])

-- Highlight on yank
vim.highlight.on_yank()

-- LSP Configs
local nvim_lsp = require("lspconfig")
nvim_lsp.purescriptls.setup {
  settings = {
    purescript = {
      addSpagoSources = true,
      codegenTargets = { "erl" },
    }
  },
  flags = {debounce_text_changes = 50}
}
nvim_lsp.rust_analyzer.setup {}
nvim_lsp.jedi_language_server.setup {}
nvim_lsp.texlab.setup {}
nvim_lsp.hls.setup {}
nvim_lsp.elmls.setup {}

-- Other configs
-- require("trouble").setup {}

require("telescope.actions")
require("telescope").setup {pickers = {buffers = {sort_lastused = true}}}
require("telescope").load_extension("ui-select")

-- local mpm = require "ma-pur-ma"
-- vim.keymap.set('n', '<SPACE>pe', mpm.extract_to_function)
-- vim.keymap.set('v', '<SPACE>pe', mpm.extract_to_function)
-- vim.keymap.set('n', '<SPACE>pi', mpm.toggle_export)
-- vim.keymap.set('n', '<SPACE>pf', mpm.if_to_case)
-- vim.keymap.set('n', '<SPACE>pc', mpm.fill_in_data_case)

-- local terafox_pallet = require("nightfox.palette").load("terafox")
-- Add fancy indentation syntax
-- vim.cmd(string.format("highlight IndentBlanklineIndent1 guibg=%s gui=nocombine", terafox_pallet.bg2))
-- vim.cmd(string.format("highlight IndentBlanklineIndent2 guibg=%s gui=nocombine", terafox_pallet.bg1))
-- 
-- require("indent_blankline").setup {
--     space_char_blankline = " ",
--     show_current_context = true,
--     show_current_context_start = true,
-- }
-- require("indent_blankline").setup {
--     char = "",
--     show_current_context = true,
--     show_current_context_start = true,
--     char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--     },
--     space_char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--     },
--     show_trailing_blankline_indent = false,
-- }

-- require("indent_blankline").setup {
--     char = "|",
--     show_current_context = true,
--     show_current_context_start = true,
--     show_current_context_start = true,
--     show_trailing_blankline_indent = true,
-- }

-- require"nvim-treesitter.configs".setup {
--   ensure_installed = { "c", "lua", "rust", "cpp" },
-- 
--   -- Automatically install missing parsers when entering buffer
--   auto_install = true,
-- 
--   -- List of parsers to ignore installing (for "all")
--   ignore_install = { "javascript", "purescript" },
-- 
--   highlight = {
--     -- `false` will disable the whole extension
--     enable = true,
-- 
--     -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--     -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--     -- Using this option may slow down your editor, and you may see some duplicate highlights.
--     -- Instead of true it can also be a list of languages
--     additional_vim_regex_highlighting = false,
--   },
-- 
--   refactor = {
--     highlight_definitions = {
--       enable = true,
--       -- Set to false if you have an `updatetime` of ~100.
--       clear_on_cursor_move = true,
--     },
--     highlight_current_scope = { enable = false },
--   },
-- 
--   playground = {
--     enable = true,
--     disable = {},
--     updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
--     persist_queries = false, -- Whether the query persists across vim sessions
--     keybindings = {
--       toggle_query_editor = 'o',
--       toggle_hl_groups = 'i',
--       toggle_injected_languages = 't',
--       toggle_anonymous_nodes = 'a',
--       toggle_language_display = 'I',
--       focus_language = 'f',
--       unfocus_language = 'F',
--       update = 'R',
--       goto_node = '<cr>',
--       show_help = '?',
--     },
--   },
-- }

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.purescript = {
--     install_info = {
--       url = "https://github.com/Maskhjarna/tree-sitter-purescript",
--       files = {"src/parser.c", "src/scanner.c"}, 
--       branch = "main",
--     },
--     filetype = "purescript", -- if filetype does not match the parser name
-- }
-- vim.treesitter.language.register('purescript', 'mask_purescript')
