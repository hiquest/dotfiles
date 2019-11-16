" ===========================
" PLUGINS
" ===========================
call plug#begin('~/.vim/plugged')

" Essentials
Plug 'scrooloose/nerdtree'           " Navigation tree
Plug 'Nopik/vim-nerdtree-direnter'   " Fix for opening files and directories in tabs
Plug '~/.fzf'                        " Fuzzy search
Plug 'junegunn/fzf.vim'              " Vim ext for FZF
Plug 'w0rp/ale'                      " Linting and fixing
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Autocompletion
Plug 'terryma/vim-multiple-cursors'
Plug 'wellle/targets.vim'

" A colorscheme
Plug 'joshdick/onedark.vim'

" Easier navigation
Plug 'roman/golden-ratio'   " Auto-expands current split
Plug 'jiangmiao/auto-pairs' " Auto-insert paired symbols
" Plug 'ap/vim-buftabline'

" Extensions
Plug 'tpope/vim-surround'   " Adds surrounds actions
Plug 'tpope/vim-commentary' " Commenting
Plug 'tmhedberg/matchit'    " extended %
Plug 'ap/vim-css-color'     " Highlights colors

" Git
Plug 'tpope/vim-fugitive'     " Git utils ( I only use annotate )
Plug 'mhinz/vim-signify'      " Shows what is changed in a sidebar

" =========================
" LANGUAGE-SPECIFIC PLUGINS
" =========================

" Ruby
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'

" Python
Plug 'deoplete-plugins/deoplete-jedi'

" JavaScript
Plug 'othree/yajs.vim'
" Disabled it now cause it causes issues with indentation
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Typescript
Plug 'HerringtonDarkholme/yats.vim'

call plug#end()

" ============================
" SETTINGS
" ============================
language en_US           " had to put this for Neovim
set clipboard^=unnamed   " Use the system register for everything
set backspace=2          " Backspace deletes like most programs in insert mode
set hidden

" Lines and columns
" set invcursorline
set number
" set numberwidth=5
set textwidth=80         " line to limit to 80 chars
" set colorcolumn=+1
set so=7                 " Set 7 lines to the cursor - when moving vertically using j/k

" Colors and appearance
set termguicolors " enable true color for Vim
colorscheme onedark

" Folding
set foldenable        " don't fold by default
set foldmethod=indent " fold based on indent
set foldlevelstart=10 " open most folds by default
set foldnestmax=10    " 10 nested fold max

" SPLITS
set splitbelow
set splitright
set fillchars=vert:│  " Vertical separator between windows (unicode)"

" TABS
set list listchars=tab:»·,trail:·,nbsp:· " display extra white space
set shiftround
set tabstop=2
set shiftwidth=2
set expandtab  " use spaces instead of tabs

autocmd FileType markdown setlocal spell

" syntax works more properly (but slower?)
autocmd BufEnter *.{js,ts,jsx,tsx} :syntax sync fromstart

" FORMATTERS
autocmd FileType javascript setlocal formatprg=prettier
autocmd FileType javascript.jsx setlocal formatprg=prettier
autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
autocmd FileType typescriptreact setlocal formatprg=prettier\ --parser\ typescript
autocmd FileType html setlocal formatprg=prettier\ --parser\ html
autocmd FileType scss setlocal formatprg=prettier\ --parser\ css
autocmd FileType css setlocal formatprg=prettier\ --parser\ css
autocmd FileType python setlocal formatprg=yapf
autocmd FileType markdown setlocal formatprg=prettier\ --parser\ markdown

" OMNI COMPLETION
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType ruby setlocal omnifunc=LanguageClient#complete

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
" Spelling / Dictionaries
" ----------------------------------------------------------------------------
set dictionary+=/usr/share/dict/words
set thesaurus+=/Users/yanis/thesaurus/words.txt

" ----------------------------------------------------------------------------
" NerdTree
" ----------------------------------------------------------------------------
let NERDTreeShowHidden=1 " Always show dot files
let NERDTreeQuitOnOpen=1
let g:NERDTreeMapOpenInTab = '<ENTER>'
let g:NERDTreeWinPos = "right"

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

" let g:ale_completion_enabled = 1
let g:ale_completion_tsserver_autoimport = 1
nnoremap gd :ALEGoToDefinitionInTab<cr>
nnoremap <leader>h :ALEHover<cr>

" let g:ale_lint_delay=1000
let g:ale_linters = {
      \   'python': ['flake8', 'pylint', 'bandid'],
      \   'javascript': ['eslint'],
      \   'typescript': ['tsserver', 'tslint'],
      \   'typescriptreact': ['tsserver', 'tslint'],
      \   'vue': ['eslint'],
      \   'ruby': ['standardrb', 'ruby', 'reek', 'rails_best_practices', 'brakeman', 'solargraph'],
      \   'xml': ['xmllint']
      \}
let g:ale_python_pylint_change_directory = 0

" FIXERS
let g:ale_fixers = {
      \    'python': ['black'],
      \    'javascript': ['prettier', 'eslint'],
      \    'typescript': ['prettier', 'tslint'],
      \    'typescriptreact': ['prettier', 'tslint'],
      \    'vue': ['eslint'],
      \    'scss': ['prettier'],
      \    'html': ['prettier'],
      \    'reason': ['refmt'],
      \    'ruby': ['standardrb'],
      \    'markdown': ['prettier'],
      \    'elixir': ['mix_format'],
      \    'xml': ['xmllint'],
      \    'json': ['prettier']
      \}
let g:ale_fix_on_save = 1

nnoremap ]r :ALENextWrap<CR>     " move to the next ALE warning / error
nnoremap [r :ALEPreviousWrap<CR> " move to the previous ALE warning / error

" show full message of ALE
nnoremap <leader>d :ALEDetail<cr>

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

" ============================
" ECHODOC
" ============================
let g:echodoc_enable_at_startup = 1
let g:echodoc#type = 'virtual'

" ============================
" CUSTOM MAPPINGS
" ============================
inoremap jj <Esc>
nnoremap <space> za
nnoremap <CR> :noh<CR>
nnoremap <BS> :only<CR>

map - :NERDTreeToggle<CR>
map <Leader>n :NERDTreeFind<CR>

" System
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :bd<CR>
nnoremap <Leader>o :tabo<CR>

" Navigate tabs
nnoremap <C-j> :tabnext<CR>
nnoremap <C-k> :tabprev<CR>

" Navigate splits
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Git blame
nnoremap <leader>a :Gblame<cr>

" Indent and formatting
nnoremap <leader>= mzgg=G`z
nnoremap <leader>- mzgggqG`z

" copy file path to the clipboard
nnoremap <leader>p :let @+ = expand("%")<cr>

" Indent with Tab
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >
vnoremap <S-Tab> <

" Select the whole file
nmap Q ggvG
