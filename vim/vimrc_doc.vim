" 设置中文帮助文档
set helplang=cn
set encoding=utf-8

" 映射ctrl + u使当前光标下得单词变为大写，并移动光标到单词尾
nnoremap <c-u> viwUe
inoremap <c-u> <esc>viwUe

" 设置mapleader为","，默认为反斜杠
let mapleader=","

" 映射<leader>ev，纵向分屏打开vimrc文件
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" 映射<leader>sv, 使vimrc立即生效
" nnoremap <leader>sv :source $MYVIMRC<cr>
" 在保存vimrc时自动source
augroup autosourcing
  autocmd!
  autocmd BufWritePost _vimrc source %
augroup END

" iabbrev类似映射，在插入模式输入tianer1123，会替换为后面得字符串，iabbrev在单词纠错方面很有用。
iabbrev tianer1123 # ---<cr># tianer1123<cr># tianer1123@qq.com

" <leader>' 给当前光标所在单词加上单引号
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
" <leader>' 给当前光标所在单词加上双引号
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
" H移到行首
nnoremap H ^
" L移到行尾
nnoremap L A<esc>

" 本地缓冲区映射
" nnoremap <leader>d dd                                         " 针对所有缓冲区的映射
 " <buffer>告诉vim针对当前缓冲区的映射，本地缓冲区的映射一般用<localleader>不适用<leader>
" nnoremap <buffre> <leader>x dd

" 将<esc>从插入模式进入normal模式改为在插入模式按jk
inoremap jk <esc>
inoremap <esc> <nop>

" 设置FileType自动命令，需要filetype on，测试了下，不然不起作用。
filetype on
autocmd FileType javascript,c,cpp nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>

" Operator-Pending映射 d y c  => dp din( dil(  d{ din{ dil{...
onoremap p i( 
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>

onoremap { i{ 
onoremap in{ :<c-u>normal! f{vi(<cr>
onoremap il{ :<c-u>normal! F}vi(<cr>

" ?^[=-]\\+$\r:nohlsearch\rkvg_ 这个命令分3部分用\r(回车符)分隔
" ?^[=-]\\+$     向上搜索全部是=或者全部是-的行
" :nohlsearc     清除之前的搜索结果的高亮显示,防止这些高亮显示分散我们的注意
" kvg_           k、v、g_命令
" onoremap ih :<c-u>execute "normal! ?^[=-]\\+$\r:nohlsearch\rkvg_"<cr>

autocmd FileType markdown onoremap ih :<c-u>execute "normal! ?^[=-]\\+$\r:nohlsearch\rkvg_"<cr>

" 自动命令格式
" autocmd BufNewFile * :write
"         ^          ^  ^
"         |          |  |
"         |          |  要执行的命令
"         |          用于事件过滤的模式(pattern)
"        要监听的事件


" 自动命令组
" * 相同组名的命令组,vim会组合加载,不会覆盖。
" * 如果不需要加载相同组其他自动命令添加`autocmd!`命令
" autogroup testgroup
"   autocmd!                              " 清除testgroup这个组
"   autocmd BufWrite * :echom "Cats"      " 创建一条自动命令
" autogroup END                           " 退出这个组
" * 每次加载~/.vimrc时,自动命令先"删掉testgroup的组",再创建一个自动命令。


"状态栏
set laststatus=2                   "显示状态栏
set statusline=%.20F               "绝对路径最长20字符
set statusline+=\                  "空格分隔
set statusline+=%y                 "文件类型
set statusline+=%=                 "切换到右边
set statusline+=[%l                "当前行号
set statusline+=/                  "分隔符
set statusline+=%L]                "总行数

syntax enable
set background = dark
colorscheme solarized

" vim 宏录制和回放 
"1. qa 录制宏到a寄存器，也可以 qb qc...。
"2. 操作完成回到normal模式按 q 退出宏录制。
"3. 用@a回放寄存器a的操作，也可以n@a,比如10@a回放寄存器a中的操作10次。

" -------------------gvim右键乱码---------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,cp936

" -----------------gvim显示设置----------------------
set guioptions-=T                           " 不包含工具栏
set guioptions-=m                           " 不显示菜单栏
set guioptions-=l                           " 去掉左边的滚动条总是存在
set guioptions-=L                           " 去掉左边的滚动条总是存在
set guioptions-=r                           " 去掉右边的滚动条总是存在
set guioptions-=R                           " 去掉右边的滚动条总是存在

" -----------------vim折叠功能----------------------
" 使用`za`打开和折叠代码
" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}


set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start

" <leader>w 查看以空字符结尾的行
" 设置Error组
highlight Error ctermbg=red guibg=red
nnoremap <leader>w :match Error /\s\+$/<cr>
nnoremap <leader>W :match none<cr>

" --------grep--------
" nnoremap <leader>g :silent! execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>


" ----------字符串函数-------------
" help functions 里有很多内置String内置函数

" -----------Execute---------------
" help execute
" execute({command} [, {silent}]) 字符串拼接的命令
" help expr-quote

" -----------normal-------------
" normal!  ==> 避免映射,因为执行的命令你不知道有没有被用户映射，所以永远使用normal!,不要使用normal。
" 下面命令不会执行搜索，因为normal!无法识别<cr>这种特殊字符
normal! /foo<cr>
" 一个替代的方法是 |:execute|，它可以用表达式作为参数。这样就可使用可显示字符来代表特殊字符。
execute "normal! \<c-w>\<c-w>"
execute "normal! /foo\<cr>"

" ------------正则表达式----------
" help magic, help pattern-overview
" `/`和`?`正向和反向搜索都能接收正则表达式
execute "normal! gg/for .\\+ in .\\+:\r"

" 使用字面量字符串'',可以少使用转移字符
execute 'normal! gg/for .\+ in .\+:\<cr>'
" \<cr>被转成字面值，并不是回车，所以上面的命令没有被执行.
execute "normal! gg" . '/for .\+ in .\+:' . "\n"
execute "normal! gg" . '/for .\+ in .\+:' . "\<cr>"

" 使用\v引导模式
execute "normal! gg" . '/\vfor .+ in .+:' . "\<cr>"

" 在你的~/.vimrc文件中加入使用match来高亮多余的空白为错误的映射。建议使用<leader>w
highlight Error ctermbg=red guibg=red
match Error /\s\+$/ " \s空字符 \s非空字符, \+一个或者多个 $结尾


" --------------grep运算符----------
" help :grep ,help make, help quickfix-window
vimgrep /an error/ *.c

" nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>


" vimscript 脚本语言 ==> vimscript.vim

