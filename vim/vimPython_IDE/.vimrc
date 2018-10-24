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
set laststatus=2
" set cmdheight=2
set nowrap "不换行
" set wrap
set autoread
set hlsearch
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,gb2312,chinese,cp936
set ambiwidth=double
set colorcolumn=120
set cursorcolumn
set cursorline
set t_Co=256

filetype on

if has("gui_running")
  " set linespace=10
  set guioptions-=T
  set guioptions-=m
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R

  if has("win32")
    set guifont=YaHei_Consolas_Hybrid:h11
    au GUIEnter * simalt ~x
  else
    set guifont=YaHei-Consolas-Hybrid:h14
  endif
endif

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
let maplocalleader=','

set nocompatible              " be iMproved, required
filetype off                  " required

if has("win32") || has("win64")
  set rtp+=$VIM/vimfiles/bundle/Vundle.vim
  call vundle#begin('$VIM/vimfiles/bundle/')
else
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
endif

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'joshdick/onedark.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'
Plugin 'cocopon/iceberg.vim'

" 中文文档
Plugin 'yianwillis/vimcdoc'

Plugin 'sheerun/vim-polyglot' " 语法高亮

" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'
Plugin 'Lokaltog/vim-powerline'

if has("python") || has("python3")
  Plugin 'davidhalter/jedi-vim'
endif

Plugin 'scrooloose/nerdtree'

Plugin 'majutsushi/tagbar'

" 语法检查，异步高性能。
Plugin 'w0rp/ale'

Plugin 'jiangmiao/auto-pairs'
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'

Plugin 'bling/vim-bufferline'
Plugin 'mhinz/vim-startify'

Plugin 'vim-scripts/octave.vim--'

Plugin 'Shougo/neocomplete.vim'

" markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

if v:version >= 800
  Plugin 'Tianer1123/python-run.vim'
endif

call vundle#end()            " required
filetype plugin indent on    " required

syntax enable
set background=dark
" colorscheme onedark
colorscheme gruvbox
" colorscheme iceberg
" let g:solarized_termcolors=256
" colorscheme solarized

" let g:airline_theme='gruvbox'
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
let g:Powerline_symbols = 'compatible'
" let g:Powerline_symbols = 'fancy'

let g:neocomplete#enable_at_startup = 1

"NERDTree Settings{
  augroup nerdtree_cmd
    autocmd!
    autocmd VimEnter * NERDTree

    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

    autocmd VimEnter * wincmd w
  augroup END
    let NERDTreeWinPos = "left"

    map <F4> :silent! NERDTreeToggle<CR>

    " let g:NERDTreeDirArrowExpandable = '▸'
    " let g:NERDTreeDirArrowCollapsible = '▾'

"}
let g:bufferline_echo = 1
if v:version >= 800
  let g:python_run_python_version = 3
endif
set conceallevel=2
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['js=javascript']

" tagbar Settings {{{
  " 打开vim时，打开Tagbar
augroup tagbar_cmd
  autocmd!
  autocmd FileType * nested :call tagbar#autoopen(0)
augroup END
  let g:tagbar_width = 30
" }}}

" =======================自定义映射===========================

" 将 jk 映射成 <esc> 。如果不习惯可以映射将 <esc> 映射成空 inoremap <esc> <Nop>，这样练习映射。
inoremap jk <esc>

" 映射<leader>ev，纵向分屏打开vimrc文件
nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
" 映射<leader>sv, 使vimrc立即生效
nnoremap <leader>sv :source $MYVIMRC<cr>

" 插入模式下按 ctrl + u 将光标下的单词转换成大写
inoremap <c-u> <esc>viwUea
" normal模式下 ctrl + u 将光标下的单词转换成大写
" nnoremap <c-u> viwU

" ,_ 向上移动一上
nnoremap <Leader>_ ddkkp
" ,- 向下移动一行
nnoremap <Leader>- ddp

" 在普通模式按 ,' 在光标所在单词上加上单引号,并将光标移动到单词尾.
nnoremap <Leader>' viw<esc>a'<esc>hbi'<esc>lel
" 在可视模式下按 ,v" 在光标选中的字符两边加上双引号,保留在可视模式.
vnoremap <Leader>v" <esc>a"<esc>hbi"<esc>`<lv`>l

" 映射按键映射到一个邮箱。
onoremap in@ :<c-u>execute "normal! /\\w\\+@\\w\\+.\\w\\+\r:nohlsearch\rveeeee"<cr>

" =======================自定义自动命令=======================
augroup self_def_cmds
  autocmd!
  " 自动命令在每次 source ~/.vimrc 的时候，会重新多定义一份自动命令，而不是覆盖。

  " python Settings
  autocmd FileType python,py set tabstop=4
  autocmd FileType python,py set softtabstop=4
  autocmd FileType python,py set shiftwidth=4
  " markdown Settings
  autocmd FileType markdown,md set tabstop=4
  autocmd FileType markdown,md set softtabstop=4
  autocmd FileType markdown,md set shiftwidth=4

  autocmd BufNewFile,BufRead * nnoremap <buffer> <Leader>dt :call InsertDate_md()<CR>

  autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
  autocmd Filetype python     nnoremap <buffer> <localleader>c I#<esc>

  autocmd FileType python     :iabbrev <buffer> iff if:<left>
  autocmd FileType javascript :iabbrev <buffer> iff if ()<left>

  " 在保存vimrc时自动source
  autocmd BufWritePost $MYVIMRC source %

  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
                      \ | execute "normal! g`\"^"
                      \ | endif
augroup END
" =======================自定义MyFunction=====================

function! InsertDate_md() "{{{
  let resDate = split(execute("!date", "silent"), "\n")
  let resList = split(resDate[1], " ")
  " let filee = expand("%:e")
  " if filee ==? "md" || filee ==? "markdown"
  if &ft ==? "md" || &ft ==? "markdown"
    execute "normal! aDate: " . resList[0] . " `" . resList[1] . "`\<esc>"
  else
    execute "normal! aDate: " . resList[0] . " " . resList[1] . "\<esc>"
  endif
endfunction "}}}

