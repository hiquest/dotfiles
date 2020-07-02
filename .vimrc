" ===========================
" PLUGINS
" ===========================
call plug#begin('~/.vim/plugged')

" Plugins / Essentials {{{
Plug 'scrooloose/nerdtree'           " Navigation tree
Plug 'Nopik/vim-nerdtree-direnter'   " Fix for opening files and directories in tabs
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'                      " Linting and fixing
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Completion
Plug 'ncm2/float-preview.nvim'

" {{{ Plugins / Pairs: matching, highlitning, auto-closing
Plug 'andymass/vim-matchup'          " modern matchit
Plug 'jiangmiao/auto-pairs'          " Auto-insert paired symbols
Plug 'tpope/vim-endwise'             " Auto-closing language-specific constructs
Plug 'alvan/vim-closetag'            " Auto-close for HTML tags
" Plug 'valloric/MatchTagAlways'       " Highlitning HTML tags
" }}}

" Misc
Plug 'terryma/vim-multiple-cursors'  " multiple cursors
" Plug 'wellle/targets.vim'            " additional text objects
Plug 'machakann/vim-sandwich'        " A better vim-surround
Plug 'tpope/vim-commentary'          " Commenting
Plug 'norcalli/nvim-colorizer.lua'   " Highlights colors in CSS, etc.
" Plug 'joshdick/onedark.vim'          " A colorscheme
" Plug 'ryanoasis/vim-devicons'

Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'

" Git
Plug 'tpope/vim-fugitive'     " Git utils (I mostly only use annotate)
Plug 'airblade/vim-gitgutter' " Shows what is changed in a sidebar
Plug 'rhysd/git-messenger.vim' " displays commit message in a hover window

" =========================
" LANGUAGE-SPECIFIC PLUGINS
" =========================

" Nginx
Plug 'chr4/nginx.vim'

" Ruby / Rails
Plug 'tpope/vim-rails'

" JavaScript
Plug 'othree/yajs.vim', { 'for': 'javascript' }
" issues with indentation ???
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" Typescript
Plug 'HerringtonDarkholme/yats.vim'

" Python
" Plug 'numirias/semshi', { 'for': 'python' }
" Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
" Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Markdown
" !!! THIS BREAKS gx (open the link under the cursor)
" Plug 'godlygeek/tabular', { 'for': 'markdown' }
" Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" Elixir
" Plug 'elixir-editors/vim-elixir'

call plug#end()


let g:float_preview#docked = 0
" ============================
" SETTINGS
" ============================
" set completeopt=menu,menuone,popup,noselect,noinsert
language en_US             " had to put this for Neovim
set clipboard^=unnamedplus " Use the system register for everything
" set hidden

" Colors and appearance {{{
set number               " shows the line numbers on the left
" set invcursorline      " highlights the current line (can be slow)
set textwidth=80         " line to limit to 80 chars
set so=7                 " More lines until cursor starts scrolling
set cmdheight=1          " Better display for messages
" set signcolumn=yes       " always show signcolumns
" set colorcolumn=120
set termguicolors        " enable true color for Vim

" colorscheme onedark
set background=dark
colorscheme gruvbox
" colorscheme onehalflight
" }}}

" FOLD {{{
set foldmethod=indent   " fold based on indent
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
" set foldcolumn=2

function! JSFolds()
  let thisline = getline(v:lnum)
  if thisline =~? '\v^\s*$'  " empty lines
    " the foldlevel of this line is equal to the foldlevel of the line above
    " or below it, whichever is smaller
    return '-1'
  endif

  " let nextline = getline(v:lnum + 1)
  if thisline =~ '^import.*$'
    return 1
  else
    return indent(v:lnum) / &shiftwidth
  endif
endfunction

autocmd FileType vim setlocal foldmethod=marker

autocmd FileType javascript setlocal foldmethod=expr
autocmd FileType javascript setlocal foldexpr=JSFolds()

autocmd FileType typescript setlocal foldmethod=expr
autocmd FileType typescript setlocal foldexpr=JSFolds()

autocmd FileType typescriptreact setlocal foldmethod=expr
autocmd FileType typescriptreact setlocal foldexpr=JSFolds()
" }}}

" SPLITS {{{
set splitbelow
set splitright
" }}}

" Indentation {{{
set shiftround
set tabstop=2
set shiftwidth=2
set expandtab  " use spaces instead of tabs
" }}}

" Change iTerm2 tab title {{{
set title
let &titlestring = split(getcwd(), '/')[-1]
" }}}

" Spell
autocmd FileType markdown setlocal spell

" syntax hl works better (but slower?)
autocmd BufEnter *.{js,ts,jsx,tsx} :syntax sync fromstart

