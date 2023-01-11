if &compatible
    set nocompatible  " Be iMproved
endif

let mapleader = " "

call plug#begin('~/.config/nvim/plugged')

" GLSL highlighting, it's so nice to have.
Plug 'tikhomirov/vim-glsl'

" Fugitiv
Plug 'https://github.com/tpope/vim-fugitive.git'

Plug 'https://github.com/skanehira/vsession.git'

" Goyo
" Plug 'https://github.com/junegunn/goyo.vim'
" Rust-lang
Plug 'rust-lang/rust.vim'

" Plug 'rhysd/vim-clang-format'
" Plug 'leafo/moonscript-vim'
" Sylt!!!
Plug 'FredTheDino/sylt.vim'

" " Language server
" "  - The linter didn't use the flags I provided, and
" "       was slow to reload, don't really want to go back.
" Plug 'dense-analysis/ale'
" 
" let g:ale_disable_lsp = 1
" let g:ale_sign_column_always = 1
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'

" To minimize distractions
Plug 'junegunn/goyo.vim'

" Hands down best plugin I have
" Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Better dimming
Plug 'jeffkreeftmeijer/vim-dim'

Plug 'rhysd/rust-doc.vim'

Plug 'elixir-editors/vim-elixir'

Plug 'purescript-contrib/purescript-vim'

Plug 'sbdchd/neoformat'

Plug 'vimwiki/vimwiki'

Plug 'sainnhe/everforest'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

Plug 'itchyny/lightline.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Plug 'easymotion/vim-easymotion'

Plug 'mbbill/undotree'

call plug#end()

lua << EOF
local nvim_lsp = require'lspconfig'
nvim_lsp.elixirls.setup{
    cmd = { "/home/ed/Apps/elixir-ls/language_server.sh" };
}
nvim_lsp.purescriptls.setup {
  on_attach = on_attach,
  settings = {
    purescript = {
      addSpagoSources = true -- e.g. any purescript language-server config here
    }
  },
  flags = {
    debounce_text_changes = 50,
  }
}

require("trouble").setup {
}

nvim_lsp.rust_analyzer.setup{}
nvim_lsp.clangd.setup{}
nvim_lsp.jedi_language_server.setup{}
nvim_lsp.elmls.setup{}
nvim_lsp.texlab.setup{}
nvim_lsp.hls.setup{}


local actions = require('telescope.actions')require('telescope').setup{
  pickers = {
    buffers = {
      sort_lastused = true
    }
  }
}
EOF

lua <<EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.haskell = {
  install_info = {
    url = "~/Code/tree-sitter-haskell/",
    files = {"src/parser.c", "src/scanner.c"}
  }
}
EOF

let g:purescript_disable_indent = 1

set omnifunc=v:lua.vim.lsp.omnifunc


" let g:clang_format#style_options = 'file'
" autocmd FileType c,cpp ClangFormatAutoEnable
let g:neoformat_enabled_purescript = ['purstidy']
let g:neoformat_enabled_haskell = ['ormolu']
"augroup fmt
"  autocmd!
"  autocmd BufWritePre * undojoin | Neoformat
"augroup END

set undodir=~/.config/nvim/undo-dir
set undofile

" Leave this traling whitespace alone.
nnoremap <F8> <ESC>:!ctags -R 
nnoremap gp <ESC>:vert new<CR><C-o>:term python -i %<CR>a
nnoremap <F5> <ESC>:make<CR>
nnoremap <F6> <ESC>:make run<CR>
nnoremap <F7> <ESC>:vert new<CR><C-o>:term pycodestyle %<CR>a<C-d>

let g:fzf_buffers_jump = 0
let g:fzf_preview_window = []

set termguicolors
set background=dark
let g:everforest_background = 'hard'
set guifont=FiraCode\ Nerd\ Font:h10
colorscheme everforest
let g:lightline = {
      \ 'colorscheme': 'everforest',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }


" Gives you a local vimrc
set exrc
set secure

set showbreak=\ \ \ \ \ \ \ \ \ \ \ \|\ 
" set clipboard=unnamedplus

