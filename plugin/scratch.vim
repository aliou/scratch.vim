" scratch.vim - Create scratch files from Vim.
" Maintainer:   Aliou Diallo <https://aliou.me>
" Version:      0.2.0

if exists('g:loaded_scratch') || &cp
  finish
endif
let g:loaded_scratch = 1

function! s:Scratch(...)
  let scratch_filename = tempname()
  if len(a:000) == 1
    let filetype = a:1
  else
    let filetype = ''
  endif

  execute '10 new ' . scratch_filename
  execute 'set ft=' . filetype
endfunction

command! -nargs=? Scratch call s:Scratch(<f-args>)
