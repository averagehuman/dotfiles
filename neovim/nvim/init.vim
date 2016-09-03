
set nosplitbelow         " new split window is always on top
set winwidth=130
set winminwidth=30
set winheight=999
set scrolloff=4          " keep 4 lines when scrolling
set visualbell t_vb=     " disable horrible beep when a command doesn't work
set tabstop=4            " how many spaces for a tab
set shiftwidth=4
set expandtab
set wildmode=list,longest,full

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
" if &listchars ==# 'eol:$'
"   set listchars=\ ,trail:-
" endif
" set list                " Show problematic characters.

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

set colorcolumn=120
highlight ColorColumn ctermbg=9

let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

if &t_Co > 1
   syntax enable
endif

set background=dark
colorscheme molokai

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
Plug 'tpope/vim-fugitive'
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
Plug 'pangloss/vim-javascript'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

"let python_highlight_all = 1
"let python_highlight_space_errors = 0

" gitgutter
"let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_column_always = 1
let g:gitgutter_highlight_lines = 0

" neomake error window
let g:neomake_open_list = 0

" deoplete code completion
let g:deoplete#enable_at_startup = 1

" jedi-vim
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#use_splits_not_buffers = "top"
let g:jedi#goto_command = "<leader>g"
let g:jedi#goto_assignments_command = "<leader>ga"
let g:jedi#goto_definitions_command = "<leader>gd"
let g:jedi#usages_command = "<leader>h"
let g:jedi#rename_command = "<leader>r"
let g:jedi#documentation_command = "<leader>d"
let g:jedi#completions_command = "<C-Space>"

" airline
" let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '|'
let g:airline_theme= 'badwolf'

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

" Removes highlight of your last search
nnoremap  <leader><space>  :nohl<CR>
vnoremap  <leader><space>  :nohl<CR>

" toggle NERDTree
nnoremap <leader>t :NERDTreeToggle<cr>

" toggle Tag Browser
nnoremap <leader>b :TagbarToggle<CR>

" vim-exchange
vmap <leader>cx <Plug>(Exchange)
nmap <leader>cx <Plug>(Exchange)
vmap <leader>cc <Plug>(ExchangeLine)
nmap <leader>cc <Plug>(ExchangeLine)

autocmd FileType make setlocal noexpandtab
autocmd FileType scala setlocal ts=4 sw=4
autocmd BufWritePost * Neomake

