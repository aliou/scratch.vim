" scratch.vim - Create scratch files from Vim.
" Maintainer:   Aliou Diallo <https://aliou.me>
" Version:      1.0

if exists('g:loaded_scratch') || &cp
  finish
endif
let g:loaded_scratch = 1

function! s:CreateScratchFile()
  let scratch_filename = tempname()
  execute "badd " . scratch_filename

  return scratch_filename
endfunction

function! s:PreviewScratch(...)
  if a:0 == 1
    let filetype = a:1
  endif

  let scratch_filename = s:CreateScratchFile()

  " Cheating by opening a small vertical split instead of a preview window.
  execute "10 new " . scratch_filename
  execute "set ft=" . filetype
endfunction

" TODO: Use a default filetype.
function! s:Scratch(...)
  if a:0 == 1
    let filetype = a:1
  else
    let filetype = ""
  endif

  let scratch_filename = s:CreateScratchFile()

  execute "vnew " . scratch_filename
  execute "set ft=" . filetype
endfunction

" TODO: Add filetype completion.
function! s:Filetypes()
endfunction

command! -nargs=? PScratch call s:PreviewScratch(<f-args>)
command! -nargs=? PreviewScratch call s:PreviewScratch(<f-args>)
command! -nargs=? Scratch call s:Scratch(<f-args>)
