" 基本设置 {{{
set nu

" {{{ 会导致整个 buffger 重新绘制
" set rnu
" set cursorcolumn
" set cursorline
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
set cc=100
set textwidth=100
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

if has("gui_running")
  " set linespace=5
  set guioptions-=T
  set guioptions-=m
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R

  if has("win32")
    " set guifont=Consolas-with-Yahei:h18
    set guifont=JetBrainsMono_NF:h12
    au GUIEnter * simalt ~x
  elseif has("mac")
    " set guifont=Consolas-with-Yahei:h16
    set guifont=InconsolataNerdFontComplete-Medium:h18
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
" Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-gruvbox8'
" nord 主题作的很用心啊
Plug 'arcticicestudio/nord-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'sickill/vim-monokai'

" 状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'theniceboy/eleline.vim'
Plug 'ojroques/vim-scrollstatus'

" tab 缩进显示
Plug 'Yggdroot/indentLine'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

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

" 高亮c/c++函数等
" Plug 'octol/vim-cpp-enhanced-highlight'
" Plug 'jeaye/color_coded'
" Plug 'jackguo380/vim-lsp-cxx-highlight'

" python 语法高亮
Plug 'vim-python/python-syntax'

" 代码格式化
" Plug 'google/vim-maktaba'
" Plug 'google/vim-codefmt'

" 补全括号
Plug 'jiangmiao/auto-pairs'
" 彩虹括号
Plug 'luochen1990/rainbow'

" <ENTER>选中括号中的内容
Plug 'gcmt/wildfire.vim'

" 自动生成 tag 基于 ctags，所以还是需要安装 ctags。
" Plug 'ludovicchabant/vim-gutentags'

" buffer 切换 [b / ]b
" Plug 'mg979/vim-xtabline'

" 显示空白字符
Plug 'ntpeters/vim-better-whitespace'

call plug#end()
" }}}


" gruvbox settings {{{
" set background=light
set background=dark
" colorscheme nord
" colorscheme gruvbox8
colorscheme gruvbox8_hard
" colorscheme gruvbox8_soft
"
"{{{
" colorscheme solarized
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"
" let g:solarized_termtrans = 1
"}}}
"
" colorscheme monokai
" 终端 vim 中禁用粗体？黑体
" set t_md=
" }}}

" gruvbox8 settings {{{

" }}}

