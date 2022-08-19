# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    resetting.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cheseo <cheseo@student.42seoul.kr>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/08/19 12:17:37 by cheseo            #+#    #+#              #
#    Updated: 2022/08/19 12:36:45 by cheseo           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#/usr/bin/env bash

LRED=$'\033[1;31m'
LCYAN=$'\033[1;36m'
LGREEN=$'\033[1;32m'
YELLOW=$'\033[1;33m'
W=$'\033[1;37m'
NC=$'\033[0m'

# 42 header
if [[ -x $HOME/.vim/plugin ]]; then
	echo "${LCYAN}42header plugin already installed"
else
	read -n1 -p "${YELLOW}Do you want to install 42header plugin? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		cp utils/.vimrc $HOME
		./set_header.sh
	else
		echo "${LRED}OK :(${NC}"
	fi
fi

# download 42toolbox
if [[ -x $HOME/42toolbox ]]; then
        echo "${LCYAN}42toolbox already installed${NC}"
else
	read -n1 -p "${YELLOW}Do you want to install 42toolbox? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		git clone https://github.com/alexandregv/42toolbox.git ~/42toolbox
		echo "${LGREEN}Done :D${NC}"
	else
		echo "${LRED}42toolbox not installed :(${NC}"
	fi
fi

# ssh key reset
read -n1 -p "${YELLOW}Do you need your ssh key? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	./init_ssh.sh
	echo "${LGREEN}Done :D${NC}"
else
	echo "${LRED}OK :(${NC}"
fi

# install brew in goinfre
read -n1 -p "${YELLOW}If you want to change your dock, you have to install brew. Do you want to install brew? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	rm -rf $HOME/goinfre/.brew
	read -p "${YELLOW}Where do you want to install it? (g for goinfre / h for home / or insert the path${NC} ${LRED}[the folder will be created under your home directory]${NC}${YELLOW})${NC} " input
	if [ -n "$input" ] && [ "$input" = "g" ]; then
		brewPath="$HOME/goinfre"
	elif [ -n "$input" ] && [ "$input" = "h" ]; then
		brewPath="$HOME"
	elif [ -n "$input" ]; then
		brewPath="$HOME/$input"
	else
		echo "⚠️  ${LRED}invalid path, exiting :(${NC} ⚠️ "
		exit 1
	fi
	if [[ -x $brewPath/.brew ]]; then
		echo "${LCYAN}brew already installed in${NC} ${W}$brewPath${NC}"
	else
		echo "💾 ${LCYAN}brew will be installed in${NC} ${W}$brewPath${NC} 💾"
		git clone --depth=1 https://github.com/Homebrew/brew $brewPath/.brew && echo 'export PATH=$brewPath/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc && brew update
		echo "${LGREEN}Done :D${NC}"
	fi
else
   	echo "⚠️  ${LRED}brew not installed, exiting :(${NC} ⚠️ "
	exit 1
fi

# install tree
if [[ -x $brewPath/.brew/bin/tree ]]; then
	echo "${LCYAN}tree already installed${NC}"
else
	read -n1 -p "${YELLOW}Do you want to install tree? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		brew install tree
		echo "${LGREEN}Done :D${NC}"
	else
		echo "${LRED}tree not installed :(${NC}"
	fi
fi

# [set dock](https://appleshare.it/posts/use-dockutil-in-a-script/)
if [[ -x $brewPath/.brew/bin/dockutil ]]; then
	echo "${LCYAN}dockutil already installed${NC}"
else
	read -n1 -p "${YELLOW}Do you want to install dockutil to change your dock? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		brew install dockutil
		echo "${LGREEN}Done :D${NC}"
	else
		echo "⚠️  ${LRED}dockutil not installed, exiting :(${NC} ⚠️  "
		exit 1
	fi
fi

# Path
apps=(
"/System/Applications/Launchpad.app"
"/Applications/Google Chrome.app"
"/Applications/Visual Studio Code.app"
"/Applications/Slack.app"
"/Applications/iTerm.app"
"/System/Applications/Notes.app"
"/System/Applications/System Preferences.app"
)

# Create a clean Dock
dockutil --remove all --no-restart
echo "🧹 ${LGREEN}clean-out the Dock${NC}"

# Loop to check whether App is installed or not"
for app in "${apps[@]}";
do
	if [[ -e ${app} ]]; then
		dockutil --add "$app" --no-restart;
	else
		echo "${app} not installed"
	fi
done

# Kill dock to use new settings
killall -KILL Dock
echo "🏁 ${LGREEN}Restarted the Dock${NC}"

echo "🥳 ${LGREEN}Finished creating default Dock${NC} 🥳"

# uninstall dockutil
echo "${LGREEN}removing dockutil${NC}"
brew uninstall dockutil

echo "🎉 ${LCYAN}Setting Finished ${NC} 🎉"
