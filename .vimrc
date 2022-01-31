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
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }

" main one
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" === VISUAL ===
Plug 'sainnhe/everforest' " colorscheme
Plug 'itchyny/lightline.vim'

" === Git ===
Plug 'tpope/vim-fugitive'     " Git utils (I mostly only use annotate)
Plug 'airblade/vim-gitgutter' " Shows what is changed in a sidebar

" === MISC ===
Plug 'plasticboy/vim-markdown'
Plug 'shime/vim-livedown'

" requires nvim > 0.5
" Plug 'kyazdani42/nvim-web-devicons' " for file icons
" Plug 'kyazdani42/nvim-tree.lua'
" Plug 'hrsh7th/nvim-compe'
" Plug 'hrsh7th/vim-vsnip'
Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'mhartington/formatter.nvim'

call plug#end()

" =================
" SETTINGS
" =================
set number
set clipboard^=unnamedplus " Use the system register for everything
let mapleader = "\<Space>"
set shiftround tabstop=2 shiftwidth=2 expandtab  " use spaces instead of tabs
set splitbelow splitright
set completeopt=menuone,noselect " required by nvim-compe

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
" LSP
" =================
lua << EOF
local lspconfig = require("lspconfig")
local coq = require "coq" -- add this

local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end

lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({
    on_attach = function(client, bufnr)
      vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
      vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
      vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
      vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
      vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
      vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
      vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
      vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
      vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
      vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
      vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
      vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

      buf_map(bufnr, "n", "gd", ":LspDef<CR>")
      buf_map(bufnr, "n", "<Leader>r", ":LspRename<CR>")
      buf_map(bufnr, "n", "K", ":LspHover<CR>")
      buf_map(bufnr, "n", "[g", ":LspDiagPrev<CR>")
      buf_map(bufnr, "n", "]g", ":LspDiagNext<CR>")
      buf_map(bufnr, "n", "<Leader>0", ":LspCodeAction<CR>")
      buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
      buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")
      if client.resolved_capabilities.document_formatting then
          vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
      end
    end,
}))
EOF

" =================
" NERDTree
" =================
let g:NERDTreeWinPos = "right"
nnoremap <Leader>n :NERDTreeFind<cr>

" =================
" Vim prettier
" =================
" Allow auto formatting for files without "@format" or "@prettier" tag
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#exec_cmd_async = 1

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
