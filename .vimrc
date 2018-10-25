call plug#begin('~/.vim/plugged')

"fast move plugin, action key is <leader>\
"current <leader> = \
Plug 'Lokaltog/vim-easymotion'

"fast switch file in directory
Plug 'kien/ctrlp.vim'

"syntax motion
Plug 'scrooloose/syntastic'

"dirctory plugin keymap <F5>
"Plug 'scrooloose/nerdtree'
"add git plugin for nerdtree
"Plug 'Xuyuanp/nerdtree-git-plugin'

"color theme
Plug 'tomasr/molokai'

"switch buffer
Plug 'vim-scripts/bufexplorer.zip'

"function list for a file,  support go
Plug 'majutsushi/tagbar'

"switch header file and source file for CPP
Plug 'vim-scripts/a.vim'

"surround quote
Plug 'tpope/vim-surround'

"markdown syntax and function
Plug 'plasticboy/vim-markdown'

"more repeat acion support with key "."
Plug 'tpope/vim-repeat'

"go lang support 
Plug 'fatih/vim-go'

"table mode, create ascii table easily
Plug 'dhruvasagar/vim-table-mode'

"Comment
"Plugin 'tpope/vim-commentary'

"ultisnips engine
Plug 'SirVer/ultisnips'
"snippets
Plug 'honza/vim-snippets'

"QML Syntax
Plug 'peterhoeg/vim-qml'

"Indent
"Plugin 'Yggdroot/indentLine'

"YCM-Generator
Plug 'rdnetto/YCM-Generator'

"doxygen support 
Plug 'vim-scripts/DoxygenToolkit.vim', {'for': ['c', 'cpp', 'java', 'cs']}

function! BuildYCM(info)
	if a:info.status == 'installed' || a:info.force
		!./install.py --clang-completer --go-completer --js-completer --system-libclang --cs-completer --java-completer
	endif
endfunction

"complete plugin for many languague
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

"json
Plug 'leshill/vim-json'

"multi cursor
Plug 'terryma/vim-multiple-cursors'

"haskell
Plug 'neovimhaskell/haskell-vim'

"asyncrun
"Plugin 'skywind3000/asyncrun.vim'

"clip
Plug 'kana/vim-fakeclip'

"align
Plug 'junegunn/vim-easy-align'

"code colored
Plug 'jeaye/color_coded' , {'do' : 'mkdir build;cd build;cmake ..;make install'}

"airline
Plug 'vim-airline/vim-airline'

"signature
Plug 'kshenoy/vim-signature'

"diff direcotry
Plug 'will133/vim-dirdiff'

"javascript
Plug 'pangloss/vim-javascript'

"jsx syntax
Plug 'mxw/vim-jsx'

"emmet for html
Plug 'mattn/emmet-vim', {'for':['css', 'html', 'EmmetInstall']}

"enhance diff
Plug 'Chrisbra/vim-diff-enhanced'

call plug#end()

"Normal 
syntax on
filetype plugin on
filetype plugin indent on

set termguicolors
set matchpairs=(:),[:],{:},<:>
set ffs=unix,dos,mac
set ai
set si
set laststatus=2
set encoding=utf8
set fileencodings=ucs-bom,utf-8,gb18030,big5,latin1
set termencoding=utf8
set autoread
set autoindent
set hlsearch
set ignorecase
set incsearch
set nu
set ruler 
set cindent
set backspace=indent,eol,start	" more powerful backspacing
set wrap
set nowrapscan
set history=500
set stal=2
set backup
set backupdir=~/.cache/bak
set cursorline
if exists($TMUX)
	set cursorline
endif

"this can be fix sume redraw problem 
set lazyredraw
"do not change current dir
set noacd

"CtrlP
let g:ctrlp_by_filename = 1

"Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd Filetype markdown setlocal expandtab tabstop=4
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:vim_markdown_folding_disabled = 1

"tab width
set tabstop=4
set shiftwidth=4

"bak dir
if finddir("bak", $HOME . "/.cache/") == ""
	call mkdir($HOME . "/.cache/bak/")
endif

set backup
set backupdir=~/.cache/bak

"undo file
if finddir("undo", $HOME . "/.cache/") == ""
	call mkdir($HOME . "/.cache/undo/")
endif
set undodir=~/.cache/undo/
set undofile

