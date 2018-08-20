set nobackup
set nu
set hidden
set ignorecase
set incsearch
set smartcase
set showmatch
set autoindent
set noerrorbells
set showcmd
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=2
set cmdheight=2
set nowrap "不换行
set autoread
set hlsearch
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,gb2312,chinese,cp936

set lines=999 columns=999
" au GUIEnter * simalt ~x  最大化
set cursorline "高亮当前行
set cursorcolumn "高亮当前列

" 解决consle输出乱码
language messages zh_CN.utf-8

syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

set guifont=Ubuntu\ Mono
" set guifont=Courier\ New

if has("cscope")
    set cscopetag
    set csto=0
    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif

" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"nerdtree 生成工程目录树
Plugin 'git@github.com:scrooloose/nerdtree.git'

"tagbar 类似Taglist,生成函数、变量列表
Plugin 'git@github.com:majutsushi/tagbar.git'

"delimitMate 成对生成(),{},[]
Plugin 'git@github.com:Raimondi/delimitMate.git'

""TagHighlight 根据生成的Tag文件，高亮类、变量、函数和关键字。
Plugin 'git@github.com:magic-dot-files/TagHighlight.git'

Plugin 'Valloric/YouCompleteMe'

Plugin 'scrooloose/syntastic'
 
"markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

"ultisnips 类似TextMate的snippets
Plugin 'git@github.com:SirVer/ultisnips.git'
Plugin 'honza/vim-snippets'

call vundle#end()            " required
filetype plugin indent on    " required


" Trigge configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
 let g:UltiSnipsExpandTrigger="<tab>"
 let g:UltiSnipsJumpForwardTrigger="<c-b>"
 let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
 let g:UltiSnipsEditSplit="vertical"

"NERDTree Settings{
 autocmd StdinReadPre * let s:std_in=1
 autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

 let NERDTreeWinPos = "left"
 autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

 autocmd vimenter * NERDTree " 默认打开并进入右侧工作区
 wincmd w
 autocmd VimEnter * wincmd w

 map <F4> :silent! NERDTreeToggle<CR>

 let g:NERDTreeDirArrowExpandable = '▸'
 let g:NERDTreeDirArrowCollapsible = '▾'

"}

" tagbar Settings{
  nnoremap <silent> <F9> :TagbarToggle<CR>

  let g:tagbar_right=1 " 在右侧
  let g:tagbar_width=25 " 宽度
  autocmd VimEnter * nested :call tagbar#autoopen(1)    "打开vim时自动打开tagbar
" }


"delimitMate Settings{
 let loadad_delimitMate = 1
 au FileType mail let b:loaded_delimitMate = 1
 let delimitMate_matchpairs = "(:),[:],{:},<:>"
 au FileType vim,html let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
"}
         
"syntastic Settings{
let g:syntastic_error_symbol = '✗' "set error or warning signs
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_check_on_open=1
let g:syntastic_enable_highlighting = 0
"let g:syntastic_python_checker="flake8,pyflakes,pep8,pylint"
let g:syntastic_python_checkers=['pyflakes']
"highlight SyntasticErrorSign guifg=white guibg=black
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang'
let g:syntastic_cpp_compiler_options = '-std=c99'
let g:syntastic_enable_balloons = 1 "whether to show balloons"
"}

"ultisnips Settings{
 let g:UltiSnipsSnippetDirectories=['UltiSnips']
 let g:UltiSnipsSnippetsDir = '~/.vim/bundle/vim-snippets/UltiSnips'
 let g:UltiSnipsExpandTrigger = "<c-j>"
 let g:UltiSnipsJumpForwardTrigger = "<c-f>"
 let g:UltiSnipsJumpBackwardTrigger = "<c-b>"
"}

"YCM settings{
 let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
 "let g:ycm_confirm_extra_conf=0;
 let g:ycm_collect_identifier_from_tag_files = 1
"}

let devassistant=0
if devassistant==1
:source /usr/share/devassistant/files/snippets/vim/vimrc
endif
"END_DEVASSISTANT_1


" setting markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_no_default_key_mappings=1
" end
