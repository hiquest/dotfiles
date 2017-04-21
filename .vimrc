" ----------------------------------------------------------------------------
" Plugins
" ----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" General
Plug 'scrooloose/nerdtree'          " File explorer
Plug 'junegunn/fzf.vim'             " Best fuzzy finder
Plug 'terryma/vim-multiple-cursors'
Plug 'w0rp/ale'                     " Async linter

" Completion & snippets
Plug 'Shougo/neocomplete.vim'       " requires Lua
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

" Appearance
Plug 'mkitt/tabline.vim'    " Enhances tab labels

" Git
Plug 'tpope/vim-fugitive'     " Git utils
Plug 'airblade/vim-gitgutter' " Shows a git diff in the gutter

" Highlights
Plug 'tmhedberg/matchit'       " extended %
Plug 'itchyny/vim-cursorword'  " word under cursor
Plug 'Valloric/MatchTagAlways'

" Commands
Plug 'tpope/vim-surround'   " Adds surrounds actions
Plug 'tpope/vim-commentary' " Commenting

" Auto
Plug 'tpope/vim-endwise'    " auto add closing end's
Plug 'jiangmiao/auto-pairs' " Auto-insert paired symbols

" Nginx
Plug 'evanmiller/nginx-vim-syntax'

" Html markup
Plug 'othree/html5.vim'
Plug 'tpope/vim-haml', { 'for': 'haml' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }

" Stylesheets
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-cucumber'

" JavaScript
Plug 'othree/yajs.vim'
Plug 'Quramy/vim-js-pretty-template'
Plug 'mxw/vim-jsx'
Plug 'burnettk/vim-angular'
Plug 'posva/vim-vue'
Plug 'othree/javascript-libraries-syntax.vim'

" Coffee
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee'}

call plug#end()

set rtp+=~/.fzf

" ----------------------------------------------------------------------------
" GENERAL
" ----------------------------------------------------------------------------
syntax on
filetype plugin indent on " load filetype-specific indent files
set nocompatible          " Don't use the default vi-like setting
set encoding=utf-8 nobomb " Use UTF-8 without BOM
set clipboard=unnamed     " Use the OS clipboard by default (on versions compiled with `+clipboard`)
set shortmess=a           " Short the status message
set report=0              " Show all changes
set exrc                  " Read local .vimrc

" ----------------------------------------------------------------------------
" UI
" ----------------------------------------------------------------------------
set list          " Show trailing whitespace
set number        " Enable line numbers
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
set lcs=tab:▸\ ,trail:$,nbsp:_ " Show “invisible” characters
set noerrorbells " Disable error bells
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " change cursor view for insert/normal mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" ----------------------------------------------------------------------------
" Color scheme
" ----------------------------------------------------------------------------
" set background=dark
set termguicolors
colorscheme seoul256

" ----------------------------------------------------------------------------
" SEARCH
" ----------------------------------------------------------------------------
set hlsearch   " Highlight searches
set incsearch  " Highlight dynamically as pattern is typed
set gdefault   " Add the g flag to search/replace by default
set ignorecase " Ignore case of searches

" ----------------------------------------------------------------------------
" FOLDING
" ----------------------------------------------------------------------------
set foldenable        " dont fold by default
set foldmethod=indent " fold based on indent
set foldlevelstart=10 " open most folds by default
set foldnestmax=10    " 10 nested fold max

" ----------------------------------------------------------------------------
" NAVIGATION
" ----------------------------------------------------------------------------
set noesckeys                  " No cursor keys in insert mode
set backspace=indent,eol,start " Allow backspace in insert mode

" ----------------------------------------------------------------------------
" INDENTATION/TABS
" ----------------------------------------------------------------------------
set tabstop=2     " read as
set softtabstop=2 " insert as
set expandtab     " tabs are spaces
set autoindent
set smartindent
set smarttab
set shiftwidth=2

" ----------------------------------------------------------------------------
" SPLITS
" ----------------------------------------------------------------------------
set splitbelow
set splitright
set fillchars=vert:│  " Vertical sep between windows (unicode)"

" ----------------------------------------------------------------------------
" Wild ignore
" ----------------------------------------------------------------------------
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/doc/*,*/source_maps/*,*/dist/*
set wildignore+=*.so,*.swp,*.zip,*/test/files/*,*/webpack.bundle.js

" ----------------------------------------------------------------------------
" BACKUPS/SWAPS/UNDO
" ----------------------------------------------------------------------------
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

