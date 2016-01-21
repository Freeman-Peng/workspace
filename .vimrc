set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/Plugin/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'ctrlp.vim'
Plugin 'scrooloose/syntastic.git'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tomasr/molokai'
Plugin 'vim-scripts/bufexplorer.zip.git'
"Plugin 'bling/vim-airline.git'
"Plugin 'Shougo/neocomplete'
"Plugin 'Shougo/neosnippet'
"Plugin 'Shougo/neosnippet-snippets'
Plugin 'majutsushi/tagbar'
Plugin 'a.vim'
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-surround.git'
Plugin 'plasticboy/vim-markdown.git'
Plugin 'dgryski/vim-godef'
Plugin 'tpope/vim-repeat.git'
"Plugin 'Blackrush/vim-gocode'
Plugin 'fatih/vim-go.git'
Plugin 'dhruvasagar/vim-table-mode.git'
call vundle#end()


"Normal 
syntax on
filetype plugin on
filetype plugin indent on

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

"tab width
set tabstop=4
set shiftwidth=4

"undo file
if finddir("undo", $HOME . "/.cache/") == ""
	call mkdir($HOME . "/.cache/undo/")
endif
set undodir=~/.cache/undo/
set undofile

"YCM
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '!!'
let g:ycm_warning_symbol = '->'
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_key_list_select_completion = ['<Down>']
set completeopt=longest,menu,preview
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"key map
map <F3> :cp<cr>
map <F4> :cn<cr>


"AirLine
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"set laststatus=2
"let g:airline_powerline_fonts = 1

"Molokai
set t_Co=256
color molokai
let g:molokai_original = 0
let g:rehash256 = 1

"UltiSnip
let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-h>"
let g:UltiSnipsJumpBackwardTrigger="<c-l>"

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


"key map
noremap <F12> :set ff=unix<cr>
noremap <F3> :cp<cr>
noremap <F4> :cn<cr>
nnoremap <leader>g :cs find g <C-R>=expand("<cword>")<cr><cr>
nnoremap <leader>s :cs find s <C-R>=expand("<cword>")<cr><cr>
nnoremap <leader>t :cs find t <C-R>=expand("<cword>")<cr><cr>
nnoremap <leader>f :cs find f <C-R>=expand("<cword>")<cr><cr>
nnoremap <leader>c :cs find c <C-R>=expand("<cword>")<cr><cr>
nnoremap <leader>d :cs find d <C-R>=expand("<cword>")<cr><cr>
nnoremap <F2> :tabnew<cr>
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
vnoremap <silent> gv :call VisualSelection('gv')<CR>
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>
noremap <silent> gh :match MatchParen /\<<c-r>=expand("<cword>")<cr>\>/<cr>
noremap <silent> gH :match<cr>

"map
map j gj
map k gk
nnoremap <silent> <F1> :TagbarToggle<CR>
nnoremap <F11> :w!<CR>\|:silent make -j2\|redraw!<CR>
nnoremap <leader>w :silent w!<CR>
nnoremap <leader><space> :A<CR>
nnoremap <leader>q :BufExplorer<CR>
nnoremap <leader>r :%s/\<<C-R>=expand('<cword>')<CR>\>\C//g<left><left>
nnoremap go :only<CR>
nnoremap <leader>1 :!cp -rf ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py ./<CR>

"autocmd
autocmd Filetype c,cpp,h  setlocal softtabstop=2 shiftwidth=2 tabstop=2 expandtab cc=80 
autocmd Filetype c,cpp,h nnoremap gd :YcmCompleter GoTo<CR>
autocmd Filetype java setlocal cc=80
autocmd BufRead *.py nnoremap <buffer><F11> :!python %<CR>
autocmd BufRead *.md nnoremap <buffer><F11> :silent<CR>:!pandoc -s -f markdown_github -t html5 % -o /tmp/md.html\|chromium /tmp/md.html<CR>:unsilent<CR>
autocmd BufRead *.html nnoremap <buffer><F11> :silent<CR>:!chromium %<CR>:unsilent<CR>


autocmd BufRead *.go nnoremap <buffer><f11> :call RunGoMake()<cr>
autocmd BufRead *.go setlocal makeprg=go\ build

function Findfile_recusion(name)
	let pwd = getcwd()
	while 1
		if findfile(a:name, pwd . "/") != ""
			return pwd . "/" . a:name
		endif

		let idx=matchend(pwd, ".*/")

		if idx - 1 >= 0
			let pwd=strpart(pwd, 0, idx - 1)
		else
			return 
		endif
	endwhile
endfunction

let s:gtags_path = Findfile_recusion("GTAGS")
if s:gtags_path != ""
	exe "cs add " . s:gtags_path
	let tags = s:gtags_path
endif

let s:ycm_conf = Findfile_recusion(".ycm_extra_conf.py")
if s:ycm_conf != ""
	let g:ycm_global_ycm_extra_conf = s:ycm_conf
else
	let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
endif

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

function RunGoMake()
	if search("package\\s\\+main", 'b') != 0
		setlocal makeprg=go\ run
		make %
	else
		setlocal makeprg=go\ build
		silent make
		redraw!
	endif
endfunction
