" =================
" PLUGINS
" =================
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'           " Navigation tree
Plug 'Nopik/vim-nerdtree-direnter'   " Fix for opening files and directories in tabs
Plug 'jiangmiao/auto-pairs'          " Auto-insert paired symbols

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'morhetz/gruvbox' " colorscheme

Plug 'itchyny/lightline.vim'

Plug 'tpope/vim-commentary' " commenting

" Plug 'tpope/vim-endwise'             " Auto-closing language-specific constructs
" Plug 'alvan/vim-closetag'            " Auto-close for HTML tags

" Git
Plug 'tpope/vim-fugitive'     " Git utils (I mostly only use annotate)
Plug 'airblade/vim-gitgutter' " Shows what is changed in a sidebar

" *** JavaScript ***
" Plug 'pangloss/vim-javascript'    " JavaScript support ⭐3.4K
" Plug 'othree/yajs.vim', { 'for': 'javascript' }  " ⭐670

" *** TypeScript ***
Plug 'HerringtonDarkholme/yats.vim' " Syntax ⭐500
" Plug 'leafgarland/typescript-vim' " TypeScript syntax ⭐1.6K

" *** JSX ***
Plug 'maxmellon/vim-jsx-pretty' " JS and JSX syntax
" https://github.com/ianks/vim-tsx

" *** Markdown ***
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'

call plug#end()

" =================
" SETTINGS
" =================
set number
set clipboard^=unnamedplus " Use the system register for everything
let mapleader = "\<Space>"
set shiftround tabstop=2 shiftwidth=2 expandtab  " use spaces instead of tabs
set splitbelow splitright
colorscheme gruvbox

autocmd FileType markdown setlocal spell

au BufNewFile,BufRead *.json.jbuilder set ft=ruby " add jbuilder syntax highlighting

" Folds
set foldmethod=indent   " fold based on indent
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max

autocmd FileType vim setlocal foldmethod=marker

" -------------------------------------
"  Lightline
" -------------------------------------
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
\ },
\ 'component_function': {
\   'cocstatus': 'coc#status'
\ },
\ }

  " Use auocmd to force lightline update.
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" ----------------------------------------------------------------------------
" NerdTree
" ----------------------------------------------------------------------------
let NERDTreeShowHidden=1 " Always show dot files
let NERDTreeQuitOnOpen=1
let g:NERDTreeMapOpenInTab = '<ENTER>'
let g:NERDTreeWinPos = "right"
map <Leader>- :NERDTreeToggle<CR>
map <Leader>n :NERDTreeFind<CR>

" =================
" FZF
" =================
let g:fzf_action = {
       \ 'enter': 'tab split',
       \ 'ctrl-x': 'split',
       \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~40%'  }
nnoremap <Leader><Leader> :Files<cr>
" nnoremap // :Buffers<cr>
nnoremap <Leader>f :Rg <C-R><C-W><cr>
vnoremap <Leader>f y:Rg <C-R>"<cr>
noremap <Leader><cr> :Fzfc<cr>
noremap <Leader>c :Commands<cr>
nnoremap <C-F> :Rg<Space>

" List changed and new files
command! Fzfc call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --others --modified'}))

" =================
" COC.VIM
" =================
set cmdheight=2
set updatetime=300
set shortmess+=c
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>r <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setlocal formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>0  <Plug>(coc-codeaction-selected)
nmap <leader>0  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>8  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>9  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" ==== MY COC VIM STUFF ===
nmap <leader>i :CocCommand tsserver.organizeImports<cr>


" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile


" =========================
" ======== Snippets =======
" =========================
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'


" =================
" MY CUSTOM MAPPINGS
" =================
inoremap jj <esc>
nnoremap <leader>w :w<CR>
" nnoremap <leader>q :q<CR>
nnoremap <cr> :noh<CR>

" Source Vim configuration file and install plugins
nnoremap <silent><leader>1 :source $MYVIMRC \| :PlugInstall<CR>

" Close other tabs
nnoremap <silent><leader>o :tabo<CR>

" Fold/unfold
nnoremap - za

" Git blame
nnoremap <leader>a :Gblame<cr>

" copy file path to the clipboard
nnoremap <leader>p :let @+ = expand("%")<cr>

" Select the whole file
nnoremap Q ggVG

nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" =================
" MY CUSTOM ABBREVIATIONS
" =================
iabbrev adn and