set path=src/
set path+=src/**/*
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <C-g> <cmd>Telescope live_grep<CR>
nnoremap <C-f> <cmd>Telescope find_files<CR>
nnoremap <C-b> <cmd>Telescope buffers<CR>
nnoremap <C-n> <cmd>Telescope tags<CR>
nnoremap <C-h> <cmd>Telescope grep_string<CR>
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

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! ToggleSpell()
    if (&spell)
        setlocal nospell
    else
        setlocal spell
    endif
endfunction

" File rename
function! MoveFile(newspec)
    let old = expand('%')
    " could be improved:
    if (old == a:newspec)
        return 0
    endif
    exe 'sav' fnameescape(a:newspec)
    call delete(old)
endfunction

command! -nargs=1 -complete=file -bar MoveFile call MoveFile('<args>')


" Required:
filetype plugin indent on
syntax enable
set hidden
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set scrolloff=7

set inccommand=split
set title

" Or map each action separately
" nmap <silent> K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> <F9> <Plug>(lcn-menu)
nmap <silent> <F10> <Plug>(lcn-rename)

set smartcase
set ignorecase

augroup colorschemegroup
    autocmd!
    " autocmd ColorScheme * hi SpellBad clear
    autocmd ColorScheme * hi SpellBad cterm=underline,inverse 
augroup END

" Theme tweaks
autocmd FileType purescript,elixir,lua,rust,html,c,cpp,java,python,sy autocmd BufWritePre <buffer> %s/\s\+$//e
hi LineNr ctermbg=Black ctermfg=7

function ShowFileFormatFlag(var)
  if ( a:var == 'dos' )
    return '[dos]'
  elseif ( a:var == 'mac' )
    return '[mac]'
  else
    return ''
  endif
endfunction

let g:breaktime = 0
function ShowBreakStatus()
    if g:breaktime < 10
        return ''
    elseif g:breaktime < 20
        return '=B='
    elseif g:breaktime < 21
        return '=BR='
    elseif g:breaktime < 22
        return '=BRE='
    elseif g:breaktime < 23
        return '=BREAK='
    elseif g:breaktime < 25
        return '=BREAK='
    else
        return '=' . g:breaktime . '='
    endif
endfunction

function EndOfBreak(timer)
    let g:breaktime += 1
endfunction

function ClearBreak()
    let g:breaktime = 0
    echomsg 'Break timer cleared'
endfunction

function TimeSinceBreak()
    echo 'Minutes since break: ' . g:breaktime
endfunction

nnoremap <Leader>? :call TimeSinceBreak()<CR>
nnoremap <Leader>b :call ClearBreak()<CR>

call timer_start(60 * 1000, 'EndOfBreak', { 'repeat': -1 })

let wiki = {}
let wiki.path = '~/vimwiki/'
let wiki.template_path = '~/vimwiki/templates/'
let wiki.template_default = 'math'
let wiki.template_ext = '.html'

let lesslie = {}
let lesslie.path = '~/Lesslie/docs/'
let lesslie.syntax = 'markdown'
let lesslie.ext = 'md'

let g:vimwiki_list = [wiki, lesslie]

" Time is given in MS
call ClearBreak()

" To stop the nagging bitches
highlight SpellBad            ctermfg=0
highlight StatusLine          cterm=bold    ctermfg=16 ctermbg=13
highlight StatusLineNC        cterm=inverse ctermfg=16 ctermbg=13
highlight Conceal             ctermbg=8

set statusline=
" Left side
set statusline+=%{ShowBreakStatus()}
set statusline+=%(%m%r%)
set statusline+=%{ShowFileFormatFlag(&fileformat)}
set statusline+=%(%q%h%)
set statusline+=%y
set statusline+=%=
" Middle section
set statusline+=%f
set statusline+=%=
" Right side
set statusline+=%c\ %03(%l%)/%-3(%L%)\ 
set statusline+=%{FugitiveHead(5)}\ 
set statusline+=%{ShowBreakStatus()}

" I always want my spell checker to be on, I am a notoriously bad speller... 
set nospell spelllang=en_us
set wrap
set linebreak
set number

" Git gutter
set updatetime=150
hi GitGutterAdd    ctermfg=2
hi GitGutterChange ctermfg=3
hi GitGutterDelete ctermfg=1

" Why does this have to be here? I don't know, if you place it further up it
" doesn't work...
hi SignColumn cterm=NONE ctermbg=0 ctermfg=0
