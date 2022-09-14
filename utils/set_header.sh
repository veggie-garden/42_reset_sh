#!/bin/bash
# ./set_header.sh

LGREEN=$'\033[1;32m'
NC=$'\033[0m'

mkdir -p ~/.vim/plugin

# Add stdheader to vim plugins
cp ./stdheader.vim ~/.vim/plugin/

echo "${LGREEN}Now you can use 42header plugin :D${NC}"
