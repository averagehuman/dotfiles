
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '!'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint','tslint', 'xo'],
\   'css': ['stylelint', 'fecs'],
\   'rust': ['rustfmt', 'rls'],
\}
inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" : "\<TAB>"

let g:user_emmet_leader_key='<C-/>'

let g:lightline = {
  \ 'colorscheme': 'railscasts',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ ,
  \   'right': [ [ 'lineinfo' ],
  \              ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'filename': 'LightlineFilename',
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ 'component_expand': {
  \  'linter_checking': 'lightline#ale#checking',
  \  'linter_infos': 'lightline#ale#infos',
  \  'linter_warnings': 'lightline#ale#warnings',
  \  'linter_errors': 'lightline#ale#errors',
  \  'linter_ok': 'lightline#ale#ok',
  \ },
  \ 'component_type': {
  \     'linter_checking': 'right',
  \     'linter_infos': 'right',
  \     'linter_warnings': 'warning',
  \     'linter_errors': 'error',
  \     'linter_ok': 'right',
  \ }
\ }
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

function! LightlineFilename()
    return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

let g:fzf_layout = { 'down': '~10%' }

" vim-better-whitespace
let g:show_spaces_that_precede_tabs=1

" gitgutter
let g:gitgutter_highlight_lines = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin management using vim-plug (run :PlugInstall to install)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
    execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.local/share/nvim/plugged')
  Plug 'cespare/vim-toml'
  Plug 'jiangmiao/auto-pairs'
  Plug 'dense-analysis/ale'
  Plug 'itchyny/lightline.vim'
  Plug 'maximbaz/lightline-ale'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
set history=500
filetype plugin indent on
set autoread
set laststatus=2
set noshowmode
au FocusGained,BufEnter * checktime

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set so=18
set number
set wildmenu
set ruler
set cmdheight=1
set hid
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=1
set nosplitbelow         " new split window is always on top
set scrolloff=4          " keep 4 lines when scrolling
set visualbell t_vb=     " disable horrible beep when a command doesn't work
set wildmode=list:longest,full
set signcolumn=yes
set colorcolumn=120

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set background=dark
colorscheme railscasts
set encoding=utf8
set ffs=unix,dos,mac
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight ColorColumn ctermbg=9
highlight LineNr ctermbg=black ctermfg=lightgrey


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set lbr
set tw=500
set ai
set si
set wrap
autocmd FileType make setlocal noexpandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>gy  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

map <leader>s :Ag<space>
nmap <leader><CR> :FZF<CR>
nmap <silent> <leader><leader> :w!<CR>
nmap <silent> <leader>g :ALEGoToDefinition<CR>
nmap <silent> <leader>f :ALEFindReferences<CR>
