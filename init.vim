color Tomorrow-Night

call plug#begin('~/.local/share/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'LnL7/vim-nix'
Plug 'Valloric/ListToggle'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf'
Plug 'itchyny/lightline.vim'
Plug 'neomake/neomake'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'shougo/vimproc'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'eclim'
call plug#end()

let g:neomake_java_enabled_makers = [ ]
let g:neomake_typescript_enabled_makers = [ 'tslint' ]

let g:neomake_sh_shellcheck_args = ['-fgccx']

autocmd Filetype typescript setlocal shiftwidth=2
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

nnoremap <C-p> :FZF<CR>
set wildmode=longest,list
set completeopt=menu,longest

let g:inccommand = "split"

set autoindent