"YCM
set completeopt=menu,preview,longest
let g:ycm_use_ultisnips_completer=1
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '!!'
let g:ycm_warning_symbol = '->'
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_add_preview_to_completeopt=1
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_cache_omnifunc=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Down>']
let g:ycm_python_binary_path = '/usr/bin/python3'

"syntastic
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"Molokai
set t_Co=256
set t_ut=
color molokai
let g:molokai_original = 1
let g:rehash256 = 1
"hi CursorLine term=underline ctermbg=237 guibg=#ADCCFF
"hi CursorLine  term=underline ctermbg=237 guibg=#232933


"UltiSnip
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsEditSplit="vertical"

"tagbar
let g:tagbar_autoclose = 1
let g:tagbar_left = 1
let g:tagbar_map_help = ""
"for go lang
let g:tagbar_type_go = {
			\ 'ctagstype' : 'go',
			\ 'kinds'     : [
				\ 'p:package',
				\ 'i:imports:1',
				\ 'c:constants',
				\ 'v:variables',
				\ 't:types',
				\ 'n:interfaces',
				\ 'w:fields',
				\ 'e:embedded',
				\ 'm:methods',
				\ 'r:constructor',
				\ 'f:functions'
			\ ],
			\ 'sro' : '.',
			\ 'kind2scope' : {
				\ 't' : 'ctype',
				\ 'n' : 'ntype'
			\ },
			\ 'scope2kind' : {
				\ 'ctype' : 't',
				\ 'ntype' : 'n'
			\ },
			\ 'ctagsbin'  : 'gotags',
			\ 'ctagsargs' : '-sort -silent'
			\ }
let g:tagbar_autopreview=1

"vim-go
let g:go_auto_type_info = 0
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_functions = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_list_type="quickfix"
let g:go_fmt_command = "goimports"
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

"syntastic
let g:syntastic_auto_loc_list = 0

"godef
let g:godef_split=0
let g:godef_same_file_in_same_window=1

"global gnu
set cscopeprg=gtags-cscope
if exists("gtags-cscope")
	set csprg=gtags-cscope
endif
set cscopequickfix=s-,t-,d-,g-,c-,f-,i-,e-

"NERD Tree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" Table-Mode
"let g:table_mode_corner_corner="+"

"Indent guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

