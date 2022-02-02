" =================
" PLUGINS
" =================
call plug#begin('~/.vim/plugged')

" === EXTENSIONS ===
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank' " highlights whatever you just yanked
Plug 'tpope/vim-commentary'          " commenting
Plug 'machakann/vim-sandwich'
Plug 'andymass/vim-matchup'
Plug 'jiangmiao/auto-pairs'          " Auto-insert paired symbols
" Plug 'github/copilot.vim'
Plug 'tpope/vim-endwise'             " Auto-closing language-specific constructs
Plug 'alvan/vim-closetag'            " Auto-close for HTML tags
Plug 'preservim/nerdtree'

" === VISUAL ===
Plug 'sainnhe/everforest' " colorscheme
Plug 'itchyny/lightline.vim'

" === Git ===
Plug 'tpope/vim-fugitive'     " Git utils (I mostly only use annotate)
Plug 'airblade/vim-gitgutter' " Shows what is changed in a sidebar

" === MISC ===
Plug 'plasticboy/vim-markdown'
Plug 'shime/vim-livedown'
Plug 'HerringtonDarkholme/yats.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" =================
" SETTINGS
" =================
set number
set clipboard^=unnamedplus " Use the system register for everything
let mapleader = "\<Space>"
set shiftround tabstop=2 shiftwidth=2 expandtab  " use spaces instead of tabs
set cindent
set smartindent
set splitbelow splitright

" Important!!
if has('termguicolors')
  set termguicolors
endif

" For dark version.
set background=dark

" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'medium'

colorscheme everforest

autocmd FileType markdown setlocal spell

au BufNewFile,BufRead *.json.jbuilder set ft=ruby " add jbuilder syntax highlighting

" Folds
set foldmethod=indent   " fold based on indent
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max

autocmd FileType vim setlocal foldmethod=marker

let g:endwise_no_mappings=1

" -------------------------------------
"  Lightline
" -------------------------------------
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'readonly', 'filename', 'modified' ] ]
\ }
\ }

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
" NERDTree
" =================
let g:NERDTreeWinPos = "right"
nnoremap <Leader>n :NERDTreeFind<cr>

" =================
" COC
" =================

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved.
" if has("nvim-0.5.0") || has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif

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

inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>r <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>0  :CocAction<cr>

" Run the Code Lens action on the current line.
nmap <leader>9  <Plug>(coc-codelens-action)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
nmap <leader>i :OR<cr>

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" " Mappings for CoCList
" " Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


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
