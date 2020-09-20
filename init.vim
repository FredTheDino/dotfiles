if &compatible
    set nocompatible  " Be iMproved
endif

call plug#begin('~/.config/nvim/plugged')

" GLSL highlighting, it's so nice to have.
Plug 'tikhomirov/vim-glsl'

" Better highlighting
Plug 'https://github.com/KeitaNakamura/highlighter.nvim'

" Fugitiv
Plug 'https://github.com/tpope/vim-fugitive.git'

" Goyo
Plug 'https://github.com/junegunn/goyo.vim'

" Rust-lang
Plug 'rust-lang/rust.vim'

Plug 'rhysd/vim-clang-format'

" Language server
Plug 'dense-analysis/ale'

" Hands down best plugin I have
Plug 'junegunn/fzf.vim'

" Better dimming
Plug 'jeffkreeftmeijer/vim-dim'

Plug 'xolox/vim-misc'

call plug#end()

colorscheme dim

let g:clang_format#style_options = 'file'
autocmd FileType c,cpp ClangFormatAutoEnable

let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'

" Leave this traling whitespace alone.
nnoremap <F8> <ESC>:!ctags -R 
nnoremap <F3> <ESC>:vert new<CR><C-o>:term python -i %<CR>a
nnoremap <F5> <ESC>:make<CR>
nnoremap <F6> <ESC>:make run<CR>
nnoremap <F7> <ESC>:vert new<CR><C-o>:term pycodestyle %<CR>a<C-d>

let g:fzf_buffers_jump = 1

" Gives you a local vimrc
set exrc
set secure

set path=src/
set path+=src/**/*
nnoremap <C-g> <ESC>:grep  src/**/*<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nnoremap <C-f> <ESC>:GFiles src<CR>
" nnoremap <C-f> <ESC>:Files<CR>
nnoremap <C-b> <ESC>:Buffers<CR>
nnoremap <C-n> <ESC>:Tags<CR>
nnoremap <C-q> <ESC>:Lines<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-'> <ESC>:Marks<CR>
nnoremap <C-w><C-n> <ESC>:vert new<CR>
nnoremap <C-s> :update<CR>
inoremap <C-s> <ESC>:update<CR>i
tnoremap <C-C> <C-\><C-n>

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

highlight StatusLine          cterm=bold    ctermfg=16 ctermbg=13
highlight StatusLineNC        cterm=inverse ctermfg=16 ctermbg=13
set statusline=
" Left side
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