""" rainbow settings {{{
" 彩虹括号，用了段时间感觉作用也不是很大
let g:rainbow_active = 0
"}}}

" eleline.vim settings {{{
let g:eleline_powerline_fonts = 1
let g:scrollstatus = 12
let g:eleline_slim = 1
" let g:scrollstatus_symbol_track = '-'
" let g:scrollstatus_symbol_bar = '|'
let g:airline_section_x = '%{ScrollStatus()} '
let g:airline_section_y = airline#section#create_right(['filetype'])
" let g:airline_section_z = airline#section#create([
"             \ '%#__accent_bold#%3l%#__restore__#/%L', ' ',
"             \ '%#__accent_bold#%3v%#__restore__#/%3{virtcol("$") - 1}',
"             \ ])
let g:airline_section_z = airline#section#create([ ])
" }}}

" airline settings {{{
" gruvbox被删掉了？
" let g:airline_theme='gruvbox'
" let g:airline_theme='onedark'
" let g:airline_theme='nord'
let g:airline_theme='violet'
" let g:airline_theme='light'
" let g:airline_theme='powerlineish'
" let g:airline_theme='deus'
" let g:airline_theme='solarized'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif


" test {{{
" function! AccentDemo()
"   let keys = ['a','b','c','d','e','f','g','h']
"   for k in keys
"     call airline#parts#define_text(k, k)
"   endfor
"   call airline#parts#define_accent('a', 'red')
"   call airline#parts#define_accent('b', 'green')
"   call airline#parts#define_accent('c', 'blue')
"   call airline#parts#define_accent('d', 'yellow')
"   call airline#parts#define_accent('e', 'orange')
"   call airline#parts#define_accent('f', 'purple')
"   call airline#parts#define_accent('g', 'bold')
"   call airline#parts#define_accent('h', 'italic')
"   let g:airline_section_a = airline#section#create(keys)
" endfunction
" autocmd VimEnter * call AccentDemo()
" }}}


let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_nr_show = 1

" 使用终端设置大一点的行间距，nvim 表现的比较好，但是下面的 symbols
" 显示会有问题，去掉后 airline 显示即可。
" powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.maxlinenr = ''

" let g:airline#extensions#whitespace#enabled = 0

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#format = 1
let airline_branch_empty_messages = ['NOP']
let g:airline#extensions#branch#empty_message = airline_branch_empty_messages[0]

" 清除 airline 右侧不需要的告警信息
let g:airline_section_y = ''
let g:airline_section_error = ''
let g:airline_section_warning = ''

" }}}


"NERDTree Settings {{{
augroup nerdtree_cmd
    autocmd!
    " autocmd VimEnter * NERDTree
    " autocmd StdinReadPre * let s:std_in=1
    " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    " autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

    " autocmd VimEnter * wincmd w
augroup END

let NERDTreeWinSize = 25
"去除第一行的帮助提示
let NERDTreeMinimalUI=1

let NERDTreeWinPos = "right"

map <F4> :sile! NERDTreeToggle<CR>

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

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
let g:NERDTreeExtensionHighlightColor['css'] = s:blue " sets the color of css files to blue

let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files

let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb
" }}}


" tagbar Settings {{{
" 打开vim时，打开Tagbar
" augroup tagbar_cmd
  " autocmd!
  " autocmd FileType * nested :call tagbar#autoopen(0)
  " augroup END
"去除第一行的帮助信息
let g:tagbar_compact = 1
"当编辑代码时，在Tagbar自动追踪变量
let g:tagbar_autoshowtag = 1
let g:tagbar_width = 25
let g:tagbar_left = 1
map <F3> :sile! TagbarToggle<CR>
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
    \ 'coc-clangd']

" TextEdit might fail if hidden is not set.
set hidden

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
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


" codefmt settings {{{
" augroup autoformat_settings
  " 因为用版本控制修改别人的文件，自动格式化会将别人的代码格式化，这不是个好主意
  " autocmd FileType bzl AutoFormatBuffer buildifier
  " autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  " autocmd FileType dart AutoFormatBuffer dartfmt
  " autocmd FileType go AutoFormatBuffer gofmt
  " autocmd FileType gn AutoFormatBuffer gn
  " autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  " autocmd FileType java AutoFormatBuffer google-java-format
  " autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  " autocmd FileType rust AutoFormatBuffer rustfmt
  " autocmd FileType vue AutoFormatBuffer prettier
" augroup END
" }}}


" auto-pairs settings {{{
" 开启 flayMode 智能补全括号
let g:AutoPairsFlyMode = 1
" }}}

" indentLine settings {{{
" 使用主题颜色
" let g:indentLine_setColors = 0
let g:indentLine_fileType = ['c', 'cpp', 'python', 'vim']
" let g:indentLine_char = '┊'
" }}}

" xtabline settings {{{
" let g:xtabline_settings = {}
" let g:xtabline_settings.enable_mappings = 0
" let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
" let g:xtabline_settings.enable_persistance = 0
" let g:xtabline_settings.last_open_first = 1
" }}}

" jvim-cpp-enhanced-highlight setting 高亮函数 {{{
" let g:cpp_class_scope_highlight = 1
" let g:cpp_member_variable_highlight = 1
" let g:cpp_class_decl_highlight = 1
" let g:cpp_posix_standard = 1
" let g:cpp_experimental_template_highlight = 1
" let g:cpp_concepts_highlight = 1
" }}}

" vim-gutentags setting {{{
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
" let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
" let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
" let s:vim_tags = expand('~/.cache/tags')
" let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
" if !isdirectory(s:vim_tags)
"    silent! call mkdir(s:vim_tags, 'p')
" endif

" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" }}}

function! AddFuncTitle()
  let cur_line = line(".") - 1
  call append(cur_line    , "/**")
  call append(cur_line + 1, " * 函数名称:")
  call append(cur_line + 2, " * \t\txxx")
  call append(cur_line + 3, " *")
  call append(cur_line + 4, " * 功能描述:")
  call append(cur_line + 5, " * \t\txxx")
  call append(cur_line + 6, " *")
  call append(cur_line + 7, " * 参数列表:")
  call append(cur_line + 8, " * \t\tvar1: void")
  call append(cur_line + 9, " *")
  call append(cur_line + 10, " * 返回值:")
  call append(cur_line + 11, " * \t\tvalue1: null")
  call append(cur_line + 12, " *")
  call append(cur_line + 13, " * 日期:")
  call append(cur_line + 14, " * \t\t".strftime("%Y-%m-%d %H:%M"))
  call append(cur_line + 15, " *")
  call append(cur_line + 16, " * 作者:")
  call append(cur_line + 17, " * \t\ttjl")
  call append(cur_line + 18, " **/")
endf

nnoremap <silent><F6> <esc>:call AddFuncTitle()<cr>k$=%%j
