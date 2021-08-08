"    ===================================
"    Description  : tmw's vimrc
"    Author       : taominwgei1996@gmail.com
"    License      : GPL v2.0
"    ===================================
call plug#begin('~/.vim/plugged')
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'Raimondi/delimitMate'
Plug 'godlygeek/tabular'
" vim中执行git命令
Plug 'tpope/vim-fugitive'
" 新增单词环绕词
Plug 'tpope/vim-surround'
" 快捷注释
Plug 'scrooloose/nerdcommenter'
" tab 提示信息，非代码补全
Plug 'ervandew/supertab'
Plug 'vim-scripts/SearchComplete'
" 显示git差异
Plug 'airblade/vim-gitgutter',{'frozen':1}
Plug 'itchyny/lightline.vim'
Plug 'luochen1990/rainbow'
" 主题配色
Plug 'morhetz/gruvbox'
" ?
Plug 'nathangrigg/vim-beancount'
" 自动补全插件
Plug 'ycm-core/YouCompleteMe'
" 文件树形结构,使用方法是在VIM命令模式下输入:NERDTree
Plug 'scrooloose/nerdtree'
Plug 'dgryski/vim-godef'

Plug 'majutsushi/tagbar'

Plug 'fatih/vim-go'
" depend ack rpm
Plug 'mileszs/ack.vim'

Plug 'skywind3000/asyncrun.vim'
Plug 'takac/vim-hardtime'

call plug#end()

" General {
    set nocompatible
    syntax on                           " Syntax highlighting
    filetype plugin indent on           " Automatically detect file types.
    set mouse=v                         " Automatically enable mouse usage
    set mousehide                       " Hide the mouse cursor while typing
    set noimdisable                     " Disable IME
    set encoding=utf-8
    scriptencoding utf-8
    set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,gbk,euc-kr,utf-bom
    if has('clipboard')
        if has('unnamedplus')           " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else                            " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    set shortmess+=filmnrxoOtT          " Abbrev. of messages
    set viewoptions=folds,options,cursor,unix,slash
                                        " Better Unix / Windows compatibility
    set hidden                          " Allow buffer switching without saving
    set ttyfast                         " send more chars while redrawing
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator
    set history=1000                    " Store a ton of history (default is 20)
    set updatetime=250
    set virtualedit=onemore             " Allow for cursor beyond last character

    set visualbell                      " disable sound on errors
    set noerrorbells
    set t_vb=
    set tm=500

    " Identify platform {
    silent function! MacOS()
        return has('macunix')
    endfunction
    silent function! Linux()
        return has('unix') && !has('macunix') && !has('win32unix')
    endfunction
    silent function! Windows()
        return  (has('win32') || has('win64'))
    endfunction
    "}
"}

" Vim UI {
    set t_Co=256                        " Enable 256 colors
    set background=dark                 " Assume a dark background
    try | colorscheme gruvbox | catch | endtry
                                        " use this awesome theme if possible

    set showmode                        " Display the current mode
    set cursorline                      " Highlight current line
    set tabpagemax=15                   " Only show 15 tabs

    highlight clear SignColumn          " SignColumn should match background
    highlight clear LineNr              " Current line number row will have same background color in relative mode

    if has('cmdline_info')
        set ruler                       " Show the ruler
        set showcmd                     " Show partial commands
    endif

    set backspace=indent,eol,start      " Backspace for dummies
    set linespace=0                     " No extra spaces between rows
    set number
    set numberwidth=4
    set showmatch                       " Show matching brackets/parenthesis
    set incsearch                       " Find as you type search
    set hlsearch                        " Highlight search terms
    set winminheight=0                  " Windows can be 0 line high
    set ignorecase                      " Case insensitive search
    set smartcase                       " Case sensitive when uc present
    set wildmenu                        " Show list instead of just completing
    set wildmode=list:longest,full      " Command <Tab> completion, list matches
                                        ", then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]       " Backspace and cursor keys wrap too
    set scrolljump=5                    " Lines to scroll when cursor leaves
    set scrolloff=3                     " Lines to keep above and below cursor
    set sidescroll=1                    " Scroll left/right one character at a time

    set nofoldenable                    " Auto fold code

    set list                            " Highlight problematic whitespace
    set listchars=tab:\ \ ,trail:·,extends:#,nbsp:.
