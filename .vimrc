call plug#begin('~/.vim/plugged')

"fast move plugin, action key is <leader>\
"current <leader> = \
Plug 'Lokaltog/vim-easymotion'

"fast switch file in directory
Plug 'kien/ctrlp.vim'

"syntax checker
"Plug 'scrooloose/syntastic'

"dirctory plugin keymap <F5>
"Plug 'scrooloose/nerdtree'
"add git plugin for nerdtree
"Plug 'Xuyuanp/nerdtree-git-plugin'

"color theme
"Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'

Plug 'sheerun/vim-polyglot'
"switch buffer
Plug 'vim-scripts/bufexplorer.zip'

"function list for a file,  support go
Plug 'majutsushi/tagbar'

"surround quote
Plug 'tpope/vim-surround'

"markdown syntax and function
Plug 'plasticboy/vim-markdown'

"markdown-preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

"more repeat acion support with key "."
Plug 'tpope/vim-repeat'

"go lang support 
"Plug 'fatih/vim-go'

"table mode, create ascii table easily
Plug 'dhruvasagar/vim-table-mode'

"Comment
"Plugin 'tpope/vim-commentary'

"ultisnips engine
"Plug 'SirVer/ultisnips'
"snippets
"Plug 'honza/vim-snippets'

"QML Syntax
Plug 'peterhoeg/vim-qml'

"doxygen support 
Plug 'vim-scripts/DoxygenToolkit.vim', {'for': ['c', 'cpp', 'java', 'cs']}

"auto complete
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'
Plug 'mattn/vim-lsp-settings'
"Plug 'thomasfaingnaert/vim-lsp-ultisnips'
Plug 'thomasfaingnaert/vim-lsp-snippets'

"lsp autocomplete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'yami-beta/asyncomplete-omni.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'

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

"airline
Plug 'vim-airline/vim-airline'

"signature
Plug 'kshenoy/vim-signature'

"diff direcotry
Plug 'will133/vim-dirdiff'

"javascript
"Plug 'pangloss/vim-javascript'


"emmet for html
Plug 'mattn/emmet-vim', {'for':['css', 'html', 'EmmetInstall']}

"enhance diff
Plug 'Chrisbra/vim-diff-enhanced'
if has("patch-8.1.0360")
	set diffopt+=internal,algorithm:patience
endif

"draw
Plug 'gyim/vim-boxdraw'

"IME
Plug 'rlue/vim-barbaric'

"language syntax pack
Plug 'sheerun/vim-polyglot'

call plug#end()


"Normal 
syntax on
filetype plugin on
filetype plugin indent on

set cino+=N-s,g0,(1s
set hidden
set fo+=mB
set termguicolors
set matchpairs=(:),[:],{:},<:>,":",':'
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
set showmatch
set linebreak
set smartcase
if exists($TMUX)
	set cursorline
endif

"this can be fix sume redraw problem 
set lazyredraw
"do not change current dir
set noacd
"for vim-polyglot
set nocompatible

"CtrlP
let g:ctrlp_by_filename = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/](\.git|\.hg|\.svn|node_modules)$',
\ 'file': '\v\.(exe|so|dll)$',
\ 'link': 'some_bad_symbolic_links',
\ }
let g:ctrlp_show_hidden=1
			
"dart 
autocmd FileType dart call DartInit()

"plantuml
autocmd FileType plantuml nmap <F12> :call Plantuml_preview()<cr>

"Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd Filetype markdown setlocal expandtab tabstop=4
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:vim_markdown_folding_disabled = 1

"markdown preview
let g:mkdp_refresh_slow = 0
autocmd Filetype markdown nmap <F12> :MarkdownPreview<cr>

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

"multi curse
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_quit_key            = '<Esc>'

"imap <c-x><c-o> <Nul>

"syntastic
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

"Molokai
"set t_Co=256
"set t_ut=
"color molokai
"let g:molokai_original = 1
"let g:rehash256 = 1
"hi CursorLine term=underline ctermbg=237 guibg=#ADCCFF
"hi CursorLine  term=underline ctermbg=237 guibg=#232933
colorscheme onedark

