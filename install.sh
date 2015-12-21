#!/bin/bash
which wget
if [ "x$?" == 0 ] ; then
	wget -t 0 "https://github.com/VundleVim/Vundle.vim/archive/master.zip" 
	getVimrc=1
else
	echo there is no wget
fi

which curl
if [ -v getVimrc && "x$?" == 0 ] ; then 
	curl -O "https://github.com/VundleVim/Vundle.vim/archive/master.zip"
else
	echo there is no curl
	exit 1
fi

unzip master > /dev/null 2>&1
mkdir -p ~/.vim
cp -rf Vundle.vim-master/* ~/.vim/
cp -rf .vimrc ~/
vim +PluginInstall +qall
which ctags && echo "There is no Ctags, the Plugin of Vim \"tagbar\" will not work "

#git
which git && echo "There is no git" || exit 1
cp -rf .gitconfig ~/