"}

" GUI Settings {
    if has('gui_running')
        set guioptions-=T               " Remove the toolbar
        set lines=40                    " 40 lines of text instead of 24
        if Linux()
            set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11
            color gruvbox
        elseif MacOS()
            set guioptions=
            set guifont=Monaco:h13,Menlo\ Regular:h11,Consolas\ Regular:h12
            colors gruvbox
            set showtabline-=0
        endif
    else
        language en_US
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256                " Enable 256 colors
        endif
    endif
"}

" Formatting {
    set nowrap                          " Do not wrap long lines
    set autoindent                      " Indent at the same level
    set expandtab                       " Tabs are spaces, not tabs
    set tabstop=4                       " An indentation every four columns
    set shiftwidth=4                    " Use indents of 4 spaces
    set softtabstop=4                   " Let backspace delete indent
    set smarttab                        " Insert tabs on the start
    set nojoinspaces                    " Prevents inserting two spaces
    set splitright                      " Puts new vsplit windows to the right
    set splitbelow                      " Puts new split windows to the bottom
    set matchpairs+=<:>                 " Match, to be used with %
    set pastetoggle=<F12>               " pastetoggle

    " Restore last line position when opening file
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG
                \ call setpos('.', [0, 1, 1, 0])

    " Custom extensions for file types, autocmd FileType go autocmd BufWritePre <buffer> Fmt
    au BufNewFile,BufRead *.html.twig set filetype=html.twig
    au BufNewFile,BufRead *.conf set filetype=dosini
    au FileType haskell,puppet,ruby,yml
                \ setlocal expandtab shiftwidth=2 softtabstop=2
"}

" Key (re)Mappings {
    let mapleader   = " "
    let g:mapleader = " "
    nm  <space> <nop>

    nm 0 ^
    nm B ^
    nm E $
    nm j gj
    nm k gk
    nm Y y$

    " highlight last inserted text
    nm gV `[v`]
	" select all text
    nm gA ggVG
    " c-j,k for buffer switch
    nm <c-j> :bn<cr>
    nm <c-k> :bp<cr>
    nm <tab> <c-w>w
    " emacs key bind
    "im <c-a> <HOME>
    "im <c-e> <END>
    "im <C-f> <Right>
    "im <C-b> <Left>
    "im <M-f> <S-Right>
    "im <M-b> <S-Left>
    "im <M-n> <Down>
    "im <M-p> <Up>
    im jj <esc>
    "cm <C-A> <Home>
    "cm <C-E> <End>
    
    " insert mode shortcut
    im <c-h> <Left>
    im <c-j> <Down>
    im <c-k> <UP>
    im <c-l> <Right>
    im <c-d> <DElETE>

    " stop arrow key
    noremap <Up> <NOP>
    noremap <Down> <NOP>
    noremap <Left> <NOP>
    noremap <Right> <NOP>
    "noremap h <NOP>
    "noremap j <NOP>
    "noremap k <NOP>
    "noremap l <NOP>

    nm <leader>n  :ene<CR>
    nm <leader>c  :bd!<cr>
    nm <leader>w  :bd<cr>
    nm <leader>qq :q!<cr>
    nm <leader>xx :qa!<cr>
    nm <leader>t  :set ft=
    nm <silent> <leader>/ :nohlsearch<CR>

    " time & date map
    nm <leader>da "=strftime("%y%m%d")<cr>p"
    nm <leader>ti "=strftime("%h:%m:%s")<cr>p"

    " quick open vimrc in a new tab
    nm <leader>v  :e $MYVIMRC<cr>
    nm <leader>s  :source $MYVIMRC<cr>

    " mouse
    nm <leader>sv :set mouse=v<cr>
    nm <leader>sa :set mouse=a<cr>

    " Some helpers to edit mode
    cm %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    nm <leader>ew :e %%
    nm <leader>es :sp %%
    nm <leader>ev :vsp %%
    nm <leader>et :tabe %%

    " Shortcuts
    " Change Working Directory to that of the current file
    cm cwd lcd %:p:h
    cm cd. lcd %:p:h

    " For when you forget to sudo.. Really Write the file.
    cm w!! w !sudo tee % >/dev/null

    " Allow using the repeat operator with a visual selection (!)
    vm . :normal .<CR>
    vm < <gv
    vm > >gv

    " Tab ctrl
    nnoremap H gT
    nnoremap L gt
    " normal mode , easy to work
    nnoremap <leader><CR>  A<CR><ESC>

    " Stupid shift key fixes
    if has("user_commands")
        command! -bang Wa     wa<bang>
        command! -bang WA     wa<bang>
        command! -bang H       h<bang>
        command! -bang Q       q<bang>
        command! -bang QA     qa!<bang>
        command! -bang Qa     qa<bang>
        command! -bang Tabe tabe<bang>
        command! -bang -nargs=* -complete=file E   e<bang> <args>
        command! -bang -nargs=* -complete=file W   w<bang> <args>
        command! -bang -nargs=* -complete=file Wq wq<bang> <args>
        command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    endif
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
    "set tag=tag;



