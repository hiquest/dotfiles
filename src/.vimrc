syntax on
filetype plugin indent on

set nocompatible
set wildmenu " Enhance command-line completion
set esckeys " Allow cursor keys in insert mode
set backspace=indent,eol,start " Allow backspace in insert mode
set ttyfast " Optimize for fast terminal connections
set gdefault " Add the g flag to search/replace by default
set encoding=utf-8 nobomb " Use UTF-8 without BOM
set number " Enable line numbers
set cursorline " Highlight current line
set tabstop=2 " Make tabs as wide as two spaces
set lcs=tab:▸\ ,trail:·,nbsp:_ " Show “invisible” characters
set list
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches
set incsearch " Highlight dynamically as pattern is typed
set mouse=a " Enable mouse in all modes
set noerrorbells " Disable error bells
set nostartofline " Don’t reset cursor to start of line when moving around.
set ruler " Show the cursor position
set shortmess=atI " Don’t show the intro message when starting Vim
set showmode " Show the current mode
set title " Show the filename in the window titlebar
set showcmd " Show the (partial) command as it’s being typed

au BufWritePost .vimrc so $MYVIMRC " Autoload .vimrc whenever it is saved

" change cursor view for insert/normal mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Strip trailing whitespace
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

set autoread " Reload files changed outside vim

" ================ Indentation ======================
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" ================ Splits ============================
set splitbelow
set splitright

" ================ Folds ============================
set foldmethod=indent   "fold based on indent
set nofoldenable        "dont fold by default

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif
" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" ================ Statusline ============================
set laststatus=2 " Always show status line
set statusline=
set statusline+=%0*\[%n]                                  "buffernr
set statusline+=%0*\ %<%F\                                "File+path"
set statusline+=%0*\ %y\                                  "FileType
set statusline+=%0*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%0*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly?  Top/bot."
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Ignore this paths
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/build/*,*/node_modules/*,*/bower_components/*

" Autosave
" :au FocusLost * silent! wa

" ================ PLUGINS ============================

" Pathogen
execute pathogen#infect()

" Color scheme: solarized
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" NerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Open file explorer with cursor at current file
map <Leader>n :NERDTreeFind<CR>
" map <Leader>n :NERDTreeToggle<CR>

" Syntastic
let g:syntastic_always_populate_loc_list = 1
" Display long list of errors at the bottom
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" NerdCommenter
let NERDSpaceDelims=1
map <Leader>/ <plug>NERDCommenterToggle<CR>

" Use ag
let g:ackprg = 'ag --vimgrep'
noremap <Leader>f :Ack<cr>

" Ctrlp
let g:ctrlp_map = '<leader><leader>'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>', '<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>', '<RightMouse>'],
    \ }

" Faster exit to normal mode
set timeoutlen=1000 ttimeoutlen=0

" Custom mappings

" Git blame on <leader>a
:nnoremap <leader>a :Gblame<cr>

" Fold on space
noremap <Space> za

" Navigate tabs
noremap 11 1gt<CR>
noremap 22 2gt<CR>
noremap 33 3gt<CR>
noremap 44 4gt<CR>
noremap 55 5gt<CR>
noremap 66 6gt<CR>
noremap 77 7gt<CR>
noremap 88 8gt<CR>
noremap 99 9gt<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" Copy & paste to system clipboard with <Space>p and <Space>y:
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P

nnoremap <CR> o
nnoremap <BS> gg
