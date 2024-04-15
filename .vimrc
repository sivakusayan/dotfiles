set nocompatible

"================================================================================
"PLUGINS=========================================================================
"================================================================================

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/plugged')
Plugin 'VundleVim/Vundle.vim'

"General Plugins
Plugin 'sainnhe/everforest'
Plugin 'jiangmiao/auto-pairs'
Plugin 'sheerun/vim-polyglot'
Plugin 'preservim/nerdtree'
Plugin 'dyng/ctrlsf.vim'
Plugin 'mhinz/vim-startify'
Plugin 'tpope/vim-obsession'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/goyo.vim'

"C/C++ Plugins
Plugin 'derekwyatt/vim-fswitch'
Plugin 'rhysd/vim-clang-format'
Plugin 'vim-scripts/DoxygenToolkit.vim'

"JavaScript Plugins
Plugin 'prettier/vim-prettier'

"Go Plugins
Plugin 'fatih/vim-go'

"Clojure Plugins
Plugin 'guns/vim-sexp'
Plugin 'guns/vim-clojure-static'
"This is a fork since guns's repo is broken with fireplace 2.0
Plugin 'brandonvin/vim-clojure-highlight'
Plugin 'tpope/vim-fireplace'
Plugin 'venantius/vim-cljfmt'

call vundle#end()

"================================================================================
"GENERAL SETTINGS================================================================
"================================================================================

syntax on
filetype plugin indent on

set background=dark
set termguicolors
let g:everforest_background = 'hard'
let g:everforest_colors_override = {'bg0': ['#121517', '234']}
colorscheme everforest

set nu 
set tabstop=4
set shiftwidth=4
set expandtab
set incsearch
set splitbelow
set ai
set ruler
set exrc
set secure

"Tabbing shortcuts
nnoremap <C-p> :tabnext<cr>
nnoremap <C-o> :tabprevious<cr>
"Make sure Ctrl+PageUp still works for terminal mode
tnoremap <C-p> <C-\><C-n>:tabnext<cr>
tnoremap <C-o> <C-\><C-n>:tabprevious<cr>
"Remember to reset mode since we changed it when leaving the tab
autocmd BufWinEnter,WinEnter * if &buftype == 'terminal' | silent! normal i | endif

"Windowing shortcuts
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-n> :set invrelativenumber<CR>

let mapleader = "\\"

"Auto generate tags file on file write of *.c and *.h files
autocmd BufWritePost *.c,*.h silent! !ctags . &

"Hack to get meta key to work in gnome terminal
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw
set ttimeout ttimeoutlen=50

if has("gui_running")
  " Maximize gvim window
  set lines=999 columns=999
  set guioptions -=m
  set guioptions -=T
  set guioptions -=L
  set guioptions -=r
endif

"================================================================================
"PLUGIN SETTINGS=================================================================
"================================================================================

"NERDTree
let NERDTreeShowBookmarks = 1   " Show the bookmarks table
let NERDTreeShowHidden = 1      " Show hidden files
let NERDTreeShowLineNumbers = 0 " Hide line numbers
let NERDTreeMinimalMenu = 1     " Use the minimal menu (m)
let NERDTreeWinPos = 'left'     " Panel opens on the left side
let NERDTreeWinSize = 31        " Set panel width to 31 columns
nmap <F2> :NERDTreeToggle<CR>

"CtrlSF
let g:ctrlsf_backend = 'ack'
let g:ctrlsf_auto_close = { "normal":0, "compact":0 }
let g:ctrlsf_auto_focus = { "at":"start" }
let g:ctrlsf_auto_preview = 0
let g:ctrlsf_case_sensitive = 'smart'
let g:ctrlsf_default_view = 'normal'
let g:ctrlsf_regex_pattern = 0
let g:ctrlsf_position = 'right'
let g:ctrlsf_winsize = '46'
let g:ctrlsf_default_root = 'cwd'
nmap <C-F>f <Plug>CtrlSFPrompt
xmap <C-F>f <Plug>CtrlSFVwordPath
xmap <C-F>F <Plug>CtrlSFVwordExec
nmap <C-F>n <Plug>CtrlSFCwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

"Vim-Fswitch
au! BufEnter *.cpp let b:fswitchdst = 'h,hpp'
au! BufEnter *.cc let b:fswitchdst = 'h,hpp'
au! BufEnter *.hpp let b:fswitchdst = 'cpp,cc,c'
au! BufEnter *.h let b:fswitchdst = 'cpp,cc,c'
nmap <C-Z> :vsplit <bar> :wincmd l <bar> :FSRight<CR>

"vim-go
autocmd FileType go nmap <C-b>  <Plug>(go-build)
autocmd FileType go nmap <C-g>  <Plug>(go-run)
let g:go_fmt_command = "golines"

"YCM
noremap <leader>f :YcmCompleter FixIt<CR>
noremap <leader>n :lnext<CR>
noremap <leader>N :lprev<CR>
let g:ycm_always_populate_location_list = 1

"vim-llvm
augroup filetype
  au! BufRead,BufNewFile *.ll     set filetype=llvm
  au! BufRead,BufNewFile *.llx    set filetype=llvm
augroup END

"fzf
noremap <leader>s :GFiles<CR>
