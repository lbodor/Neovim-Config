set termguicolors
color Tomorrow-Night

call plug#begin('~/.local/share/nvim/plugged')
Plug 'gcmt/taboo.vim'
Plug 'airblade/vim-gitgutter'
Plug 'LnL7/vim-nix'
Plug 'Valloric/ListToggle'
Plug 'ludovicchabant/vim-gutentags'
Plug 'metakirby5/codi.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/gv.vim'
Plug 'itchyny/lightline.vim'
Plug 'neomake/neomake'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'will133/vim-dirdiff'
Plug 'dhruvasagar/vim-table-mode'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'aklt/plantuml-syntax'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'tpope/vim-ragtag'
Plug 'shougo/vimproc'
Plug 'leafgarland/typescript-vim'
Plug 'mhinz/vim-grepper'
Plug 'Quramy/tsuquyomi'
Plug 'tpope/vim-unimpaired'
Plug '~/.local/share/nvim/plugged/eclim'
Plug 'davidhalter/jedi-vim'
Plug 'mileszs/ack.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'eagletmt/neco-ghc'
Plug 'JamshedVesuna/vim-markdown-preview'
call plug#end()


let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='firefox'
let vim_markdown_preview_pandoc=1
let vim_markdown_preview_use_xdg_open=1

let g:LanguageClient_serverCommands = {
    \ 'haskell': ['hie', '--lsp'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
\ }
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gf :call LanguageClient_textDocument_rangeFormatting()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
let g:LanguageClient_diagnosticsList = 'Quickfix'
let g:LanguageClient_diagnosticsEnable = 1

set signcolumn=yes

" Completion
" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
let g:deoplete#max_menu_width = 80
inoremap <expr> <C-Space>  deoplete#mappings#manual_complete()

" Neco-ghc
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse = 1

let g:neomake_haskell_enabled_makers = [ ] 
let g:neomake_java_enabled_makers = [ ]
let g:neomake_typescript_enabled_makers = [ 'tslint' ]

let g:neomake_sh_shellcheck_args = ['-fgccx']

" autocmd Filetype typescript setlocal shiftwidth=2
let g:tsuquyomi_disable_default_mappings = 1
nmap <Leader>td :TsuDefinition<CR>
nmap <Leader>tt :TsuGoBack<CR>
nmap <Leader>tr :TsuReferences<CR>

function! DisableEclimXmlAugroup()
    augroup eclim_xml
        autocmd!
    augroup END
endfunction

autocmd FileType typescript :call DisableEclimXmlAugroup()

set mouse=

let g:lightline = { 'colorscheme': 'jellybeans' }

set expandtab
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent
set noswapfile

set hidden

autocmd FileType mvn_pom :set indentexpr=""

nmap <C-j> jzz
nmap <C-k> kzz

" edit file in the same directory
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>

" saveas file in the same directory
map ,s :saveas <C-R>=expand("%:p:h") . "/" <CR>

" find tag
map ,, :tag <C-R>="" <CR>

" spread out and insert (requires vim-unimpaired)
map []<space> [<space>k]<space>o
map ][<space> ]<space>j[<space>O

" invert comments (requires tomtom/tcomment_vim)

let @i = 'gcc'
map gci :normal @i<CR>

" (requires eclim)
imap <C-i> <C-o>:JavaImport<CR><C-o>A
nmap <C-i> :JavaImport<CR>
let g:EclimCompletionMethod = 'omnifunc'

" vimdiff colors
highlight DiffAdd cterm=none ctermfg=fg ctermbg=darkCyan gui=none guifg=fg guibg=Blue
highlight DiffDelete cterm=none ctermfg=fg ctermbg=darkCyan gui=none guifg=fg guibg=Blue
highlight DiffChange cterm=none ctermfg=fg ctermbg=darkCyan gui=none guifg=fg guibg=Blue
highlight DiffText cterm=none ctermfg=bg ctermbg=White gui=none guifg=bg guibg=White

nmap <Leader>s :source ~/.config/nvim/init.vim

" searching
set incsearch
noremap <silent><C-c> :noh<CR>
highlight Search ctermbg=black ctermfg=gray
highlight Visual ctermfg=black ctermfg=white
highlight Normal ctermfg=black ctermfg=gray

" switch back-and-forth between Code.java and CodeTest.java
function! Test()
    if @% =~ 'Test.java$'
        let l:test = substitute(substitute(@%, '/test/', '/main/', ''), 'Test.java$', '.java', '')
    else
        let l:test = substitute(substitute(@%, '/main/', '/test/', ''), '.java$', 'Test.java', '')
    endif
    execute 'edit' l:test
endfunction

:command! Test :call Test()

set tags=tags;/,codex.tags;/

autocmd! BufWritePost * Neomake

let g:neomake_place_signs = 1

let g:neomake_error_sign = {
	\ 'text': '>',
	\ 'texthl': 'WarningMsg',
	\ }

let g:neomake_warning_sign = {
	\ 'text': '>',
	\ 'texthl': 'WarningMsg',
	\ }

let g:neomake_place_sings = 1
nnoremap <Leader>p :FZF<CR>
nnoremap <Leader>b :Buffers<CR>

command! Buffers call fzf#run(fzf#wrap(
    \ {'source': map(range(1, bufnr('$')), 'bufname(v:val)')}))

set wildmode=longest,list
set completeopt=menu,longest

let g:inccommand = "split"

set autoindent
