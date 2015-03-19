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
set laststatus=2 " Always show status line
set mouse=a " Enable mouse in all modes
set noerrorbells " Disable error bells
set nostartofline " Don’t reset cursor to start of line when moving around.
set ruler " Show the cursor position
set shortmess=atI " Don’t show the intro message when starting Vim
set showmode " Show the current mode
set title " Show the filename in the window titlebar
set showcmd " Show the (partial) command as it’s being typed

au BufWritePost .vimrc so $MYVIMRC " Autoload .vimrc whenever it is saved

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
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path"
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly?  Top/bot."

hi statusline ctermfg=1 ctermbg=DarkRed

" Ignore this paths
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/build/*,*/node_modules/*,*/bower_components/*

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

" Git blame on <leader>a
:nnoremap <leader>a :Gblame<cr>

" Toggle test (By rails.vim)
:nnoremap <leader>tt :A<cr>

" Use ag
let g:ackprg = 'ag --vimgrep'
noremap <Leader>f :Ack<cr>

" Fold on space
noremap <Space> za

" Ctrlp
let g:ctrlp_map = '<leader><leader>'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>', '<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>', '<RightMouse>'],
    \ }
