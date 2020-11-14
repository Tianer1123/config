" 基本设置 {{{
set nobackup
set nu
set rnu
set hidden
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

set cursorcolumn
set cursorline
set t_Co=256

" set list
" set listchars=tab:▸\ ,trail:␣,precedes:«,extends:»,eol:¬

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
    set guifont=Consolas-with-Yahei:h18
    au GUIEnter * simalt ~x
  elseif has("mac")
    " set guifont=Consolas-with-Yahei:h16

    set guifont=InconsolataNerdFontComplete-Medium:h18

    " set guifont=MonacoNerdFontCompleteM-:h16
    " 允许连字符
    "set macligatures
    "set guifont=FuraCodeNerdFontComplete-Regular:h16
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

" }}}

" Vundle Plugins {{{
if has("win32") || has("win64")
    let vimplugin = $VIM . '\plugin.vim'
    if filereadable(vimplugin)
        source $vim\plugin.vim
    endif
elseif has("mac") || has("unix")
    if filereadable(expand("~/.vim/plugin.vim"))
        source ~/.vim/plugin.vim
    endif
endif
" }}}

" =======================自定义映射==========================={{{
" self map settings
" 将 jk 映射成 <esc> 。如果不习惯可以映射将 <esc> 映射成空 inoremap <esc> <Nop>，这样练习映射。
inoremap jk <esc>

" 映射<leader>ev，纵向分屏打开vimrc文件
nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
" 映射<leader>sv, 使vimrc立即生效
nnoremap <leader>sv :source $MYVIMRC<cr>

" 插入模式下按 ctrl + u 将光标下的单词转换成大写
inoremap <c-u> <esc>viwUea

" 在普通模式按 ,' 在光标所在单词上加上单引号,并将光标移动到单词尾.
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
" 在可视模式下按 ,v" 在光标选中的字符两边加上双引号,保留在可视模式.
vnoremap <leader>v" <esc>a"<esc>hbi"<esc>`<lv`>l
" }}}

" =======================自定义自动命令======================={{{
augroup self_def_cmds
  autocmd!
  " 自动命令在每次 source ~/.vimrc 的时候，会重新多定义一份自动命令，而不是覆盖。

  " python tabstop settings {{{
  autocmd filetype python,py set tabstop=4
  autocmd filetype python,py set softtabstop=4
  autocmd filetype python,py set shiftwidth=4
  " }}}

  " markdown settings {{{
  autocmd filetype markdown,md set tabstop=4
  autocmd filetype markdown,md set softtabstop=4
  autocmd filetype markdown,md set shiftwidth=4
  " 普通模式添加`高亮显示代码
  autocmd bufnewfile,bufread * nnoremap <buffer> <localleader>` viw<esc>a`<esc>hbi`<esc>lel
  " add todo: - [x]
  autocmd bufnewfile,bufread * nnoremap <buffer> <localleader>td 0i- [x] <esc>a
  " }}}

  " 插入日期映射 {{{
  autocmd bufnewfile,bufread * nnoremap <buffer> <leader>dt :call InsertDate()<cr>
  " }}}

  " javascript python 插入注释 {{{
  autocmd filetype javascript nnoremap <buffer> <localleader>c i//<esc>
  autocmd filetype python     nnoremap <buffer> <localleader>c i#<esc>
  " }}}

  " javascript python if 缩写 {{{
  autocmd filetype python     :iabbrev <buffer> iff if:<left>
  autocmd filetype javascript :iabbrev <buffer> iff if ()<left>
  " }}}

  " 在保存vimrc时自动source {{{
  autocmd bufwritepost $myvimrc source %
  " }}}

  " 打开vim时，光标移动到上次退出时的位置 {{{
  autocmd bufreadpost * if line("'\"") > 1 && line("'\"") <= line("$") && &ft !=# 'commit'
                      \ | execute "normal! g`\"^"
                      \ | endif
  " }}}

  " 设置 vim 缩进 {{{
  autocmd filetype vim setlocal foldmethod=marker
  " }}}

  " 设置行尾有空格高亮显示 {{{
  highlight RedSpaceInLineTail ctermbg=red guibg=red
  autocmd bufnewfile,bufread,bufwritepost * match RedSpaceInLineTail /\v\s+$/
  " }}}

  " python 高亮79列，其他高亮120列 {{{
  autocmd bufnewfile,bufread * if &ft ==? "python" || &ft ==? "py" | setlocal colorcolumn=79 | else | setlocal colorcolumn=120 | endif
  " }}}

augroup end " }}}

" =======================自定义MyFunction===================== {{{
" 使用python3获取日期，不支持neovim
function! InsertDate()
python <<EOF
import time
import datetime
import vim
import os

def get_week_day(date):
    week_day_dict = {
        '0' : '星期一',
        '1' : '星期二',
        '2' : '星期三',
        '3' : '星期四',
        '4' : '星期五',
        '5' : '星期六',
        '6' : '星期日',
    }
    day = date.weekday()
    return week_day_dict[str(day)]

def get_insert_str(cb_fileext):
    if "md" in cb_fileext or "markdown" in cb_fileext:
        insert_str = "Date: "
                    \ + time.strftime("%Y年%m月%d日", time.localtime())
                    \ + " `"
                    \ + get_week_day(datetime.datetime.now())
                    \ + "`"
    else:
        insert_str = "Date: "
                    \ + time.strftime("%Y年%m月%d日", time.localtime())
                    \ + " "
                    \ + get_week_day(datetime.datetime.now())

    return insert_str


cw             = vim.current.window              # 获取当前窗口
cb             = vim.current.buffer              # 获取当前缓冲区
row            = cw.cursor[0]                    # 获取光标所在行
cb_fileext     = os.path.splitext(cb.name)[1]    # 得到文件后缀名，例如.md
insert_str     = get_insert_str(cb_fileext)      # 获取插入字符串
insert_str_len = len(insert_str)                 # 插入字符串长度
new_line       = insert_str + " " + cb[row - 1]  # 在行首插入日期
cb[row - 1]    = new_line.strip()                # 将新行插入到缓冲区
cw.cursor      = (cw.cursor[0], insert_str_len)  # 设置光标到新插入的文字后面
EOF
endfunction
"}}}

" =======================visual-star=============={{{
" 将 * 和 # 重新定义，按 * 时查询光亮选取，而不是查询光标
" 下的单词。
" =======================================================
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction "}}}