"lsp setting
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'} " icons require GUI
highlight link LspErrorText SpellBad
highlight link LspWarningLine Underline
let g:lsp_highlights_enabled = 1
let g:lsp_textprop_enabled = 1
let g:lsp_highlight_references_enabled = 1
let g:lsp_cxx_hl_use_text_props = 1
let g:lsp_semantic_enabled = 1
let g:lsp_settings_root_markers = [
\   '.git',
\   '.git/',
\   '.svn',
\   '.hg',
\   '.bzr'
\ ]
autocmd User lsp_buffer_enabled setlocal omnifunc=lsp#complete


"asynccomplete
"default is on
let g:asyncomplete_auto_popup = 1
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"
let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_smart_completion = 1
" let g:asyncomplete_popup_delay = 100
"let g:asyncomplete_min_chars = 1


"UltiSnip
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
"let g:UltiSnipsUsePythonVersion = 3
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
	\ 'ctagsbin'  : $GOPATH . '/bin/gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }
"dart
let g:tagbar_type_dart = { 'ctagsbin': '/home/fepng/.pub-cache/bin/dart_ctags' }

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

"IME
let g:barbaric_ime = 'fcitx'
let g:barbaric_scope = 'buffer'
let g:barbaric_timeout = -1
let g:barbaric_fcitx_cmd = 'fcitx-remote'

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
hi IndentGuidesOdd  guibg=red   ctermbg=3
hi IndentGuidesEven guibg=green ctermbg=4

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
nnoremap <c-\> :grep <c-r>=expand("<cword>")<cr> -RI .
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
nnoremap <F11> :w!<CR>\|:silent make -j8\|redraw!<CR>
nnoremap <leader>w :silent w!<CR>
nnoremap <leader><space> :A<CR>
nnoremap <leader>q :BufExplorer<CR>


"java
autocmd Filetype java setlocal cc=80

"html
autocmd BufRead *.html nnoremap <buffer><F11> :silent<CR>:!chromium %<CR>:unsilent<CR>

"python 
autocmd BufRead *.py nnoremap <buffer><F11> :!python %<CR>
autocmd BufRead *.py setlocal expandtab tabstop=4 shiftwidth=4 cc=80

"QML make
autocmd BufRead *.qml nnoremap <F12> :!qml %<CR>

"lsp nmap 
augroup lsp_install
	nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
	autocmd User lsp_buffer_enabled nmap <buffer> <leader>h <plug>(lsp-hover)
	autocmd User lsp_buffer_enabled autocmd CursorHold <buffer> :LspHover<cr>
	autocmd User lsp_buffer_enabled setlocal list lcs=tab:┆\ 
	let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.tsx,*.jsx,*.rs,*.go,*.dart call execute('LspDocumentFormatSync')
augroup END

