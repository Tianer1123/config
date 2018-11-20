" Vundle Plugins {{{
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

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'Lokaltog/vim-powerline'

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

" Plugin 'bling/vim-bufferline'
Plugin 'mhinz/vim-startify'

Plugin 'vim-scripts/octave.vim--'

Plugin 'Shougo/neocomplete.vim'

" markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

if v:version >= 800
  Plugin 'Tianer1123/python-run.vim'
endif

Plugin 'junegunn/vader.vim'

call vundle#end()            " required
filetype plugin indent on    " required

syntax enable
" }}}

" colorscheme Settings {{{
" colorscheme onedark
set background=dark
" set background=light
" colorscheme gruvbox
" colorscheme iceberg
" let g:solarized_termcolors=256
colorscheme solarized
" }}}

" powerline Settings {{{
" let g:airline_theme='gruvbox'
let g:airline_theme='solarized'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#buffer_nr_show = 1
" }}}

" neocomplete 补全配置 {{{
let g:neocomplete#enable_at_startup = 1
" }}}

"NERDTree Settings {{{
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
" }}}

"  杂项其他 {{{
let g:bufferline_echo = 1
if v:version >= 800
  let g:python_run_python_version = 3
endif
" }}}

" markdown相关配置 {{{
set conceallevel=2
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['js=javascript']
" }}}

" tagbar Settings {{{
  " 打开vim时，打开Tagbar
augroup tagbar_cmd
  autocmd!
  autocmd FileType * nested :call tagbar#autoopen(0)
augroup END
  let g:tagbar_width = 30
" }}}
