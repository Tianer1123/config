" vim pulg Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'cocopon/iceberg.vim'

" 中文文档
Plug 'yianwillis/vimcdoc'

Plug 'sheerun/vim-polyglot' " 语法高亮

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'Lokaltog/vim-powerline', { 'branch': 'develop' }

if has("python") || has("python3") || has("nvim")
  Plug 'davidhalter/jedi-vim'
endif

Plug 'scrooloose/nerdtree'

Plug 'majutsushi/tagbar'

" 语法检查，异步高性能。
Plug 'w0rp/ale'

Plug 'jiangmiao/auto-pairs'
Plug 'kien/ctrlp.vim'
Plug 'ervandew/supertab'

" Plug 'bling/vim-bufferline'
Plug 'mhinz/vim-startify'

Plug 'vim-scripts/octave.vim--'

Plug 'Shougo/neocomplete.vim'

" markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

if v:version >= 800
  Plug 'Tianer1123/python-run.vim'
endif

Plug 'junegunn/vader.vim'

" git 插件
Plug 'tpope/vim-fugitive'

call plug#end()            " required

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

" airline Settings {{{
" let g:airline_theme='gruvbox'
let g:airline_theme='solarized'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_nr_show = 1
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'
let airline#extensions#ale#show_line_numbers = 1
let airline#extensions#ale#open_lnum_symbol = '(L'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#format = 1

let airline_branch_empty_messages = ['NOP']
let g:airline#extensions#branch#empty_message = airline_branch_empty_messages[0]

" 设置buf切换的快捷键
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
" }}}

" powerline settings {{{
" let g:Powerline_symbols = 'fancy'
" let g:Powerline_theme = 'solarized256'
" let g:Powerline_colorscheme = 'solarized'
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
" augroup tagbar_cmd
"   autocmd!
"   autocmd FileType * nested :call tagbar#autoopen(0)
" augroup END
let g:tagbar_width = 30
map <F3> :sile! TagbarToggle<CR>
" }}}
