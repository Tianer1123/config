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
  else
    " set guifont=DroidSansMonoSlashedForPowerline:h18
    " set guifont=FiraCode-Retina:h16
    " set guifont=SpaceMonoForPowerline-Regular:h16
    set guifont=Consolas-with-Yahei:h16
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

" }}}

" Vundle Plugins {{{
if filereadable(expand("~/.vim/plugin.vim"))
  source ~/.vim/plugin.vim
endif
" }}}

" =======================自定义映射===========================
" self map settings {{{
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
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
" 在可视模式下按 ,v" 在光标选中的字符两边加上双引号,保留在可视模式.
vnoremap <leader>v" <esc>a"<esc>hbi"<esc>`<lv`>l

" 映射按键映射到一个邮箱。
onoremap in@ :<c-u>execute "normal! /\\w\\+@\\w\\+.\\w\\+\r:nohlsearch\rveeeee"<cr>
" }}}

" =======================自定义自动命令=======================
augroup self_def_cmds " {{{
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
  autocmd bufnewfile,bufread * nnoremap <buffer> <localleader>` vaw<esc>i`<esc>hbi`<esc>lel
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
  autocmd bufread,bufwritepost * match RedSpaceInLineTail /\v\s+$/
  " }}}

augroup end " }}}

" =======================自定义MyFunction=====================
function! InsertDate() "{{{
  let l:match_str = matchstr(system("source ~/.bash_profile; echo $LC_ALL"), 
        \ 'zh_CN.UTF-8')
  if l:match_str ==? "zh_CN.UTF-8"
    let l:dateList = split(strftime("%Y %m %d %a"))
    if &ft ==? "md" || &ft ==? "markdown"
      execute "normal! aDate: " . l:dateList[0] . "年" . l:dateList[1] . "月"
            \ . l:dateList[2] . "日 `星期" . l:dateList[3] . "`\<esc>"
    else
      execute "normal! aDate: " . l:dateList[0] . "年" . l:dateList[1] . "月"
            \ . l:dateList[2] . "日 星期" . l:dateList[3] . "\<esc>"
    endif
  else
    let l:weeks = {"Mon":"一",
                \  "Tue":"二",
                \  "Wed":"三",
                \  "Thu":"四",
                \  "Fri":"五",
                \  "Sat":"六",
                \  "Sun":"日"}

    let l:months = {"Jan":"1",
                  \ "Feb":"2",
                  \ "Mar":"3",
                  \ "Apr":"4",
                  \ "May":"5",
                  \ "Jun":"6",
                  \ "jul":"7",
                  \ "Aug":"8",
                  \ "Sep":"9",
                  \ "Oct":"10",
                  \ "Nov":"11",
                  \ "Dec":"12"}

    " Thu Nov  1 14:31:12 2018
    let l:dateList = split(strftime("%c"), " ")
    let l:week = get(l:weeks, l:dateList[0])
    let l:month = get(l:months, l:dateList[1])
    let l:day = l:dateList[2]
    let l:year = l:dateList[4]
    if &ft ==? "md" || &ft ==? "markdown"
      execute "normal! aDate: " . l:year . "年" . l:month . "月" . l:day .
            \ "日星期" . l:week . "``\<esc>"
    else
      execute "normal! aDate: " . l:year . "年" . l:month . "月" . l:day .
            \ "日 星期" . l:week . "\<esc>"
    endif
  endif
endfunction "}}}

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
