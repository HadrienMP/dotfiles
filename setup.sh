#!/bin/bash
echo $0
currentDir=`dirname "$0"`
echo $currentDir
ln -s $currentDir/.vimrc ~/.vimrc 
ln -s $currentDir/tmux.conf ~/.tmux.conf
echo "[include]" >> ~/.gitconfig
echo "  path=${currentDir}/.gitconfig" >> ~/.gitconfig
