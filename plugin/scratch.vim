" scratch.vim - Create scratch files from Vim.
" Maintainer:   Aliou Diallo <https://aliou.me>
" Version:      0.4.0

if exists('g:loaded_scratch') || &cp
  finish
endif
let g:loaded_scratch = 1

function! s:VisualScratch(...)
  " Store previous content of register `z`.
  let old_z = @z

  if len(a:000) >= 1
    let filetype = a:1
  else
    let filetype = ''
  endif

  " Yank visually selected content into register `z`.
  normal! gv"zy

  " Open scratch file with filetype and content.
  call s:Scratch(filetype, @z)

  " Restore original content of register `z`.
  let @z = old_z
endfunction

function! s:NormalScratch(...)
  if len(a:000) >= 1
    let filetype = a:1
  else
    let filetype = ''
  endif

  call s:Scratch(filetype)
endfunction

function! s:Scratch(filetype, ...)
  " Open with 10 lines.
  execute '10 new '

  " Set the filetype to the one given if present.
  execute 'set filetype=' . a:filetype

  " Disable text width.
  execute 'setlocal tw=0'

  " Fix window height.
  execute 'set winfixheight'

  " Prevent writing the file to disk
  execute 'set buftype=nofile'

  if a:0 == 1
    call append(line('.'), split(a:1, "\n"))
    normal gg"_dd
  endif
endfunction

command! -nargs=? Scratch call s:NormalScratch(<f-args>)
command! -range=% -nargs=? VScratch call s:VisualScratch(<f-args>)
