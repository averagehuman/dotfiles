
function! myspacevim#before() abort
    " move between split panes and maximise the current pane
    nnoremap <C-h> <C-w>h<C-w>_
    nnoremap <C-j> <C-w>j<C-w>_
    nnoremap <C-k> <C-w>k<C-w>_
    nnoremap <C-l> <C-w>l<C-w>_

endfunction

function! myspacevim#after() abort
    hi clear CursorLine
    hi CursorLineNR cterm=bold
endfunction
