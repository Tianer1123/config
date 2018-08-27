" 设置本地选项
let &l:number = 1      " setlocal?
" 寄存器作为变量
let @a = "hello!"
" 复制一段文字执行下面的命令
echo @"
" `"`为(unnamed)寄存器
" 可以使用set的时候永远不用使用let，let代码更难阅读

" 变量作用域
" 本地变量b:
let b:hello="world"
echom b:hello " ==>world
" ------------ internal-variables ---------
" b:	  局部于当前缓冲区。
" w:	  局部于当前窗口。
" t:	  局部于当前标签页。
" g:	  全局。
" l:	  局部于函数。
" s:	  局部于 |:source| 的 Vim 脚本。
" a:	  函数参数 (只限于函数内使用)。
" v:	  Vim 预定义的全局变量。

" ------------- if ------------------------
if 1 "不为0的数字为真
	echom "ONE"
endif

" 字符串变量为假
if "somthing"
	echom "INDEED"
endif

echom "hello" + 10    " ==> 10
echom "10hello" + 10  " ==> 20
echom "hello10" + 10  " ==> 10

" * 在解析10 + "20foo"时，Vim将把 "20foo"转换成一个整数(20)然后加到10上去。
" * 以一个数字开头的字符串会被强制转换成数字，否则会转换成0。
" * 在所有的强制转换完成后，当if的判断条件等于非零整数时，Vim会执行if语句体。

if 0
	echom "if"
elseif "nope!"
	echom "elseif"
else
	echom "finally!"
endif     " ====> finally

" ---------------- 比较 --------------------
" 大小写敏感但取决于用户的设置
set ignorecase
if "foo" == "FOO"
    echom "no, it couldn't be"
elseif "foo" == "foo"
    echom "this must be the one"
endif
" 防御性编程
set noignorecase
if "foo" ==? "FOO"
    echom "first"
elseif "foo" ==? "foo"
    echom "second"
endif


set ignorecase
if "foo" ==# "FOO"
    echom "one"
elseif "foo" ==# "foo"
    echom "two"
endif

" 比较时总是用下面的操作符来比较
" * `==?`  无论你怎么设都大小写不敏感
" * `==#`  无论怎么设置都大小写敏感

" -------------- 函数 -----------------
" * 没有作用域限制的Vimscript函数必须以一个大写字母开头！有作用域最好也要大写开头。
" * function meow()  ==> 这种写法是不对的。
function Meow()
	echom "Meow!"
endfunction

call Meow()

echom Meow()  " ==> 返回 Meow 和 0，函数没有返回值会隐式返回0.


function GetMeow()
	return "Meow String!"
endfunction

echom GetMeow()


function TextwidthIsTooWide()
	if &l:textwidth ># 80
		return 1
	endif
endfunction

set textwidth=80
if TextwidthIsTooWide()
	echom "WARNING: Wide text!"
endif

" ----------------函数参数 help function-argument----------------
" 参数的定义只要给出它的名字。在函数里，可以使用 "a:name" 来访问 ("a:" 代表参数(argument))
function DisplayName(name)
	echom "Hello! My name is:"
	echom a:name
endfunction

call DisplayName("Tianer1123")

" 可变参数
function Varg(...)
	echom a:0      " 额外参数数量
	echom a:1      " 第一个参数
	echo a:000     " 额外参数列表,列表不能使用echom
endfunction

call Varg("a", "b") " ==> 2<cr>a<cr>['a', 'b']

function Varg2(foo, ...)
  echom a:foo
  echom a:0
  echom a:1
  echo a:000
endfunction

call Varg2("a", "b", "c")
" a   a:foo
" 2   a:0
" b   a:1
" ['b', 'c'] a:000

" * 不能直接对参数变量重新赋值
function Assign(foo)
  let a:foo = "Nope"
  echom a:foo
endfunction

call Assign("test")    " X

function AssignGood(foo)
  let foo_tmp = a:foo
  let foo_tmp = "Yep"
  echom foo_tmp
endfunction

call AssignGood("test")

" help local-variables
" 在函数里，可以使用局部变量。它们在函数返回时就会消失。全局变量的访问需要通过"g:"

" -------------字符串------------
" 连接字符串符号`.`
echom "Hello, " . "World"
echom 10 . "foo"
echom 10.1 . "foo"   " ==> X float不可以转成String

echom "foo \"bar\""  " ==>使用`\`表示转移字符

" 字符串字面量 help literal-string  E115
echom '\n\\'  					" ==> \n\\ ,单引号无视转义字符,所见即所得。
echom 'That''s enough.'  		" ==> That's enough.两个单引号是字符串字面量里唯一的特殊序列。 



