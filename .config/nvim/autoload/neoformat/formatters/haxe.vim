function! neoformat#formatters#haxe#enabled() abort
  return [ 'haxeformat' ]
endfunction

function! neoformat#formatters#haxe#haxeformat() abort
  return {
      \ 'exe': 'haxelib',
      \ 'args': ['run', 'formatter', '--stdin', '--source', '"%:p"'],
      \ 'stdin': 1,
      \ }
endfunction

