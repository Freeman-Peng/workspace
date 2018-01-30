#!/bin/bash
set -e
curl -O "https://github.com/VundleVim/Vundle.vim/archive/master.zip"

unzip master > /dev/null 2>&1
mkdir -p ~/.vim
cp -rf Vundle.vim-master/* ~/.vim/

#git
cp -rf .gitconfig ~/
echo "intput username of git:"
read -r username
sed -i "s/username/$username/g" ~/.gitconfig

echo "input email of git:"
read -r email
sed -i "s/useremail/$email/g" ~/.gitconfig

cp -rf .vimrc ~/

vim +PluginInstall +qall