" ----------------------------------------------------------------------------
" Status Line
" ----------------------------------------------------------------------------
set laststatus=2 " Always show status line
function! MyBufferLine()
  let st='%{bufferline#refresh_status()}'
  return bufferline#get_status_string()
endfunction

set statusline=
set statusline+=%(%{'help'!=&filetype?bufnr('%'):''}\ \ %)
set statusline+=%< " Where to truncate line
set statusline+=%f " Path to the file in the buffer, as typed or relative to current directory
set statusline+=%{&modified?'\ +':''}
set statusline+=%{&readonly?'\ ':''}
set statusline+=%(\ \ %{ALEGetStatusLine()}%)
set statusline+=%= " Separation point between left and right aligned items

" Right side
set statusline+=\ %{''!=#&filetype?&filetype:'none'}
set statusline+=%(\ %{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'')
  \.('unix'!=#&fileformat?'\ '.&fileformat:'')}%)
set statusline+=%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)
set statusline+=\ \ %2v " Virtual column number
set statusline+=\ %3p%% " Percentage through file in lines as in |CTRL-G|

" ----------------------------------------------------------------------------
" Configure auto
" ----------------------------------------------------------------------------
" Jump to the last cursor position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" ----------------------------------------------------------------------------
" Formatters
" ----------------------------------------------------------------------------
autocmd FileType javascript setlocal formatprg=js-beautify\ --type\ js
autocmd FileType html setlocal formatprg=js-beautify\ --type\ html

" ----------------------------------------------------------------------------
" Custom files
" ----------------------------------------------------------------------------
au BufRead,BufNewFile *.jst.eco set filetype=html

" ----------------------------------------------------------------------------
" Enable omni completion.
" ----------------------------------------------------------------------------
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

set tags=.vim_tags;
set conceallevel=0 " disable the auto-hide feature in json-vim

" ----------------------------------------------------------------------------
" KEY MAPPINGS
" ----------------------------------------------------------------------------
inoremap jj <Esc> :w<cr>
nnoremap <leader>= gg=G``
nnoremap <leader>g gggqG``
nnoremap <Space> za
nnoremap <leader>a :Gblame<cr>
nnoremap <CR> :noh<cr>
nnoremap <C-J> gt
nnoremap <C-K> gT
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>x :qa<CR>
nnoremap <Leader>o :tabo<CR>
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>
nnoremap <Leader>' :vsp ~/Dropbox/notes.markdown <CR>
nmap <Leader>hr <Plug>GitGutterUndoHunk

" ----------------------------------------------------------------------------
" NerdTree
" ----------------------------------------------------------------------------
let NERDTreeShowHidden=1 " Always show dot files
let NERDTreeQuitOnOpen=1
map <Leader>n :NERDTreeFind<CR>

" ----------------------------------------------------------------------------
" Fuzzy finder fzf
" ----------------------------------------------------------------------------
" Use enter to open in new tab
let g:fzf_action = {
      \ 'enter': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~40%'  }
nnoremap <Leader><Leader> :Files<cr>
nnoremap <Leader>f :Ag <C-R><C-W><cr>
vnoremap <Leader>f y:Ag <C-R>"<cr>
nnoremap <C-F> :Ag<Space>
" List changed and new files
command! Fzfc call fzf#run(fzf#wrap(
      \ {'source': 'git ls-files --exclude-standard --others --modified'}))
noremap <Leader>] :Fzfc<cr>

" ----------------------------------------------------------------------------
" JS libs
" ----------------------------------------------------------------------------
let g:used_javascript_libs = 'jquery,underscore,react,angularjs'

" ----------------------------------------------------------------------------
" Js templates
" ----------------------------------------------------------------------------
autocmd FileType coffee JsPreTmpl html
" autocmd FileType javascript JsPreTmpl html " not working ?

" ----------------------------------------------------------------------------
" NeoComplete
" ----------------------------------------------------------------------------
let g:neocomplete#enable_at_startup = 1 " Use neocomplete.
let g:neocomplete#enable_smart_case = 1 " Use smartcase.
let g:neocomplete#sources#syntax#min_keyword_length = 3 " min syntax keyword length
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
call neocomplete#util#set_default_dictionary(
  \ 'g:neocomplete#sources#omni#input_patterns',
  \ 'elm',
  \ '\.')
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" ----------------------------------------------------------------------------
" NeopSnippet
" ----------------------------------------------------------------------------
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
let g:neosnippet#enable_snipmate_compatibility = 1
