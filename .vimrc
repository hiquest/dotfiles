" ===========================
" PLUGINS
" ===========================
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'           " Navigation tree
Plug '~/.fzf'                        " Fuzzy search
Plug 'junegunn/fzf.vim'              " Vim ext for FZF
Plug 'rafi/awesome-vim-colorschemes' " Just a color theme
Plug 'w0rp/ale'                      " Linting
Plug 'itchyny/lightline.vim'         " lite line
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs' " Auto-insert paired symbols
Plug 'roman/golden-ratio'   " Auto-expands current split

" Git
Plug 'tpope/vim-fugitive'     " Git utils
Plug 'airblade/vim-gitgutter' " Shows a git diff in the gutter

" Highlights
Plug 'tmhedberg/matchit'       " extended %

" Commands
Plug 'tpope/vim-surround'   " Adds surrounds actions
Plug 'tpope/vim-commentary' " Commenting

" Python
Plug 'davidhalter/jedi-vim'
Plug 'hdima/python-syntax'

" JavaScript
Plug 'othree/yajs.vim'
Plug 'mxw/vim-jsx'

" Ruby
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-haml'

call plug#end()

" ============================
" SOME SETTINGS
" ============================
language en_US " had to put this for neovim
set clipboard^=unnamed     " Use the system register for everything
set backspace=2   " Backspace deletes like most programs in insert mode

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
autocmd FileType html setlocal formatprg=js-beautify\ --type\ html
autocmd FileType scss setlocal formatprg=prettier\ --parser\ css
autocmd FileType css setlocal formatprg=prettier\ --parser\ css
autocmd FileType python setlocal formatprg=yapf

" OMNI COMPLETION
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
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
set laststatus=2 " Always show status line

" Lightline
let g:lightline = {
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ }

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" ----------------------------------------------------------------------------
" NerdTree
" ----------------------------------------------------------------------------
let NERDTreeShowHidden=1 " Always show dot files
let NERDTreeQuitOnOpen=1
map <Leader>n :NERDTreeFind<CR>

" ============================
" Fuzzy Finder Setup
" ============================
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

" ============================
" Ale
" ============================
let g:ale_lint_delay=1000
let g:ale_sign_error = '😱'
let g:ale_sign_warning = '😞'
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'javascript': ['eslint']
\}

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

" ---------------------------
" Jedi (Python)
" ---------------------------
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#show_call_signatures = "2"
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = ""
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

" ============================
" CUSTOM MAPPINGS
" ============================
inoremap jj <Esc>
nnoremap <space> za
nnoremap <Leader><Leader> :FZF<CR>
nnoremap <CR> :noh<CR>

" System
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>o :tabo<CR>

" Navigate tabs
nnoremap <C-j> gt
nnoremap <C-k> gT

" Navigate splits
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

" Git blame
nnoremap <leader>a :Gblame<cr>

" Indent and formatting
nnoremap <leader>= gg=G``
nnoremap <leader>- gggqG``




let python_highlight_all = 1
