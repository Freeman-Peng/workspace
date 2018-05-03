#!/bin/bash
set -e
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#git
cp -rf .gitconfig ~/
echo "intput username of git:"
read -r username
sed -i "s/username/$username/g" ~/.gitconfig

echo "input email of git:"
read -r email
sed -i "s/useremail/$email/g" ~/.gitconfig

cp -rf .vimrc ~/

vim +PlugInstall +qall