"key map
noremap <F12> :set ff=unix<cr>
nnoremap <F2> :tabnew<cr>
noremap <F3> :cp<cr>
noremap <F4> :cn<cr>
set <S-F3>=[25~
set <S-F4>=[26~
noremap <S-F3> :lr<cr>
noremap <S-F4> :lne<cr>
"urxvt key map <S-F4> is <Undo>
noremap <Undo> :lne<cr>
nnoremap <c-\> :vimgrep /<c-r>=expand("<cword>")<cr>/ **/*
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
vnoremap <silent> <c-\> :call VisualSelection('gv')<CR>
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>
noremap <silent> gh :match MatchParen /\<<c-r>=expand("<cword>")<cr>\>/<cr>
noremap <silent> gH :match<cr>

"map
map j gj
map k gk
nnoremap <f5> :Explore<cr>
nnoremap <silent> <F1> :TagbarToggle<CR>
nnoremap <F11> :w!<CR>\|:silent make -j2\|redraw!<CR>
nnoremap <leader>w :silent w!<CR>
nnoremap <leader><space> :A<CR>
nnoremap <leader>q :BufExplorer<CR>
nnoremap <leader>r :%s/\<<C-R>=expand('<cword>')<CR>\>\C//g<left><left>

"autocmd
autocmd Filetype java setlocal cc=80
autocmd BufRead *.html nnoremap <buffer><F11> :silent<CR>:!chromium %<CR>:unsilent<CR>

"python 
autocmd BufRead *.py nnoremap <buffer><F11> :!python %<CR>
autocmd BufRead *.py setlocal expandtab tabstop=4 shiftwidth=4 cc=80
autocmd FileType python nnoremap gd :YcmCompleter GoTo<CR>

"QML make
autocmd BufRead *.qml nnoremap <F12> :!qml %<CR>

"C/C++ style
autocmd FileType c,cpp nnoremap <F12> :make<cr>
autocmd FileType c,cpp setlocal softtabstop=2 shiftwidth=2 tabstop=2 expandtab cc=80 
autocmd FileType c,cpp nnoremap gd :YcmCompleter GoTo<CR>
autocmd FileType c,cpp call AddGtags()
autocmd FileType c,cpp nnoremap <leader>g :cs find g <C-R>=expand("<cword>")<cr><cr>
autocmd FileType c,cpp nnoremap <leader>s :cs find s <C-R>=expand("<cword>")<cr><cr>
autocmd FileType c,cpp nnoremap <leader>t :cs find t <C-R>=expand("<cword>")<cr><cr>
autocmd FileType c,cpp vnoremap <leader>t y:cs find t <C-R>0<cr>
autocmd FileType c,cpp nnoremap <leader>f :cs find f <C-R>=expand("<cword>")<cr><cr>
autocmd FileType c,cpp nnoremap <leader>c :cs find c <C-R>=expand("<cword>")<cr><cr>


"Go
autocmd FileType go call InitGoProfile()

"javascript/Nodejs
autocmd FileType javascript nnoremap gd :YcmCompleter GoTo<CR>

"csharp
autocmd FileType cs nnoremap gd :YcmCompleter GoTo<CR>

"haskell
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`

"align
nmap \a <Plug>(EasyAlign)
xmap \a <Plug>(EasyAlign)

"cpp syntax scheme
let g:color_coded_enabled = 1
let g:color_coded_filetypes = ['c', 'cpp', 'objc']
if &diff
  let g:color_coded_enabled = 0
endif

"airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

" this must put at the end of vimrc
autocmd Filetype * call SetExtendVimrc()

function InitGoProfile() 
	set makeprg=go\ build
	if !exists("b:golang_vim")
		let b:golang_vim = 1
		nnoremap <buffer>gc :GoReferrers<cr>
		nnoremap <buffer><f11> :call RunGoMake("")<cr>
		nnoremap <buffer><f12> :GoImport 
		nnoremap <buffer><leader><f12> :GoDrop 
		nnoremap <buffer><f10> :GoTestFunc<cr>        	
		nnoremap <buffer><leader><f10> :GoTest<cr>    
	endif
endfunction

function FindFileRecuse(name, enddir)
	let pwd = getcwd()
	while 1
		if findfile(a:name, pwd . "/") != ""
			return pwd . "/" . a:name
		endif

		let pwd=fnamemodify(pwd, ":h")

		if pwd == a:enddir
			return 
		endif
	endwhile
endfunction

function AddGtags()
	let a:path = FindFileRecuse("GTAGS", $HOME)
	if a:path != ""
		exe "cs add " . a:path
	endif
endfunction

function FindYCMConfig()
	let a:ycm_conf = FindFileRecuse(".ycm_extra_conf.py", $HOME)
	if a:ycm_conf != ""
		let g:ycm_global_ycm_extra_conf = a:ycm_conf
	else
		if !exists(".ycm_extra_conf")
			silent !cp ~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py ./
		endif
		let g:ycm_global_ycm_extra_conf = '.ycm_extra_conf.py'
	endif
endfunction
autocmd FileType c,cpp,h,hpp call FindYCMConfig()

function! CmdLine(str)
	exe "menu Foo.Bar :" . a:str
	emenu Foo.Bar
	unmenu Foo
endfunction

function! VisualSelection(direction) range
	let l:saved_reg = @"
	execute "normal! vgvy"

	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")

	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	elseif a:direction == 'gv'
		call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
	elseif a:direction == 'replace'
		call CmdLine("%s" . '/'. l:pattern . '/')
	elseif a:direction == 'f'
		execute "normal /" . l:pattern . "^M"
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endfunction

function RunGoMake(file)
	if search("package\\s\\+main", 'b') != 0
		let a:cursor=getcurpos()
		GoRun	
		call setpos(".", a:cursor)
	else
		GoErrCheck
	endif
endfunction

function SetExtendVimrc()
	let a:vimrc = FindFileRecuse(".vim", $HOME)
	if a:vimrc != "" 
		exe "source " . a:vimrc
	endif
endfunction

"doxygen config
let g:DoxygenToolkit_briefTag_pre="@brief  " 
let g:DoxygenToolkit_paramTag_pre="@param  " 
let g:DoxygenToolkit_returnTag="@return  " 
"let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------" 
"let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------" 

"Enhance Diff
if &diff
	set diffopt+=iwhite
	let &diffexpr = 'EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif
