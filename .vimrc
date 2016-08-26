set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/Plugin/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim.git'

"fast move plugin, action key is <leader>\
"current <leader> = \
Plugin 'Lokaltog/vim-easymotion'

"fast switch file in directory
Plugin 'ctrlp.vim'

"syntax motion
Plugin 'scrooloose/syntastic.git'

"dirctory plugin keymap <F5>
Plugin 'scrooloose/nerdtree'
"add git plugin for nerdtree
Plugin 'Xuyuanp/nerdtree-git-plugin'

"color theme
Plugin 'tomasr/molokai'

"switch buffer
Plugin 'vim-scripts/bufexplorer.zip.git'

"function list for a file,  support go
Plugin 'majutsushi/tagbar'

"switch header file and source file for CPP
Plugin 'a.vim'

"surround quote
Plugin 'tpope/vim-surround.git'

"markdown syntax and function
Plugin 'plasticboy/vim-markdown.git'

"more repeat acion support with key "."
Plugin 'tpope/vim-repeat.git'

"go lang support 
Plugin 'fatih/vim-go.git'

"table mode, create ascii table easily
Plugin 'dhruvasagar/vim-table-mode.git'

"Comment
Plugin 'tpope/vim-commentary.git'

"ultisnips engine
Plugin 'SirVer/ultisnips'
"snippets
Plugin 'honza/vim-snippets'

"QML Syntax
Plugin 'peterhoeg/vim-qml.git'

"Indent
Plugin 'Yggdroot/indentLine.git'

"Color_coded
"Plugin 'jeaye/color_coded.git'

"YCM-Generator
Plugin 'rdnetto/YCM-Generator.git'

"complete plugin for many languague
Plugin 'Valloric/YouCompleteMe.git'

"json
Plugin 'elzr/vim-json.git'

"multi cursor
Plugin 'terryma/vim-multiple-cursors'

call vundle#end()

"Normal 
syntax on
filetype plugin on
filetype plugin indent on

set ffs=unix,dos,mac
set ai
set si
set laststatus=2
set encoding=utf8
set fileencoding=utf8
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
set history=500
set stal=2
set backup
set backupdir=~/.cache/bak
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
let g:ycm_python_binary_path = 'python'


"Molokai
set t_Co=256
color molokai
let g:molokai_original = 0
let g:rehash256 = 1


"UltiSnip
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" If you want :UltiSnipsEdit to split your window.
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

"vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
au filetype go let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
au filetype go let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
au FileType go nmap <Leader>e <Plug>(go-rename)

"syntastic
let g:syntastic_auto_loc_list = 0

"godef
let g:godef_split=0
let g:godef_same_file_in_same_window=1

"neocomplete
"let g:neocomplete#enable_at_startup = 1 

"global gnu
set cscopeprg=gtags-cscope
if exists("gtags-cscope")
	set csprg=gtags-cscope
endif
set cscopequickfix=s-,t-,d-,g-,c-,f-,i- 

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
let g:table_mode_corner_corner="+"

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
nnoremap <leader>g :cs find g <C-R>=expand("<cword>")<cr><cr>
nnoremap <leader>s :cs find s <C-R>=expand("<cword>")<cr><cr>
nnoremap <leader>t :cs find t <C-R>=expand("<cword>")<cr><cr>
nnoremap <leader>f :cs find f <C-R>=expand("<cword>")<cr><cr>
nnoremap <leader>c :cs find c <C-R>=expand("<cword>")<cr><cr>
nnoremap <leader>d :cs find d <C-R>=expand("<cword>")<cr><cr>
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
vnoremap <silent> gv :call VisualSelection('gv')<CR>
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>
noremap <silent> gh :match MatchParen /\<<c-r>=expand("<cword>")<cr>\>/<cr>
noremap <silent> gH :match<cr>

"map
map j gj
map k gk
nnoremap <f5> :NERDTree<cr>
nnoremap <silent> <F1> :TagbarToggle<CR>
nnoremap <F11> :w!<CR>\|:silent make -j2\|redraw!<CR>
nnoremap <leader>w :silent w!<CR>
nnoremap <leader><space> :A<CR>
nnoremap <leader>q :BufExplorer<CR>
nnoremap <leader>r :%s/\<<C-R>=expand('<cword>')<CR>\>\C//g<left><left>
nnoremap go :only<CR>

"autocmd
autocmd Filetype c,cpp,h  setlocal softtabstop=2 shiftwidth=2 tabstop=2 expandtab cc=80 
autocmd Filetype c,cpp,h nnoremap gd :YcmCompleter GoTo<CR>
autocmd Filetype java setlocal cc=80
autocmd BufRead *.py nnoremap <buffer><F11> :!python %<CR>
autocmd BufRead *.html nnoremap <buffer><F11> :silent<CR>:!chromium %<CR>:unsilent<CR>

"QML make
autocmd BufRead *.qml nnoremap <F12> :!qml %<CR>

"C style
autocmd FileType cpp,c nnoremap <F12> :make<cr>

autocmd FileType go call InitGoProfile()

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

function Findfile_recusion(name)
	let pwd = getcwd()
	while 1
		if findfile(a:name, pwd . "/") != ""
			return pwd . "/" . a:name
		endif

		let pwd=fnamemodify(pwd, ":h")

		if pwd == "/"
			return 
		endif
	endwhile
endfunction

function AddGtags()
	let a:path = Findfile_recusion("GTAGS")
	if a:path != ""
		exe "cs add " . a:path
	endif
endfunction
autocmd VimEnter * call AddGtags()

function FindYCMConfig()
	let a:ycm_conf = Findfile_recusion(".ycm_extra_conf.py")
	if a:ycm_conf != ""
		let g:ycm_global_ycm_extra_conf = a:ycm_conf
	else
		let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YoukCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
	endif
endfunction
autocmd BufEnter * call FindYCMConfig()

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


"markdown autocmd
set <S-F12>=[24$
autocmd FileType markdown nnoremap <S-F12> :call PreviewMarkDown()<cr>

function PreviewMarkDown()
	silent let a:ret = system("netstat -tln|grep 6419")
	if a:ret != ""
		silent exec "!pkill grip"|redraw!
	endif
	silent exec "!grip --quiet -b " . expand("%") . " 127.0.0.1:6149 2>/dev/null >/dev/null &"|redraw!
	let g:vim_markdown_preview_on=1
endfunction

autocmd BufUnload *.md,*.markdown call PreviewMarkDownClose()
function PreviewMarkDownClose()
	if exists("g:vim_markdown_preview_on")
		silent exec "!pkill grip"
	endif
endfunction
