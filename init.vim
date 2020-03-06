if &compatible
    set nocompatible  " Be iMproved
endif

" Required:
set runtimepath+=/home/ed/.config/nvim/dein-cache/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/ed/.config/nvim/dein-cache')
    call dein#begin('/home/ed/.config/nvim/dein-cache')

    " Let dein manage dein
    " Required:
    call dein#add('/home/ed/.config/nvim/dein-cache/repos/github.com/Shougo/dein.vim')

    " Gutentags.
    call dein#add('ludovicchabant/vim-gutentags')

    " GLSL highlighting, it's so nice to have.
    call dein#add('tikhomirov/vim-glsl')

    " Better highlighting
    call dein#add('https://github.com/KeitaNakamura/highlighter.nvim')

    " Git gutter
    call dein#add('airblade/vim-gitgutter')

    " Fugitiv
    " call dein#add('https://github.com/tpope/vim-fugitive.git')

    " Goyo
    call dein#add('https://github.com/junegunn/goyo.vim')

    " Rust-lang
    call dein#add('rust-lang/rust.vim')

    call dein#add('rhysd/vim-clang-format')

    " Hands down best plugin I have
    call dein#add('junegunn/fzf.vim')

    " Better dimming
    call dein#add('jeffkreeftmeijer/vim-dim')

    " Airline
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    call dein#add('suan/vim-instant-markdown')

    " Required:
    call dein#end()
    call dein#save_state()
endif


" Git gutter
set updatetime=150

" nnoremap cf :<C-u>ClangFormat<CR>
let g:clang_format#style_options = {
            \ "BraceWrapping" : {
            \   "AfterClass" : "true",
            \   "AfterControlStatement" : "true",
            \   "AfterEnum" : "true",
            \   "AfterFunction" : "true",
            \   "AfterNamespace" : "true",
            \   "AfterObjCDeclaration" : "false",
            \   "AfterStruct" : "true",
            \   "AfterUnion" : "true",
            \   "AfterExternBlock" : "true",
            \   "BeforeCatch" : "true",
            \   "BeforeElse" : "true"
            \ },
            \ "AllowShortIfStatementsOnASingleLine": "true",
            \ "AllowShortLoopsOnASingleLine": "true",
            \ "SortIncludes": "false",
            \ "SpaceAfterCStyleCast": "true",
            \ "TabWidth": "4"}


let g:airline_powerline_fonts = 0
let g:airline_skip_empty_sections = 1
let g:airline_detect_spelllang = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_theme='murmur'

"let g:python_support_python2_require = 0
"let g:gutentags_ctags_exclude = ['res/**/*', 'inc/**/*', 'bin/**/*', 'tmp/**/*']
let g:gutentags_ctags_extra_args = ['-R', '--exclude=res', '--exclude=bin', '--exclude=inc', '--exclude=.git']
let g:gutentags_cache_dir = "~/.config/nvim/tag_files"

nnoremap <F3> <ESC>:vert new<CR><C-o>:term python -i %<CR>a
nnoremap <F5> <ESC>:make<CR>
nnoremap <F6> <ESC>:make run<CR>
nnoremap <F7> <ESC>:vert new<CR><C-o>:term pycodestyle %<CR>a<C-d>

let g:fzf_buffers_jump = 1

set path=src/
set path+=src/**/*
nnoremap <C-g> <ESC>:vimgrep // src/**/*<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nnoremap <C-f> <ESC>:GFiles src<CR>
nnoremap <C-f> <ESC>:Files<CR>
nnoremap <C-b> <ESC>:Buffers<CR>
nnoremap <C-n> <ESC>:Tags<CR>
nnoremap <C-q> <ESC>:Lines<CR>
"nnoremap <C-m> <ESC>:Marks<CR>
nnoremap <C-w><C-n> <ESC>:vert new<CR>
nnoremap <C-s> :update<CR>
inoremap <C-s> <ESC>:update<CR>i
tnoremap <C-C> <C-\><C-n>

if dein#check_install()
    call dein#install()
endif

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

colorscheme default

" Theme tweaks
autocmd FileType rust,html,c,cpp,java,python autocmd BufWritePre <buffer> %s/\s\+$//e
hi LineNr ctermbg=Black


" I always want my spell checker to be on, I am a notoriously bad speller.
set nospell
