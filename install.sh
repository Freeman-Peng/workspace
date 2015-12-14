#!/bin/bash
wget -t 0 "https://github.com/VundleVim/Vundle.vim/archive/master.zip"
unzip master
mkdir -p ~/.vim
cp -rf Vundle.vim-master/* ~/.vim/
vim +PluginInstall +qall