"C/C++ style
autocmd FileType c,cpp nnoremap <F12> :make<cr>
autocmd FileType c,cpp setlocal noexpandtab cc=80 
autocmd FileType c,cpp call AddGtags()
autocmd FileType c,cpp nnoremap <leader>g :cs find g <C-R>=expand("<cword>")<cr><cr>
autocmd FileType c,cpp nnoremap <leader>s :cs find s <C-R>=expand("<cword>")<cr><cr>
autocmd FileType c,cpp nnoremap <leader>t :cs find t <C-R>=expand("<cword>")<cr><cr>
autocmd FileType c,cpp vnoremap <leader>t :cs find t <C-R><cr>
autocmd FileType c,cpp nnoremap <leader>f :cs find f <C-R>=expand("<cword>")<cr><cr>
autocmd FileType c,cpp nnoremap <leader>c :cs find c <C-R>=expand("<cword>")<cr><cr>
autocmd FileType c,cpp nnoremap <leader>d :scs find d <C-R>=expand("<cword>")<cr><cr>
autocmd FileType c,cpp nnoremap <leader>e :scs find e \<<C-R><C-W>\><cr><cr>
autocmd FileType c,cpp nnoremap <F11> :w!<CR>\|:silent make -j8\|redraw!<CR>
autocmd FileType c,cpp setlocal cino=N-s,g0,(0,W2s
"autocmd FileType c,cpp :setlocal updatetime=3000
autocmd FileType c,cpp autocmd CursorHold <buffer> :LspHover<cr>
autocmd FileType c,cpp nnoremap <buffer> <leader>h :LspHover<cr>

"qml
autocmd FileType *.qml nnoremap <F12> :!qml <C-R>=expand("<cfile>")<cr>


"Go
autocmd FileType go autocmd BufWritePre <buffer> LspDocumentFormatSync

"diff
autocmd BufWritePost * if &diff == 1|diffupdate|endif

"R
autocmd FileType r autocmd BufWritePre <buffer> LspDocumentFormatSync

"backup
function BackupConfig()
	let file_dir = $HOME . '/.cache/bak' . fnamemodify(expand('%:p'),':h')
	call mkdir(file_dir, 'p')
	let &backupdir = file_dir
endfunction

autocmd BufWritePre * call BackupConfig()

"mail
autocmd Filetype mail setlocal fo+=am

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

"airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

function FindFileRecurseUntilRoot(fname, enddir)
	let l:dir = getcwd()
	let l:enddir = expand(a:enddir)
	"keep $HOME/.vimrc load once

	while 1
		let l:fpath =  l:dir . "/" . a:fname
		if filereadable(l:fpath)
			return l:fpath
		endif

		let l:dir=fnamemodify(l:dir, ":h:p")

		if l:dir == l:enddir || l:dir == "/"
			return ""
		endif
	endwhile
endfunction

function AddGtags()
	let addtag_path = FindFileRecurseUntilRoot("GTAGS", $HOME)
	if addtag_path != ""
		exe "cs add " . addtag_path
	endif
endfunction

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
	"append seting must include setting in first line
	let l:vimrc = FindFileRecurseUntilRoot(".vimrc", $HOME)
	if l:vimrc != "" && l:vimrc != expand("~/.vimrc")
		let l:line = readfile(l:vimrc, '', 1)
		if !empty(l:line) && stridx(l:line[0], "setting") != -1
			exe "source " . l:vimrc
		endif
	endif
endfunction

"doxygen config
let g:DoxygenToolkit_briefTag_pre="@brief  " 
let g:DoxygenToolkit_paramTag_pre="@param  " 
let g:DoxygenToolkit_returnTag="@return  " 
let g:DoxygenToolkit_commentType = "C++"
"let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------" 
"let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------" 

"Enhance Diff
if &diff
	set diffopt+=iwhite
	let &diffexpr = 'EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

"load append setting once
call SetExtendVimrc()


function Plantuml_preview()
	if &filetype != 'plantuml'
		return
	endif

	let b:imgname=expand("%:t:r").".png"
	bufdo autocmd BufWritePost * call job_start(["/usr/bin/plantuml", expand("%:t")])
	call job_start(["/usr/bin/plantuml", expand("%:t")])

	call writefile(["<html><body><script type='text/javascript'> setInterval(function() { document.getElementById('preview').src='".b:imgname."?' + (new Date()).getTime(); }, 500);</script><img id='preview' src='".b:imgname."'/></body></html>"], ".preview.html")

	bufdo autocmd BufUnload * :call job_start(["/usr/bin/rm", ".preview.html"])

	call job_start(["exo-open", ".preview.html"])
endfunction

function DartInit()
	setlocal ts=2
	setlocal softtabstop=2
	setlocal shiftwidth=2
	setlocal expandtab
	setlocal cc=80
endfunction

"global grep ignore sample
let grepignoredir=[]
if !empty(grepignoredir)
	let &gp="grep -n \$\* /dev/null "  . join(map(g:grepignoredir, '"--exclude-dir=" . v:val . " "'), " ")
endif
