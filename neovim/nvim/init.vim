
set nosplitbelow         " new split window is always on top
set winwidth=130
set winminwidth=30
set winheight=999

let g:python_host_prog = expand('~/.pyenv/neovim/bin/python')
let g:python3_host_prog = expand('~/.pyenv3/neovim/bin/python')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin management using vim-plug (run :PlugInstall to install)
" (ref. http://yannesposito.com/Scratch/en/blog/Vim-as-IDE/)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob("~/.config/nvim/autoload/plug.vim"))
    execute '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'davidhalter/jedi-vim'
Plug 'neomake/neomake'
Plug 'airblade/vim-gitgutter'
Plug 'ervandew/supertab'
Plug 'othree/html5.vim'
Plug 'ensime/ensime-vim'
Plug 'derekwyatt/vim-scala'
Plug 'tommcdo/vim-exchange'
Plug 'sickill/vim-pasta'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

call plug#end()

" gitgutter
"let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_column_always = 1
let g:gitgutter_highlight_lines = 0

" neomake error window
let g:neomake_open_list = 2
" deoplete code completion
let g:deoplete#enable_at_startup = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keyboard mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
set pastetoggle=<leader>v

nnoremap ; :
vnoremap ; :
nnoremap H ^
nnoremap L $
inoremap jk <Esc>
vnoremap jk <Esc>

" move between split panes and maximise the current pane
nnoremap <C-h> <C-w>h<C-w>_
nnoremap <C-j> <C-w>j<C-w>_
nnoremap <C-k> <C-w>k<C-w>_
nnoremap <C-l> <C-w>l<C-w>_

" toggle NERDTree
nnoremap <leader>t :NERDTreeToggle<cr>

" toggle Tag Browser
nnoremap <leader>b :TagbarToggle<CR>

" vim-exchange
vmap <leader>cx <Plug>(Exchange)
nmap <leader>cx <Plug>(Exchange)
vmap <leader>cc <Plug>(ExchangeLine)
nmap <leader>cc <Plug>(ExchangeLine)

autocmd BufWritePost *.scala :EnTypeCheck

autocmd BufWritePost * Neomake