" FORMATTERS {{{
autocmd FileType javascript setlocal formatprg=prettier\ --parser\ babel
autocmd FileType javascript.jsx setlocal formatprg=prettier
autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
autocmd FileType typescriptreact setlocal formatprg=prettier\ --parser\ typescript
autocmd FileType html setlocal formatprg=prettier\ --parser\ html
autocmd FileType scss setlocal formatprg=prettier\ --parser\ css
autocmd FileType css setlocal formatprg=prettier\ --parser\ css
autocmd FileType python setlocal formatprg=yapf
autocmd FileType markdown setlocal formatprg=prettier\ --parser\ markdown
" }}}

" OMNI COMPLETION {{{
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
" }}}

" IGNORE {{{
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/doc/*,*/source_maps/*,*/dist/*
set wildignore+=*.so,*.swp,*.zip,*/test/files/*,*/webpack.bundle.js
" }}}

" STATUS LINE {{{
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

set statusline=
set statusline+=%m
set statusline+=\ %f

set statusline+=%=
set statusline+=\ %{LinterStatus()}
" }}}

" HIGHLIGHTS {{{
" Change bg color in INSERT mode
" hi StatusLine guibg=PeachPuff2 guifg=gray82

" Highlight colors for `matchpairs`
hi MatchParen guibg=gray30
" hi! MatchParen cterm=NONE,bold gui=NONE,bold ctermbg=15 guibg=#fdf6e3 ctermfg=12 guifg=#839496

" Highlight colors for tabs
" hi TabLine guibg=yellow guifg=red
" hi TabLineFill guibg=yellow guifg=red
hi TabLineSel guibg=PeachPuff4 guifg=gray82

hi VertSplit guifg=PeachPuff4

hi Folded guifg=PeachPuff4
" }}}

"  Highlight extra whitespaces {{{
highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+\%#\@<!$/
" }}}


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
" Deoplete
" ============================
let g:deoplete#enable_at_startup = 1
" let g:float_preview#docked = 0

" Ale {{{
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'javascript': ['eslint'],
      \   'typescript': ['tsserver'],
      \   'typescriptreact': ['tsserver'],
      \   'vue': ['eslint'],
      \   'ruby': ['standardrb', 'ruby', 'reek', 'rails_best_practices', 'brakeman', 'solargraph'],
      \   'xml': ['xmllint']
      \}
let g:ale_python_pylint_change_directory = 0

" FIXERS
let g:ale_fixers = {
      \    'python': ['yapf'],
      \    'javascript': ['prettier'],
      \    'typescript': ['prettier'],
      \    'typescriptreact': ['prettier'],
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

nnoremap ]r :ALENextWrap<CR>      " move to the next ALE warning / error
nnoremap [r :ALEPreviousWrap<CR>  " move to the previous ALE warning / error
nnoremap <leader>d :ALEDetail<cr> " show full message of ALE

" LSP / TSServer
let g:ale_completion_tsserver_autoimport = 1
" let g:ale_completion_enabled = 1
nmap <leader>i :ALEOrganizeImports<CR>
nmap gd :ALEGoToDefinitionInTab<CR>
nmap gr :ALEFindReferences<CR>
nmap <leader>r :ALERename<CR>
nmap K :ALEHover<CR>
" let g:ale_disable_lsp = 1


autocmd CompleteDone * pclose
" }}}

" ============================
" Colorizer
" ============================
lua require'colorizer'.setup()

" ============================
" Closetag
" ============================
let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.tsx'

" ============================
" MatchTagAlways
" ============================
" let g:mta_filetypes = {
"     \ 'html' : 1,
"     \ 'typescriptreact': 1,
"     \}

" CUSTOM MAPPINGS {{{
inoremap jj <Esc>
nnoremap <space> za
nnoremap <leader>c :%foldc<CR>
nnoremap <CR> :noh<CR>
nnoremap <BS> :only<CR>

map - :NERDTreeToggle<CR>
map <Leader>n :NERDTreeFind<CR>

" System
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :bd<CR>
nnoremap <Leader>o :tabo<CR>
" nnoremap xx :q!<CR>
nnoremap xw :wq<CR>

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

" Select the whole file
nmap Q ggvG

" I want all my function keys mappings in one place
nmap <F8> :Vista!!<CR>
nmap <F10> :ALEFix<CR>

" Remap arrow keys to buffer switching
nnoremap <Left> :tabprevious<CR>
nnoremap <Right> :tabnext<CR>

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gl :GV!<CR>

nnoremap <leader>gm :GitMessenger<CR>

" map ; <Plug>(expand_region_expand)
" map : <Plug>(expand_region_shrink)
" }}}
