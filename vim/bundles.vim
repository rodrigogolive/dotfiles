" Installation

filetype off
call vundle#begin()

" Vundle | https://github.com/VundleVim/Vundle.vim
Plugin 'gmarik/Vundle.vim'


" GitGutter | https://github.com/airblade/vim-gitgutter
Plugin 'airblade/vim-gitgutter'


" EasyMotion | https://github.com/Lokaltog/vim-easymotion
Plugin 'Lokaltog/vim-easymotion'


" YouCompleteMe | https://github.com/Valloric/YouCompleteMe
Plugin 'Valloric/YouCompleteMe'


" SnipMate dependencies
" https://github.com/MarcWeber/vim-addon-mw-utils
Plugin 'MarcWeber/vim-addon-mw-utils'
" https://github.com/tomtom/tlib_vim
Plugin 'tomtom/tlib_vim'
" https://github.com/honza/vim-snippets
Plugin 'honza/vim-snippets'
" SnipMate | https://github.com/garbas/vim-snipmate
Plugin 'garbas/vim-snipmate'


" vim-solarized | https://github.com/altercation/vim-colors-solarized
Plugin 'altercation/vim-colors-solarized'


" nerdcommenter | https://github.com/scrooloose/nerdcommenter
Plugin 'scrooloose/nerdcommenter'


" delimitMate | https://github.com/Raimondi/delimitMate
Plugin 'Raimondi/delimitMate'


" Unite | https://github.com/Shougo/unite.vim
Plugin 'Shougo/unite.vim'
" unite-outline | https://github.com/Shougo/unite-outline
Plugin 'Shougo/unite-outline'
" unite-session | https://github.com/Shougo/unite-session
Plugin 'Shougo/unite-session'
" neomru | https://github.com/Shougo/neomru.vim
Plugin 'Shougo/neomru.vim'
" vimproc | https://github.com/Shougo/vimproc.vim | NOTE: run 'make'
Plugin 'Shougo/vimproc.vim'


" vim-tmux-navigator | https://github.com/christoomey/vim-tmux-navigator
Plugin 'christoomey/vim-tmux-navigator'


" neosnippet | https://github.com/Shougo/neosnippet.vim
Plugin 'Shougo/neosnippet'
" neosnippet-snippets | https://github.com/Shougo/neosnippet-snippets
Plugin 'Shougo/neosnippet-snippets'


" context_filetype | https://github.com/Shougo/context_filetype.vim
Plugin 'Shougo/context_filetype.vim'


" FSwitch | https://github.com/vim-scripts/FSwitch
Plugin 'vim-scripts/FSwitch'


" Gundo | https://github.com/sjl/gundo.vim
Plugin 'sjl/gundo.vim'


" vim-qml | https://github.com/peterhoeg/vim-qml
Plugin 'peterhoeg/vim-qml'


" i3-vim-syntax | https://github.com/PotatoesMaster/i3-vim-syntax
Plugin 'PotatoesMaster/i3-vim-syntax'


" vim-polyglot | https://github.com/sheerun/vim-polyglot
Plugin 'sheerun/vim-polyglot'

call vundle#end()
filetype plugin indent on

" Configuration

" EasyMotion | https://github.com/Lokaltog/vim-easymotion
let g:EasyMotion_leader_key = '<Leader>'


" YouCompleteMe | https://github.com/Valloric/YouCompleteMe
"let g:ycm_key_invoke_completion = '<C-]>'
let g:ycm_confirm_extra_conf = 0
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_error_symbol = '‣'
let g:ycm_warning_symbol = '×'
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


" SnipMate | https://github.com/garbas/vim-snipmate
let g:snips_author = 'Rodrigo Oliveira'
imap <C-l> <esc>a<Plug>snipMateNextOrTrigger
smap <C-l> <esc>a<Plug>snipMateNextOrTrigger


" vim-solarized | https://github.com/altercation/vim-colors-solarized
syntax enable
set background=dark
colorscheme solarized


" Unite | https://github.com/Shougo/unite.vim
" unite-outline | https://github.com/Shougo/unite-outline
" unite-session | https://github.com/Shougo/unite-session
nnoremap <F3> :UniteSessionSave 
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#profile('default', 'context', {
    \'context.smartcase': 1,
    \'start_insert': 1,
    \'direction': 'below',
    \'prompt_direction': 'top',
    \'prompt': ' ',
    \'short_source_names': 1,
\})
call unite#custom#source('line,outline','matchers','matcher_fuzzy')
call unite#custom#default_action('file', 'tabopen')
call unite#custom#default_action('buffer', 'goto')
let g:unite_force_overwrite_statusline=0
let g:unite_source_history_yank_enable=1
let g:unite_source_file_mru_long_limit=3000
let g:unite_source_directory_mru_long_limit=3000
let g:unite_source_file_mru_limit=200
let g:unite_source_file_mru_filename_format=''
nnoremap <leader>* :UniteWithCursorWord -buffer-name=grep grep:.<cr>
nnoremap <leader>i :Unite -buffer-name=file file<cr>
nnoremap <leader>r :Unite -force-redraw -buffer-name=file_rec file_rec/async:!<cr>
nnoremap <leader>m :Unite -buffer-name=file_mru file_mru<cr>
nnoremap <leader>p :Unite -buffer-name=files buffer file_mru bookmark file_rec/async<cr>
nnoremap <leader>h :Unite -buffer-name=buffer buffer<cr>
nnoremap <leader>y :Unite -buffer-name=history_yank history/yank<cr>
nnoremap <leader>/ :Unite -buffer-name=grep grep:.<cr>
nnoremap <leader>o :Unite -buffer-name=outline -horizontal -direction=above outline<cr>
nnoremap <leader>s :Unite -no-split session<cr>
au FileType unite inoremap <buffer><expr> <C-s> unite#do_action('split')
au FileType unite nnoremap <buffer><expr> <C-s> unite#do_action('split')
au FileType unite inoremap <buffer><expr> <C-v> unite#do_action('vsplit')
au FileType unite nnoremap <buffer><expr> <C-v> unite#do_action('vsplit')
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
    nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction


" neosnippet | https://github.com/Shougo/neosnippet.vim
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
if has('conceal')
    set conceallevel=2 concealcursor=i
endif


" FSwitch | https://github.com/vim-scripts/FSwitch
nnoremap <F7> :FSSplitLeft<cr>
nnoremap <F8> :FSHere<cr>


" Gundo
nnoremap <F5> :GundoToggle<CR>
