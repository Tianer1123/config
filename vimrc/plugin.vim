" vim pulg Plugins {{{
call plug#begin('~/.vim/plugged')

" ColorScheme
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'
" Plug 'liuchengxu/space-vim-dark'
Plug 'morhetz/gruvbox'
Plug 'cocopon/iceberg.vim'

" 中文文档
Plug 'yianwillis/vimcdoc'

" Plug 'sheerun/vim-polyglot' " 语法高亮

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
" Plug 'ervandew/supertab'

" Plug 'bling/vim-bufferline'
Plug 'mhinz/vim-startify'

Plug 'vim-scripts/octave.vim--'

" Plug 'Shougo/neocomplete.vim'

" markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

if v:version >= 800
  Plug 'Tianer1123/python-run.vim'
endif

" vimscript 练习上传文件插件
Plug 'junegunn/vader.vim'

" git 插件
Plug 'tpope/vim-fugitive'

" YouCompleteMe
Plug 'Valloric/YouCompleteMe'

" 补全参数
Plug 'tenfyzhong/CompleteParameter.vim'

call plug#end()            " required

" }}}

" colorscheme Settings {{{
set background=dark
" set background=light
" colorscheme onedark
" set background=light
" colorscheme gruvbox
" colorscheme space-vim-dark
" colorscheme iceberg
colorscheme solarized
" }}}

" ale Settings {{{
let g:ale_set_highlights = 0
let g:ale_sign_error = "✗"
let g:ale_sign_warning = "⚡"
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" 使用ale检查语法，不使用ycm。
let g:ycm_show_diagnostics_ui = 0
let g:ale_echo_cursor = 0
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
let airline#extensions#ale#error_symbol = '✗'
let airline#extensions#ale#warning_symbol = '⚡'
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
" let g:neocomplete#enable_at_startup = 1
" }}}

"NERDTree Settings {{{
augroup nerdtree_cmd
  autocmd!
  " autocmd VimEnter * NERDTree

  autocmd StdinReadPre * let s:std_in=1
  " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

  autocmd VimEnter * wincmd w
augroup END

let NERDTreeWinPos = "left"

map <F4> :NERDTreeToggle<CR>

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
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
let g:vim_markdown_new_list_item_indent = 2
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

" YouComplete Settings {{{
set completeopt=longest,menu
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '✗'
let g:ycm_warning_symbol = '⚡'
let g:ycm_python_interpreter_path = '/Library/Frameworks/Python.framework/Versions/3.6/bin/python3'
let g:ycm_python_sys_path = ['/Library/Frameworks/Python.framework/Versions/3.6/bin/python3']
let g:ycm_complete_in_comments = 1
" 强制显示语义提示
let g:ycm_key_invoke_completion = '<C-z>'
" }}}

" CompleteParameter Settings {{{
inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
" auto pairs 映射的( 跟这个插件有冲突，官网这样设置即可。
let g:AutoPairs = {'[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
inoremap <buffer><silent> ) <C-R>=AutoPairsInsert(')')<CR>
" }}}