" ----------------------列表--------------------
echo ['foo', 3, 'bar']
echo ['foo', [3, 'bar']]
" 索引
echo [0, [1, 2]][1]
echo [0, [1, 2]][-2]
" 切割
echo ['a', 'b', 'c', 'd', 'e'][0:2]
echo ['a', 'b', 'c', 'd', 'e'][0:100000]
echo ['a', 'b', 'c', 'd', 'e'][-2:-1]
echo ['a', 'b', 'c', 'd', 'e'][:1]
echo ['a', 'b', 'c', 'd', 'e'][3:]
echo "abcd"[0:2]
" 不能使用负数来索引字符串。却可以使用负数切割字符串
" echo "abcd"[-1] . "abcde"[-2:] ==> de
echo "abcd"[-1] . "abcde"[-2:]
" 连接
echo ['a', 'b'] + ['c']
" 函数列表
" help List, help add(), help len(), help get(), help index(),
" help join(), help reverse() help functions

" ----------------------循环--------------------
" for
let c = 0

for i in [1, 2, 3, 4]
	let c += i
endfor

echom c
" while
let c = 1
let total = 0

while c <= 4
	let total += c
	let c += 1
endwhile

echom total

" ----------------------字典--------------------
" 字典用花括号创建。值是异质的，但键会被强制转换成字符串
echo {'a': 1, 100: 'foo'}
" 字典最后加`,`
echo {'a': 1, 100: 'foo',}

" 索引
echo {'a': 1, 100: 'foo',}['a']
echo {'a': 1, 100: 'foo',}[100]
echo {'a': 1, 100: 'foo',}.a
echo {'a': 1, 100: 'foo',}.100

" 赋值和添加
let foo = {'a': 1}
let foo.a = 100
let foo.b = 200
echo foo

" 移除项
let test = remove(foo, 'a')
unlet foo.b
echo foo
echo test

" 字典函数
" help Dictionary, help get(), help has_key(), help items(),
" help keys(), help values()


"-----------------切换-------------
nnoremap <leader>N :setlocal number!<cr>

" -------------foldColumnToggle()--------
nnoremap <leader>f :call FoldColumnToggle()<cr>

function! FoldColumnToggle()
	if &foldcolumn
		setlocal foldcolumn=0
	else
		setlocal foldcolumn=2
	endif
endfunction


" -------------QuickfixToggle()-------{{{
nnoremap <leader>q :call QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! QuickfixToggle()
	if g:quickfix_is_open
		cclose
		let g:quickfix_is_open = 0
		execute g:quickfix_return_to_window . "wincmd w"
	else
		let g:quickfix_return_to_window = winnr()
		copen
		let g:quickfix_is_open = 1
	endif
endfunction

" help foldcolumn, help winnr(), help ctrl-w_w, help wincmd
" }}}


" -------------路径----------{{{
" 绝对路径
echom expand("%")					" 相对路径
echom expand("%:p")					" 绝对路径
echom fnamemodify('foo.txt', ':p')	" foo.txt的绝对路径，无论foo.txt是否存在
" 列出文件
echo globpath('.', '*')
echo split(globpath('.', '*'), '\n')
echo split(globpath('.', '*.txt'), '\n')
echo split(globpath('.', '**'), '\n')
" help expand(), fnamemodify(), filename-modifiers, simplify(), resolve(),
" resolve(), wildcards.
" }}}


" colors					配色方案。
" plugin					文件将在每次Vim启动的时候执行。
" ftdetect					每次启动vim的时候执行，
"						这里的文件仅仅负责启动检测和设置文件的filetype类型的自动命令。
" ftplugin					一切皆取决于它的名字!当Vim把一个缓冲区的filetype设置成某个值时，
"						它会去查找~/.vim/ftplugin/下对应的文件,或者文件夹,buffer-local的。
" indent					类似ftplugin,缩进的脚本bufffer-local的。
" compile					类似indent,编译器相关文件。
" after						这个文件夹下的文件会在每次Vim启动的时候加载， 不过是在~/.vim/plugin/下的文件加载了之后。
" autoload					autoload是一种延迟插件代码到需要时才加载的方法。
" doc						放置文档的目录。

" 写那些文档
" Introduction
" Usage
" Mappings
" Configuration
" License
" Bugs
" Contributing
" Changelog
" Credits





" 设置中文帮助文档
set helplang=cn
set encoding=utf-8

" 映射ctrl + u使当前光标下得单词变为大写，并移动光标到单词尾
nnoremap <c-u> viwUe
inoremap <c-u> <esc>viwUe

" 设置mapleader为","，默认为反斜杠
let mapleader=","
vnoremap <leader>c "+y
nnoremap <leader>v "+p

" 命令行模式映射回溯历史命令
" <Up> <Down>可以对历史命令过滤
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" 展开文件所在目录
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" 打开文件时回到退出时的位置 help line()
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
			\ | execute "normal! g`\"0"
			\ | endif


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


" gvim打开时最大化
augroup gvim_maxscreen
	autocmd!
	autocmd GUIENTER * :simalt ~x
augroup END
