" Help:
"
" ZS  = save current file
" ZA  = save all opened files
" QQ  = quit all opened files
" F2  = paste toggle
" F3  = save session (uses unite-session)
" F4  = clear hl search
" F5  = Gundo toggle
" F5  = (insert mode) ticker from branch name
" F6  = Next syntastic error (S-F6 = previous error)
" F7  = FSSplit left
" F8  = FSHere
" F9  = convert current file to utf-8
" F10 = run flake8-vim
" C-Space = YouCompleteMe
" CapsLock = toggle insert/normal mode
" + = expand region
" _ = shrink region
" up,down,left,right = move through splits
" C-[j,k,h,l] = move through splits AND tmux
" f = leader
"   EasyMotion
"   <leader>w =  forward
"   <leader>b =  backward
"   <leader>j =  line down
"   <leader>k =  line up
"   Unite
"   <leader>i = open from current-dir
"   <leader>r = open recursive
"   <leader>m = open Most Recent Used
"   <leader>p = open from all (buffer, MRU, bookmark, recursive)
"   <leader>h = open buffer
"   <leader>y = history/yank
"   <leader>/ = grep
"   <leader>o = outline
"   <leader>*word = grep search for word (word under cursor)
"   <leader>,g = git grep
"       <C-s> (in buffer) = horizontally split file
"       <C-v> (in buffer) = vertically split file
"       <C-r> (in buffer) = replace window with file
"   <leader>s = session
"   nerdcommenter
"   <leader>c<space> = comment/uncomment
"   <leader>y<space> = copy and comment
"   vim-indent-guides
"   <leader>ig = toggle indent guides
" // = search visual selected text
" C-_ = insert pydocstring (normal mode)
" UltiSnips
"   C-l = expand
"   C-h = list
"   C-j = jump forward
"   C-k = jump backward


set nocompatible


" bind caps lock (F16) to toggle insert/command mode
nmap [29~ <F16>
imap [29~ <F16>
vmap [29~ <F16>
nnoremap <silent><F16> :startinsert <CR>
inoremap <silent><F16> <Esc>l
vnoremap <silent><F16> <Esc>


" adios C-c!
nnoremap <c-c> <NOP>
inoremap <c-c> <NOP>
vnoremap <c-c> <NOP>


" use F2 to paste toggle
set pastetoggle=<F2>
" clear hl search
nnoremap <F4> :nohl<CR>
" convert to utf-8
nnoremap <F9> :e ++enc=utf-8<CR>
" save
nnoremap ZS :w<CR>
" save all
nnoremap ZA :wa<CR>
" quit all
nnoremap QQ :qa<CR>

" map leader to ','
let mapleader = "f"
let g:mapleader = "f"
" fast movement through splits
map <up> <c-w>k
map <down> <c-w>j
map <left> <c-w>h
map <right> <c-w>l


" vundle | git://github.com/gmarik/vundle.git
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim
filetype plugin indent on


" bundles
source $HOME/.vim/bundles.vim


if !has('nvim')
    " powerline
    set rtp+=$HOME/downloads/GIT/powerline/powerline/bindings/vim
endif


" basic setup
syntax on
set mouse-=a
set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines
set nu " line numbering
set cursorline
set backspace=indent,eol,start
set browsedir=current
set ruler
set wildignore=*.o,*.e,*~
set wildignorecase
set wildmenu
set showmatch
set ignorecase
set smartcase
set scrolloff=5
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set laststatus=2
set ffs=unix,dos,mac
set clipboard+=unnamedplus
set noshowmode


set t_ut=


" use # as comment on python files
au BufRead,BufNewFile *.py set nosmartindent


" doxygen syntax
let g:load_doxygen_syntax=1


" indent
set list listchars=tab:\└─,trail:•,extends:»,precedes:«,nbsp:×


" completion menu conf
set conceallevel=2
set concealcursor=vin
set completeopt=menu,menuone,longest,preview
set pumheight=20 " Limit popup menu height

highlight clear SignColumn

" restore the cursor on the last line of the file
if !has('nvim')
    set viminfo='10,\"100,:20,%,n~/.viminfo'
endif

if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
endif
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

" backups
set backup

" seach
set incsearch
set hlsearch

" limit at column 80
set colorcolumn=80
set updatetime=750
set ssop-=options
set modeline

" damn delay
set ttimeoutlen=0
augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=10
    au InsertLeave * set timeoutlen=1000
augroup END


" search visual selected text
vnoremap // y/<C-R>"<CR>"


" temp fix; brew scp is not working to access servers :/
let g:netrw_scp_cmd="/usr/bin/scp"


" extract ticket information from branch name (jira)
imap <buffer><expr> <F5> GitTicketFromBranch()
function! GitTicketFromBranch()
    return system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //' | cut -d'/' -f2 | cut -d'-' -f1-2 | tr -d '\n'")
endfunction
