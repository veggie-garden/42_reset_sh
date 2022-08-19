#!/bin/bash
# ./set_header.sh

LGREEN=$'\033[1;32m'
NC=$'\033[0m'

# Set variables

if [ ! -z "$USER" ]
then
    echo "USER=`/usr/bin/whoami`" >> ~/.zshrc
    echo "export USER" >> ~/.zshrc
fi

if [ ! -z "$GROUP" ]
then
    echo "GROUP=`/usr/bin/id -gn $user`" >> ~/.zshrc
    echo "export GROUP" >> ~/.zshrc
fi

if [ ! -z "$MAIL" ]
then
    echo "MAIL="$USER@student.42.fr"" >> ~/.zshrc
    echo "export MAIL" >> ~/.zshrc
fi

mkdir -p ~/.vim/plugin

# Add stdheader to vim plugins
cp ./stdheader.vim ~/.vim/plugin/

source ~/.zshrc

echo "${LGREEN}Now you can use 42header plugin :D${NC}"