"}

" Plugins {

    " rainbow {
        if isdirectory(expand("~/.vim/plugged/rainbow/"))
            let g:rainbow_active = 1
            let g:rbpt_max = 16
            let g:rbpt_loadcmd_toggle = 0
            let g:rbpt_colorpairs = [
                    \ ['brown',       'RoyalBlue3'],
                    \ ['Darkblue',    'SeaGreen3'],
                    \ ['darkgray',    'DarkOrchid3'],
                    \ ['darkgreen',   'firebrick3'],
                    \ ['darkcyan',    'RoyalBlue3'],
                    \ ['darkred',     'SeaGreen3'],
                    \ ['darkmagenta', 'DarkOrchid3'],
                    \ ['brown',       'firebrick3'],
                    \ ['gray',        'RoyalBlue3'],
                    \ ['black',       'SeaGreen3'],
                    \ ['darkmagenta', 'DarkOrchid3'],
                    \ ['Darkblue',    'firebrick3'],
                    \ ['darkgreen',   'RoyalBlue3'],
                    \ ['darkcyan',    'SeaGreen3'],
                    \ ['darkred',     'DarkOrchid3'],
                    \ ['red',         'firebrick3'],
                    \ ]
        endif
    "}

    " fugitive {
        if isdirectory(expand("~/.vim/plugged/vim-fugitive/"))
            nnoremap <silent> <leader>gs :Gstatus<CR>
            nnoremap <silent> <leader>gd :Gdiff<CR>
            nnoremap <silent> <leader>gc :Gcommit<CR>
            nnoremap <silent> <leader>gb :Gblame<CR>
            nnoremap <silent> <leader>gr :Gread<CR>
            nnoremap <silent> <leader>gw :Gwrite<CR>
            nnoremap <silent> <leader>ge :Gedit<CR>
            nnoremap <silent> <leader>gi :Git add -p %<CR>
            nnoremap <silent> <leader>gg :SignifyToggle<CR>
        endif
    "}

    " fzf {
        if isdirectory(expand("~/.vim/plugged/fzf.vim/"))
            nnoremap <silent> <c-p> :FZF<CR>
            nnoremap <silent> <leader>f :FZF<CR>
			nnoremap <silent> <leader>r :History<CR>
        endif
    "}

    " lightline {
        if isdirectory(expand("~/.vim/plugged/lightline.vim/"))
            set laststatus=2
            set noshowmode
            let g:lightline = {}
            let g:lightline.colorscheme = 'gruvbox'
            "let g:lightline.colorscheme = 'Tomorrow_Night'
        endif
    "}
    "tarbar {
        if isdirectory(expand("~/.vim/plugged/tagbar/"))
            nm <leader>o  :TagbarToggle<CR>
            "nmap <silent> <F9> :TagbarToggle<CR>        "按F9即可打开tagbar界面
            let g:tagbar_ctags_bin = 'ctags'                       "tagbar以来ctags插件
            let g:tagbar_left = 1                                          "让tagbar在页面左侧显示，默认右边
            let g:tagbar_width = 30                                     "设置tagbar的宽度为30列，默认40
            let g:tagbar_autofocus = 1                                "这是tagbar一打开，光标即在tagbar页面内，默认在vim打开的文件内
            let g:tagbar_sort = 0                                         "设置标签不排序，默认排序
        endif
    "}
    "YCM {
        if isdirectory(expand("~/.vim/plugged/YouCompleteMe/"))
                " 调整自动补全插件YCM
            " 确保你完成操作后，自动补全窗口不会消失
            let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py'  "设置全局配置文件的路径
            let g:ycm_server_python_interpreter='/usr/bin/python3'
            let g:ycm_autoclose_preview_window_after_completion=1
            let g:ycm_error_symbol = '>>'
            let g:ycm_warning_symbol = '>*'
            nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
            nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
            nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
            nmap <F4> :YcmDiags<CR>
        endif

    "}
    "NERDTree {
        if isdirectory(expand("~/.vim/plugged/nerdtree/"))
            "隐藏目录树中的.pyc文件
            let NERDTreeIgnore=['\.pyc$', '\~$','\.swp','\.git'] "ignore files in NERDTree
            map <F2> :NERDTreeFind<CR>
            "map <F2> :NERDTreeToggle<CR>
        endif
    "}
    "godef {
        if isdirectory(expand("~/.vim/plugged/vim-godef/"))
            let g:godef_split=2
            "let g:godef_split=3 """左右打开新窗口的时候
            "let g:godef_same_file_in_same_window=1 """函数在同一个文件中时不需要打开新窗口
        endif
    "}
    "ack {
        if isdirectory(expand("~/.vim/plugged/ack.vim/"))
            nnoremap <Leader><Leader>a "zyiw:exe ":Ack!<space>-i<space>".@z""<CR>
            "nmap <Leader><Leader>a :Ack!<space>-i<space>
            let g:ackprg = 'ag --nogroup --nocolor --column'
        endif
    "}
