set nobackup
set nu
set hidden
set ignorecase
set incsearch
set smartcase
set showmatch
set autoindent
set noerrorbells
set showcmd
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=2
set cmdheight=2
set nowrap "不换行
set autoread
set hlsearch
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,gb2312,chinese,cp936
set ambiwidth=double
set colorcolumn=80
set t_Co=256

inoremap jk <esc>

filetype on
autocmd FileType python,py set tabstop=4
autocmd FileType python,py set softtabstop=4
autocmd FileType python,py set shiftwidth=4

if has("cscope")
  set cscopetag
  set csto=0
  if filereadable("cscope.out")
    cs add cscope.out
  elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
  endif
endif

let mapleader=','
" 映射<leader>ev，纵向分屏打开vimrc文件
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" 映射<leader>sv, 使vimrc立即生效
" nnoremap <leader>sv :source $MYVIMRC<cr>
" 在保存vimrc时自动source
augroup autosourcing
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END


set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'joshdick/onedark.vim'
Plugin 'sheerun/vim-polyglot' " 语法高亮

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'davidhalter/jedi-vim'

Plugin 'scrooloose/nerdtree'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'

" 语法检查，异步高性能。
Plugin 'w0rp/ale'

Plugin 'jiangmiao/auto-pairs'
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'


call vundle#end()            " required
filetype plugin indent on    " required

syntax enable
set background=dark
colorscheme gruvbox
" let g:solarized_termcolors=256
" colorscheme solarized

let g:airline_theme='onedark'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" let g:jedi#use_tabs_not_buffers = 1 
let g:jedi#use_splits_not_buffers = 'right' " right top bottom winwidth

"NERDTree Settings{
  autocmd VimEnter * NERDTree

  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

  let NERDTreeWinPos = "left"
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

  autocmd VimEnter * wincmd w

  map <F4> :silent! NERDTreeToggle<CR>

  let g:NERDTreeDirArrowExpandable = '▸'
  let g:NERDTreeDirArrowCollapsible = '▾'

"}

"let g:ale_sign_error = '✗'
"let g:ale_sign_warning = '!'
"   'python': ['flake8', 'pylint'],
" pip3 install flake8
let g:ale_linters = {
      \   'c++': ['clang'],
      \   'c': ['clang'],
      \   'python': ['flake8'],
      \}


let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
" you can add these colors to your .vimrc to help customizing
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'
let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['py'] = s:blue " sets the color of css files to blue

let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files
