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
"							这里的文件仅仅负责启动检测和设置文件的filetype类型的自动命令。
" ftplugin					一切皆取决于它的名字!当Vim把一个缓冲区的filetype设置成某个值时，
"							它会去查找~/.vim/ftplugin/下对应的文件,或者文件夹,buffer-local的。
" indent					类似ftplugin,缩进的脚本bufffer-local的。
" compile					类似indent,编译器相关文件。
" after						这个文件夹下的文件会在每次Vim启动的时候加载， 不过是在~/.vim/plugin/下的文件加载了之后。
" autoload					autoload是一种延迟插件代码到需要时才加载的方法。
" doc						放置文档的目录。
