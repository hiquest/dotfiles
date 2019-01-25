" ===========================
" PLUGINS
" ===========================
call plug#begin('~/.vim/plugged')

" Essentials
Plug 'scrooloose/nerdtree'           " Navigation tree
Plug '~/.fzf'                        " Fuzzy search
Plug 'junegunn/fzf.vim'              " Vim ext for FZF
Plug 'w0rp/ale'                      " Linting and fixing
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Easier navigation
Plug 'roman/golden-ratio'   " Auto-expands current split
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs' " Auto-insert paired symbols
Plug 'ap/vim-buftabline'

" Extensions
Plug 'tpope/vim-surround'   " Adds surrounds actions
Plug 'tpope/vim-commentary' " Commenting
Plug 'tmhedberg/matchit'    " extended %

" Appearance
Plug 'rafi/awesome-vim-colorschemes' " Collection of color schemes

" Git
Plug 'tpope/vim-fugitive'     " Git utils ( I only use annotate )
Plug 'mhinz/vim-signify'      " Shows what is changed in a sidebar
Plug 'junegunn/gv.vim'

" Still not sure I need those
Plug 'mhinz/vim-startify'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ap/vim-css-color'

" =========================
" LANGUAGE-SPECIFIC PLUGINS
" =========================

Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'sheerun/vim-polyglot'
Plug 'powerman/vim-plugin-AnsiEsc'

" Python
Plug 'zchee/deoplete-jedi'
Plug 'hdima/python-syntax'

" JavaScript
Plug 'othree/yajs.vim'

" Typescript
Plug 'Quramy/tsuquyomi'           " Completion and navigation
Plug 'leafgarland/typescript-vim' " Syntax
Plug 'ianks/vim-tsx'

" React
Plug 'mxw/vim-jsx'

" Vue
Plug 'posva/vim-vue'
Plug 'digitaltoad/vim-pug'

" Ruby
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-haml'

call plug#end()

" ============================
" SETTINGS
" ============================
language en_US           " had to put this for neovim
set clipboard^=unnamed   " Use the system register for everything
set backspace=2          " Backspace deletes like most programs in insert mode
set hidden

" Folding
set foldenable        " dont fold by default
set foldmethod=indent " fold based on indent
set foldlevelstart=10 " open most folds by default
set foldnestmax=10    " 10 nested fold max

" Appearance
color OceanicNext
set background=dark

set number
set numberwidth=5
set list listchars=tab:»·,trail:·,nbsp:· " disaply extra whitespace
set textwidth=80  " line to limit to 80 chars
set colorcolumn=+1

" SPLITS
set splitbelow
set splitright
set fillchars=vert:│  " Vertical sep between windows (unicode)"

" DIRS
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif
set backupskip=/tmp/*,/private/tmp/* " Don’t create for certain directories

" TABS
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" FORMATTERS
autocmd FileType javascript setlocal formatprg=prettier
autocmd FileType javascript.jsx setlocal formatprg=prettier
autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript\ --no-semi
autocmd FileType html setlocal formatprg=js-beautify\ --type\ html
autocmd FileType scss setlocal formatprg=prettier\ --parser\ css
autocmd FileType css setlocal formatprg=prettier\ --parser\ css
autocmd FileType python setlocal formatprg=yapf

" OMNI COMPLETION
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

" -----------------
" Ignore
" -----------------
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/doc/*,*/source_maps/*,*/dist/*
set wildignore+=*.so,*.swp,*.zip,*/test/files/*,*/webpack.bundle.js

" -----------------
" Status Line
" -----------------
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
        \   '😞 %dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set laststatus=2
set statusline=
set statusline+=%m
set statusline+=\ %f

set statusline+=%=
set statusline+=\ %{LinterStatus()}

" ----------------------------------------------------------------------------
" NerdTree
" ----------------------------------------------------------------------------
let NERDTreeShowHidden=1 " Always show dot files
let NERDTreeQuitOnOpen=1
map <Leader>n :NERDTreeFind<CR>

" ============================
" Fuzzy Finder Setup
" ============================
" let g:fzf_action = {
"       \ 'enter': 'tab split',
"       \ 'ctrl-x': 'split',
"       \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~40%'  }
nnoremap <Leader><Leader> :Files<cr>
nnoremap <Leader>f :Ag <C-R><C-W><cr>
vnoremap <Leader>f y:Ag <C-R>"<cr>
nnoremap <C-F> :Ag<Space>
" List changed and new files
command! Fzfc call fzf#run(fzf#wrap(
      \ {'source': 'git ls-files --exclude-standard --others --modified'}))
noremap <Leader>] :Fzfc<cr>

" ============================
" Ale
" ============================
let g:ale_lint_delay=1000
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'javascript': ['eslint'],
\   'vue': ['eslint']
\}
let g:ale_python_pylint_change_directory = 0

" FIXERS
let g:ale_fixers = {
\    'javascript': ['eslint'],
\    'typescript': ['tslint'],
\    'vue': ['eslint'],
\    'scss': ['prettier']
\}
let g:ale_fix_on_save = 1

nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

" ============================
" DEOPLETE
" ============================
let g:deoplete#enable_at_startup = 1
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" ----------------------------
" JavaScript
" ----------------------------
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" ============================
" CUSTOM MAPPINGS
" ============================
inoremap jj <Esc>
nnoremap <space> za
nnoremap <CR> :noh<CR>

" System
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :bd<CR>
nnoremap <Leader>o :tabo<CR>

" Navigate buffers
nnoremap <C-j> :bnext<CR>
nnoremap <C-k> :bprev<CR>

" Navigate splits
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Git blame
nnoremap <leader>a :Gblame<cr>

" Indent and formatting
nnoremap <leader>= mzgg=G`z
nnoremap <leader>- mzgggqG`z

" TODO
nnoremap <leader>' :vsp /Users/yanis/Dropbox/todo.md<cr>
