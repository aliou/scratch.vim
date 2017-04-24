" scratch.vim - Create scratch files from Vim.
" Maintainer:   Aliou Diallo <https://aliou.me>
" Version:      0.1.0

if exists('g:loaded_scratch') || &cp
  finish
endif
let g:loaded_scratch = 1

function! s:Scratch()
  let scratch_filename = tempname()

  execute '10 new ' . scratch_filename
endfunction

command! -nargs=? Scratch call s:Scratch()