"}

" Functions {

    " Clean whitespace {
        function! DelTrailingWhitespace()
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " do the business:
            %s/\s\+$//e
            " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endfunction
        command! -bang -nargs=* DelTrailingWhitespace
                    \ :call DelTrailingWhitespace(<bang> <args>)
    "}

    " Clean WhiteLines {
        function! DelWhiteLines()
            %g/^$/d
        endfunction
        command! -bang -nargs=* DelWhiteLines
                    \ :call DelWhiteLines(<bang> <args>)
    "}

    " Quick format multi line data for sql {
        function! FormatSqlData()
            set nonu
            silent! set ft=sql
            silent! %s/^\(.*\)$/'\1',/
            silent! 1 s/^/in (/
            silent! $ s/,$/);/
            silent! noh
            silent! 1,$ y
        endfunction
        command! -bang -nargs=* FormatSqlData :call FormatSqlData(<bang> <args>)
        noremap <leader>sl :call FormatSqlData()<CR>
    "}

    " Cycle through relativenumber + number, number (only), and no numbering.{
        function! CycleNumbering()
            if exists('+relativenumber')
                execute {
                 \ '00': 'set norelativenumber   | set number',
                 \ '01': 'set norelativenumber   | set number',
                 \ '10': 'set relativenumber     | set number',
                 \ '11': 'set norelativenumber   | set nonumber' }[&number . &relativenumber]
            else
                " No relative numbering, just toggle numbers on and off.
                set number!
            endif
        endfunction
        command! -bang -nargs=* CycleNumbering :call CycleNumbering(<bang> <args>)
        noremap <leader>tn :call CycleNumbering()<CR>
    "}
"}
