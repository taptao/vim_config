" 本vim设置文件是基于vundle插件来对vim插件进行管理,使用这个设置文件，需要先安装vundle插件
"
set nocompatible              
filetype off                 

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
  
" 下面这个方法调用vundle插件，规定了需要下载的插件以及插件的存储位置
call vundle#begin('~/.vim/bundle')

" 设置 leader 键，例子为空号键，也可以设置为其他的 默认为"/"
let mapleader=" "

" vundle插件，一个用来管理vim插件的插件
Plugin 'gmarik/Vundle.vim'

" 解决缩进超出折叠数的插件
Plugin 'tmhedberg/SimpylFold'

" 自动缩进插件
Plugin 'vim-scripts/indentpython.vim'

" 自动补全插件
Plugin 'ycm-core/YouCompleteMe'
"添加jedi-vim代码补全插件
Plugin 'davidhalter/jedi-vim'


" 语法检查/高亮插件
Plugin 'w0rp/ale'
" Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'

" 配色方案插件
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

" 文件树形结构,使用方法是在VIM命令模式下输入:NERDTree
Plugin 'scrooloose/nerdtree'

" ctrlP搜索插件
Plugin 'kien/ctrlp.vim'

" vim中执行git命令
Plugin 'tpope/vim-fugitive'

Bundle 'majutsushi/tagbar'
" 状态栏插件
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
let python_highlight_all=1
syntax on
call vundle#end()            " required
filetype plugin indent on    " required

"设置按F2启动NerdTree
map <F2> :NERDTreeToggle<CR>
"隐藏目录树中的.pyc文件
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" sv <filename>,纵向分割布局
" vs <filename>,横向分割布局 
set splitbelow
set splitright

" Ctrl-j 切换到下方的分割窗口
" Ctrl-k 切换到上方的分割窗口
" Ctrl-l 切换到右侧的分割窗口
" Ctrl-h 切换到左侧的分割窗口

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"设置backspace可以删除 indent end of line  start
set backspace=2

" 设置折叠类或方法（对缩进内容的折叠）
set foldmethod=indent
set foldlevel=99
" 本来只能通过za按键来进行折叠，通过下面的设置，可以使用空格实现za功能
nnoremap <space> za
" 折叠代码时仍然能看到文档字符串
let g:SimpylFold_docstring_preview=1

" .py文件支持pep8风格的缩进
" tabstop设置tab键为四个空格
" textwidth设置一行代码最大长度
" fileformat,规定文件格式
au BufNewFile,BufRead *.py,*.c
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |


" 标示不必要的空白字符
" BadWhitespace是用户自定义的高亮组，可以用下面语句进行定义
hi BadWhitespace guifg=gray guibg=red ctermfg=gray ctermbg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" 支持utf-8编码
set encoding=utf-8

" 调整自动补全插件YCM
" 确保你完成操作后，自动补全窗口不会消失
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'  "设置全局配置文件的路径
"let g:ycm_server_python_interpreter='/usr/bin/python3'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <F4> :YcmDiags<CR>

" ale 语法检测
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '!'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_linters = {
			\   'c++': ['clang'],
			\   'c': ['clang'],
			\   'python': ['pylint'],
			\}
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
  set csverb
endif

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>
set tag=tag;
set autochdir

" 配色方案逻辑判断
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif
" F5切换色调
call togglebg#map("<F5>")

" 显示行号
set nu
" 设置vim的默认剪贴板为系统剪贴板
set clipboard=unnamedplus

" tarbar
nmap <silent> <F9> :TagbarToggle<CR>        "按F9即可打开tagbar界面
let g:tagbar_ctags_bin = 'ctags'                       "tagbar以来ctags插件
let g:tagbar_left = 1                                          "让tagbar在页面左侧显示，默认右边
let g:tagbar_width = 30                                     "设置tagbar的宽度为30列，默认40
let g:tagbar_autofocus = 1                                "这是tagbar一打开，光标即在tagbar页面内，默认在vim打开的文件内
let g:tagbar_sort = 0                                         "设置标签不排序，默认排序


" 支持virtualenv虚拟环境
"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF


