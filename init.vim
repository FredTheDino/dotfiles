if &compatible
    set nocompatible  " Be iMproved
endif

let mapleader = " "

call plug#begin('~/.config/nvim/plugged')

" GLSL highlighting, it's so nice to have.
Plug 'tikhomirov/vim-glsl'

" Fugitiv
Plug 'https://github.com/tpope/vim-fugitive.git'

" Goyo
" Plug 'https://github.com/junegunn/goyo.vim'
" Rust-lang
Plug 'rust-lang/rust.vim'

" Plug 'rhysd/vim-clang-format'
" Plug 'leafo/moonscript-vim'
" Sylt!!!
Plug 'FredTheDino/sylt.vim'

" Language server
"  - The linter didn't use the flags I provided, and
"       was slow to reload, don't really want to go back.
Plug 'dense-analysis/ale'

let g:ale_disable_lsp = 1
let g:ale_sign_column_always = 1
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Hands down best plugin I have
Plug 'junegunn/fzf.vim'

" Better dimming
Plug 'jeffkreeftmeijer/vim-dim'

Plug 'rhysd/rust-doc.vim'

call plug#end()

colorscheme dim

let g:clang_format#style_options = 'file'
" autocmd FileType c,cpp ClangFormatAutoEnable

" let g:ale_sign_error = '>>'
" let g:ale_sign_warning = '--'
" let g:ale_hover_cursor = 0

" Leave this traling whitespace alone.
nnoremap <F8> <ESC>:!ctags -R 
nnoremap <F3> <ESC>:vert new<CR><C-o>:term python -i %<CR>a
nnoremap <F5> <ESC>:make<CR>
nnoremap <F6> <ESC>:make run<CR>
nnoremap <F7> <ESC>:vert new<CR><C-o>:term pycodestyle %<CR>a<C-d>

let g:fzf_buffers_jump = 0

" Gives you a local vimrc
set exrc
set secure

set path=src/
set path+=src/**/*
nnoremap <C-g> <ESC>:grep  src/**/*<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nnoremap <C-f> <ESC>:GFiles src<CR>
nnoremap gd <ESC>:ALEGoToDefinition<CR>
nnoremap gD <ESC>:ALEFindReferences<CR>
nnoremap <C-b> <ESC>:Buffers<CR>
nnoremap <C-n> <ESC>:Tags<CR>
nnoremap <C-q> <ESC>:Lines<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-'> <ESC>:Marks<CR>
nnoremap <C-w><C-n> <ESC>:vert new<CR>
nnoremap <C-w>m <ESC><C-w>_<C-w>|
nnoremap <C-s> :update<CR>
inoremap <C-s> <ESC>:update<CR>i
tnoremap <C-C> <C-\><C-n>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set scrolloff=5

set inccommand=split

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
autocmd FileType rust,html,c,cpp,java,python autocmd BufWritePre <buffer> %s/\s\+$//e
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

" Time is given in MS
call ClearBreak()

" To stop the nagging bitches
highlight SpellBad            ctermfg=0
highlight StatusLine          cterm=bold    ctermfg=16 ctermbg=13
highlight StatusLineNC        cterm=inverse ctermfg=16 ctermbg=13
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

" Git gutter
set updatetime=150
hi GitGutterAdd    ctermfg=2
hi GitGutterChange ctermfg=3
hi GitGutterDelete ctermfg=1

" Why does this have to be here? I don't know, if you place it further up it
" doesn't work...
hi SignColumn cterm=NONE ctermbg=0 ctermfg=0
