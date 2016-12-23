" ###
" PLUGINS
" ###

call plug#begin('~/.vim/plugged')

" General
Plug 'junegunn/fzf.vim'     " Best fuzzy finder
Plug 'jiangmiao/auto-pairs' " Auto-insert paired symbols
" Plug 'roman/golden-ratio'   " Resize splits in golden ratio
Plug 'scrooloose/nerdtree'  " File explorer
Plug 'Valloric/YouCompleteMe', { 'do': './install.py'  }
Plug 'ervandew/supertab'    " Easier completion with tab
Plug 'scrooloose/syntastic' " Bunch of syntax checkers
Plug 'mkitt/tabline.vim'    " Enhances tab labels
Plug 'tpope/vim-commentary' " Commenting
Plug 'tpope/vim-fugitive'   " Git utils
Plug 'airblade/vim-gitgutter' " Shows a git diff in the gutter
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'   " Adds surrounds actions
Plug 'bronson/vim-trailing-whitespace' " Highlights trailing whitespace in red and provides
Plug 'tmhedberg/matchit'    " More matched
Plug 'tpope/vim-endwise'    " auto add closing end's
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' " Snippets for snipmate

" Syntax
Plug 'evanmiller/nginx-vim-syntax'
Plug 'elixir-lang/vim-elixir'

" Html markup
Plug 'tpope/vim-haml'
Plug 'digitaltoad/vim-jade'
Plug 'slim-template/vim-slim'

" Stylesheets
Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-cucumber'
Plug 'skalnik/vim-vroom'

" JavaScript
Plug 'othree/yajs.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'burnettk/vim-angular'
Plug 'Quramy/vim-js-pretty-template' " highlights JavaScript's Template Strings

" Typescript
Plug 'leafgarland/typescript-vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Quramy/tsuquyomi'

" Integrations
" Plug 'rizzatti/dash.vim' " Dash App
"

Plug 'mhartington/oceanic-next'

call plug#end()

set rtp+=~/.fzf

" GENERAL
syntax on
filetype plugin indent on " load filetype-specific indent files
set nocompatible          " Don't use the default settings
set encoding=utf-8 nobomb " Use UTF-8 without BOM
set clipboard=unnamed     " Use the OS clipboard by default (on versions compiled with `+clipboard`)
set shortmess=a           " Short the status message
set report=0              " Show all changes

" ----------------------------------------------------------------------------
" Wild ignore
" ----------------------------------------------------------------------------
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/doc/*,*/source_maps/*,*/dist/*
set wildignore+=*.so,*.swp,*.zip,*/test/files/*,*/webpack.bundle.js

" UI SETTINGS
set list          " Show trailing whitespace
set number        " Enable line numbers
" set numberwidth=5
set showcmd       " Show the (partial) command as it’s being typed
set showmode      " Show the current mode
set cursorline    " Highlight current line
set colorcolumn=80
set wildmode=longest,list,full
set wildmenu      " visual autocomplete for command menu
set showmatch     " highlight matching [{()}] "
set title         " Show the filename in the window titlebar
set ruler         " Show the cursor position
set nostartofline " Don’t reset cursor to start of line when moving around.
set shortmess=atI " Don’t show the intro message when starting Vim
set lcs=tab:▸\ ,trail:·,nbsp:_ " Show “invisible” characters
set noerrorbells " Disable error bells
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " change cursor view for insert/normal mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set nojoinspaces                      " J command doesn't add extra space"

" cursor don't get below/ontop when scrolling
" set scrolloff=8
" set sidescrolloff=16

" Color scheme
" set background=dark
" colorscheme Tomorrow-Night
if (has("termguicolors"))
 set termguicolors
endif
colorscheme OceanicNext

" SEARCH
set hlsearch    " Highlight searches
set incsearch   " Highlight dynamically as pattern is typed
set gdefault    " Add the g flag to search/replace by default
set ignorecase  " Ignore case of searches

" FOLDING
set foldenable        " dont fold by default
set foldmethod=indent " fold based on indent
set foldlevelstart=10 " open most folds by default
set foldnestmax=10    " 10 nested fold max

" NAVIGATION
set noesckeys                  " No cursor keys in insert mode
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
set fillchars=vert:│  " Vertical sep between windows (unicode)"

" BACKUPS/SWAPS/UNDO
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif
set backupskip=/tmp/*,/private/tmp/* " Don’t create for certain directories

" ------------------------------------
" Typing key combos
" ------------------------------------
set notimeout
set ttimeout
set ttimeoutlen=10

" STATUS LINE
set laststatus=2 " Always show status line
" Left side
set statusline=
set statusline+=%0*\[%n]                                  "buffernr
set statusline+=%0*\ %<%F\                                "File+path"
set statusline+=%0*\ %y\                                  "FileType
" Right side
set statusline+=%0*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%0*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly?  Top/bot."
set statusline+=%#warningmsg#                             "Syntastic err message
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Jump to the last cursor position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" Reload .vimrc file changes immidiately
" autocmd BufWritePost  $MYVIMRC  source $MYVIMRC

" NerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1 " Always show dot files
" Open file explorer with cursor at current file
map <Leader>n :NERDTreeFind<CR>

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:syntastic_javascript_checkers = ['eslint']
" Toggle Syntastic mode
nnoremap <Leader>i :SyntasticToggleMode<CR>'

" Fuzzy finder fzf
noremap <Leader><Leader> :Files<cr>
" Use enter to open in new tab
let g:fzf_action = {
  \ 'enter': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
nnoremap <Leader>f :Ag <C-R><C-W><cr>
vnoremap <Leader>f y:Ag <C-R>"<cr>
nnoremap <C-F> :Ag<Space>
" List changed and new files
command! Fzfc call fzf#run(fzf#wrap(
  \ {'source': 'git ls-files --exclude-standard --others --modified'}))
noremap <Leader>] :Fzfc<cr>

let g:vroom_use_vimux = 1

let g:used_javascript_libs = 'jquery,underscore,react,chai,angularjs'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" ###
" CUSTOM MAPPINGS
" ###

" Strip trailing whitespace
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Git blame on <leader>a
nnoremap <leader>a :Gblame<cr>

" Fold on space
noremap <Space> za

" jj to exit to normal mode
inoremap jj <Esc> :w<cr>

" No highlight on enter
nnoremap <CR> :noh<cr>

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

" Don't allow to use arrow keys
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

" Faster tab navigation
map <S-H> gT
map <S-L> gt

" Open Notepad
nnoremap <Leader>' :vsp ~/Dropbox/notes.markdown <CR>

let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'
" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>

nmap <Leader>hr <Plug>GitGutterUndoHunk

autocmd FileType coffee JsPreTmpl html
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.

" Edit ~/.vimrc
nmap <silent>  <Leader>v :next $MYVIMRC<CR>
