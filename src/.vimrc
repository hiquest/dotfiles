syntax on
filetype plugin indent on " load filetype-specific indent files

set nocompatible
set ttyfast " Optimize for fast terminal connections
set encoding=utf-8 nobomb " Use UTF-8 without BOM
set list
set mouse=a " Enable mouse in all modes
set clipboard=unnamed
set autoread " Reload files changed outside vim

" UI SETTINGS
set number " Enable line numbers
set showcmd " Show the (partial) command as it’s being typed
set showmode " Show the current mode
set cursorline " Highlight current line
set wildmenu " visual autocomplete for command menu
set showmatch  " highlight matching [{()}] "
set title " Show the filename in the window titlebar
set ruler " Show the cursor position
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " change cursor view for insert/normal mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set nostartofline " Don’t reset cursor to start of line when moving around.
set shortmess=atI " Don’t show the intro message when starting Vim
set lcs=tab:▸\ ,trail:·,nbsp:_ " Show “invisible” characters
set noerrorbells " Disable error bells

" SEARCHING
set incsearch " Highlight dynamically as pattern is typed
set hlsearch " Highlight searches
set gdefault " Add the g flag to search/replace by default
set ignorecase " Ignore case of searches

" FOLDING
set foldenable        "dont fold by default
set foldmethod=indent   "fold based on indent
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max

" NAVIGATION
set esckeys " Allow cursor keys in insert mode
set backspace=indent,eol,start " Allow backspace in insert mode

" INDENTATION/TABS
set tabstop=2     " read as
set softtabstop=2 " insert as
set expandtab     " tabs are spaces
set autoindent
set smartindent
set smarttab
set shiftwidth=2

" SPLITS
set splitbelow
set splitright

" BACKUPS/SWAPS
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif
" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" STATUS LINE
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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/build/*,*/node_modules/*,*/bower_components/*,*/test/files/*

" Jump to the last cursor position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" CUSTOM FILES
au BufRead,BufNewFile *.eco setfiletype html
au BufRead,BufNewFile *.hamlc setfiletype haml

" PLUGIN SETTINGS

" Pathogen
execute pathogen#infect()

" Color scheme
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" colorscheme gruvbox

" NerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Use ag for :Ack
let g:ackprg = 'ag --vimgrep'

" Ctrlp
let g:ctrlp_map = '<leader><leader>'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>', '<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>', '<RightMouse>'],
    \ }
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" Faster exit to normal mode
set timeoutlen=1000 ttimeoutlen=0

" CUSTOM MAPPINGS

" Strip trailing whitespace
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Open file explorer with cursor at current file
map <Leader>n :NERDTreeFind<CR>

" Search with :Ack! on current word
noremap <Leader>f :Ack!<cr>

" Git blame on <leader>a
:nnoremap <leader>a :Gblame<cr>

" Fold on space
noremap <Space> za

" jj to normal mode
inoremap jj <Esc> :w<cr>

" Navigating over splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Faster save, and quit
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>x :qa<CR>

nnoremap <Leader>o :tabo<CR>

" No highlight on enter
nnoremap <CR> :noh<cr>

" run the whole file in ruby
noremap <Leader>r ggVG:w !ruby<cr>

" Don't allow to use arrow keys
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

" Open Notepad
nnoremap <Leader>' :vsp /Users/yanis/Dropbox/notes.markdown <CR>

" Split navigation
nnoremap <Left> <C-w>h
nnoremap <Down> <C-w>j
nnoremap <Up> <C-w>k
nnoremap <Right> <C-w>l
