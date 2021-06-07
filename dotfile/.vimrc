" 基本设置 {{{
set nu

" {{{ 会导致整个 buffger 重新绘制
set rnu
set cursorcolumn
set cursorline
" }}}
set ignorecase
set incsearch
set smartcase
set showmatch
set autoindent
set noerrorbells
set vb t_vb=
set showcmd
set tabstop=4
set softtabstop=4
set shiftwidth=4
" set expandtab
set backspace=2
set laststatus=2
" set cmdheight=2
" 设置自动换行 {{{
" set nowrap "不换行
set wrap
set cc=120
set textwidth=120
" }}}
set autoread
set hlsearch
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,gb2312,chinese,cp936
set ambiwidth=double
" set lazyredraw "should make scrolling faster

set termguicolors
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

filetype plugin indent on
syntax enable

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

" >4;2m in vim, this can fix it.
let &t_TI = ""
let &t_TE = ""

inoremap jk <esc>
" 复制到剪贴板和粘贴剪贴板内容
map Y "+y
map P "+p

augroup Self_def_cmds
	autocmd!
	" 打开vim时，光标移动到上次退出时的位置 {{{
	autocmd bufreadpost * if line("'\"") > 1 && line("'\"") <= line("$") && &ft !=# 'commit'
				\ | execute "normal! g`\""
				\ | endif
	" }}}


" c 家族语言不使用空格代替 tab， noet = noexpandtab。
" autocmd filetype c,C,cpp,Cpp,cxx,c++,h,hpp,hxx set noet

" tab 保持 8 个字符的距离，不再使用空格代替，由于 python
" 语法的问题，需要继续保留
" autocmd filetype python set tabstop=4
" autocmd filetype python set softtabstop=4
" autocmd filetype python set shiftwidth=4
" autocmd filetype python set expandtab
augroup end


" 映射<leader>ev，纵向分屏打开vimrc文件
nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
" 映射<leader>sv, 使vimrc立即生效
nnoremap <leader>sv :source $MYVIMRC<cr>

" 使用 ctrl + hjkl 上下左右切换 vim 窗口
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" 普通模式 ctrl + s 保存缓冲区
noremap <silent><C-s> <esc>:wa<cr>

" }}}

" plug {{{
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'

" 状态栏
" vim-airline 太耗性能，使用 lightline
Plug 'itchyny/lightline.vim'

" tab 缩进显示 比较耗性能
" Plug 'Yggdroot/indentLine'

Plug 'mhinz/vim-startify'

" Vim 图标
Plug 'ryanoasis/vim-devicons'

Plug 'neoclide/coc.nvim'

" 文件搜索工具
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'
" 文本搜索
Plug 'mhinz/vim-grepper'

" 给相同单词加下划线
Plug 'itchyny/vim-cursorword'
" 高亮单词 <leader>k 高亮，<leader>K 清除高亮
Plug 'lfv89/vim-interestingwords'

" 显示启动时间,命令:StartupTime
Plug 'dstein64/vim-startuptime'

" python 语法高亮
Plug 'vim-python/python-syntax'

" 补全括号
Plug 'jiangmiao/auto-pairs'

" 彩虹括号
Plug 'luochen1990/rainbow'

" <ENTER>选中括号中的内容
Plug 'gcmt/wildfire.vim'

" vim 中文文档
Plug 'yianwillis/vimcdoc'

" 显示空白字符
Plug 'ntpeters/vim-better-whitespace'

call plug#end()
" }}}

" 背景透明transparent bg
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

" gruvbox settings {{{
" set background=light
" set background=dark
colorscheme gruvbox
"

""" rainbow settings {{{
" 彩虹括号，用了段时间感觉作用也不是很大
let g:rainbow_active = 0
"}}}

" 中文设置 {{{
set enc=utf-8
" }}}

" coc.nvim settings {{{
" coc-jedi 依赖 jedi-language-server 自行安装
" pip3 install -U jedi-language-server
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-vimlsp',
    \ 'coc-jedi',
    \ 'coc-snippets',
    \ 'coc-syntax',
    \ 'coc-markdownlint',
    \ 'coc-yaml',
	\ 'coc-highlight',
    \ 'coc-clangd',
	\ 'coc-explorer']

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" 目录🌲，替代nerdtree , 使用 l 和 h 打开和关闭目录，使用 j 和 k 上下移动，使用 enter 进入目录
nnoremap <space>e :CocCommand explorer<CR>

" }}}


" fzf设置 {{{
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
" 在当前目录搜索文件
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
" 切换Buffer中的文件
" nnoremap <silent> <leader>b :Buffers<CR>
" 在当前所有加载的Buffer中搜索包含目标词的所有行，:BLines只在当前Buffer中搜索
" nnoremap <silent> <leader>p :Lines<CR>
" 在Vim打开的历史文件中搜索，相当于是在MRU中搜索，:History：命令历史查找
" nnoremap <silent> <leader>h :History<CR>
" }}}

" coc-fzf settings {{{
set mouse=a
nnoremap <silent> <space><space> :<C-u>CocFzfList<CR>
nnoremap <silent> <space>a       :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> <space>b       :<C-u>CocFzfList diagnostics --current-buf<CR>
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:coc_fzf_preview_toggle_key = 1
" }}}


" python-syntax settings {{{
let g:python_highlight_all = 1
" }}}


" auto-pairs settings {{{
" 开启 flayMode 智能补全括号
let g:AutoPairsFlyMode = 1
" }}}
