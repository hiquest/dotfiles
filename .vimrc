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
Plug 'terryma/vim-multiple-cursors'
Plug 'wellle/targets.vim'
" Plug 'vim-airline/vim-airline'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}

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
" Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'

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
language en_US             " had to put this for Neovim
set clipboard^=unnamedplus " Use the system register for everything
set backspace=2            " Backspace deletes like most programs in insert mode
set hidden

" Lines and columns
" set invcursorline
set number
" set numberwidth=5
set textwidth=80         " line to limit to 80 chars
set colorcolumn=+1
set so=7                 " Set 7 lines to the cursor - when moving vertically using j/k

" Colors and appearance
set termguicolors " enable true color for Vim
colorscheme onedark

set cmdheight=2          " Better display for messages
set updatetime=300       " You will have bad experience for diagnostic messages when it's default 4000.
set shortmess+=c         " don't give |ins-completion-menu| messages.
set signcolumn=yes       " always show signcolumns

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

" ----------------------------
"  Highlight extra whitespaces
" ----------------------------
highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+\%#\@<!$/

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
let g:ale_completion_enabled = 0
let g:ale_completion_tsserver_autoimport = 0
let g:ale_disable_lsp = 1
" nnoremap gd :ALEGoToDefinitionInTab<cr>
" nnoremap <leader>h :ALEHover<cr>

" let g:ale_lint_delay=1000
let g:ale_linters = {
      \   'python': ['flake8', 'pylint', 'bandid'],
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
" let g:ale_fix_on_save = 1

nnoremap ]r :ALENextWrap<CR>     " move to the next ALE warning / error
nnoremap [r :ALEPreviousWrap<CR> " move to the previous ALE warning / error

" show full message of ALE
nnoremap <leader>d :ALEDetail<cr>

" ----------------------------------------------------------------------------
" Coc
" ----------------------------------------------------------------------------

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [r <Plug>(coc-diagnostic-prev)
" nmap <silent> ]r <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" ============================
" CUSTOM MAPPINGS
" ============================
inoremap jj <Esc>
nnoremap <space> za
nnoremap <CR> :noh<CR>
" nnoremap <BS> :only<CR>

map - :NERDTreeToggle<CR>
map <Leader>n :NERDTreeFind<CR>

" System
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :bd<CR>
nnoremap <Leader>o :tabo<CR>

" Navigate tabs
" nnoremap <C-j> :tabnext<CR>
" nnoremap <C-k> :tabprev<CR>

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
