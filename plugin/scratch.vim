" scratch.vim - Create scratch files from Vim.
" Maintainer:   Aliou Diallo <https://aliou.me>
" Version:      1.0

if exists('g:loaded_scratch') || &cp
  finish
endif
let g:loaded_scratch = 1

if !exists('g:scratch_defaut_filetype')
  let g:scratch_defaut_filetype = ""
endif

function! s:ScratchFiletype(arglist)
  if len(a:arglist) == 1
    let filetype = a:arglist[0]
  else
    let filetype = g:scratch_defaut_filetype
  endif

  return filetype
endfunction

function! s:CreateScratchFile()
  let scratch_filename = tempname()
  execute "badd " . scratch_filename

  return scratch_filename
endfunction

function! s:PreviewScratch(...)
  let scratch_filename = s:CreateScratchFile()
  let scratch_filetype = s:ScratchFiletype(a:1)

  " Cheating by opening a small vertical split instead of a preview window.
  execute "10 new " . scratch_filename
  execute "set ft=" . scratch_filetype
endfunction

function! s:Scratch(...)
  let scratch_filename = s:CreateScratchFile()
  let scratch_filetype = s:ScratchFiletype(a:000)

  execute "vnew " . scratch_filename
  execute "set ft=" . scratch_filetype
endfunction

" TODO: Add filetype completion.
function! s:Filetypes()
endfunction

command! -nargs=? PScratch call s:PreviewScratch(<f-args>)
command! -nargs=? PreviewScratch call s:PreviewScratch(<f-args>)
command! -nargs=? Scratch call s:Scratch(<f-args>)
