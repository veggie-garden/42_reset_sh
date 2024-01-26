#!/usr/bin/env zsh

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    after_reset.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cheseo <cheseo@student.42seoul.kr>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/08/19 12:17:37 by cheseo            #+#    #+#              #
#    Updated: 2024/01/26 21:32:32 by cheseo           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

LRED=$'\033[1;31m'
LCYAN=$'\033[1;36m'
LGREEN=$'\033[1;32m'
YELLOW=$'\033[1;33m'
W=$'\033[1;37m'
NC=$'\033[0m'

echo "${W}Welcome to 42_reset_sh${NC}🥕"

# install oh_my_zsh
read -n1 -p "${YELLOW}Do you want to install oh_my_zsh? (y/n)${NC} " input_ohmyzsh
echo ""
if [ -n "$input_ohmyzsh" ] && [ "$input_ohmyzsh" = "y" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
	echo "${LRED}OK :(${NC}"
fi

# 42 header setting
read -n1 -p "${YELLOW}Do you want to change intra ID for header? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	read -p "${YELLOW}insert your intra ID:${NC} " username
	read -p "${YELLOW}insert your 42campus email (e.g. intraID@student.42seoul.kr):${NC} " email
	if [ -n "$username" ] && [ -n "$email" ]; then
		echo "" >> $HOME/.zshrc
		echo "# 42header setting" >> $HOME/.zshrc
		echo "export USER='$username'" >> $HOME/.zshrc
		echo "export MAIL='$email'" >> $HOME/.zshrc
		echo "let g:user42 = '$username'" >> $HOME/.vimrc
		echo "let g:mail42 = '$email'" >> $HOME/.vimrc
		source $HOME/.zshrc 2>/dev/null
		echo "${LGREEN}Done :D${NC}"
	else
		echo "⚠️  ${LRED}invalid input, failed to set user and mail for 42header :(${NC} ⚠️ "
	fi
else
	echo "${LRED}OK :(${NC}"
fi

# install 42toolbox
if [[ -x "$(find $HOME -type d -iname '42toolbox' 2>/dev/null)" ]]; then
	echo "🛠  ${LCYAN}42toolbox already installed${NC}"
else
	read -n1 -p "${YELLOW}Do you want to install 42toolbox? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		read -p "${YELLOW}Where do you want to install it? (g for goinfre / h for home / or insert the full path)${NC} " input
		if [ -n "$input" ] && [ "$input" = "g" ]; then
			toolPath="$HOME/goinfre"
			git clone https://github.com/alexandregv/42toolbox.git $toolPath/42toolbox
			echo "${LGREEN}Done :D${NC}"
		elif [ -n "$input" ] && [ "$input" = "h" ]; then
			toolPath="$HOME"
			git clone https://github.com/alexandregv/42toolbox.git $toolPath/42toolbox
			echo "${LGREEN}Done :D${NC}"
		elif [ -n "$input" ]; then
			toolPath="$input"
			git clone https://github.com/alexandregv/42toolbox.git $toolPath/42toolbox
			echo "${LGREEN}Done :D${NC}"
		else
			echo "⚠️  ${LRED}invalid path, 42toolbox installation failed :(${NC} ⚠️ "
		fi
	else
		echo "${LRED}42toolbox not installed :(${NC}"
	fi
fi

# ssh key reset
read -n1 -p "${YELLOW}Do you need your ssh key? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	./utils/init_ssh.sh
	echo "${LGREEN}Done :D${NC}"
else
	echo "${LRED}OK :(${NC}"
fi

# run vscode in terminal
read -n1 -p "${YELLOW}Do you want to open vscode by \"code .\" command? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	echo "" >> $HOME/.zshrc
	echo "# run vscode in terminal" >> $HOME/.zshrc
	echo "code () { VSCODE_CWD=\"\$PWD\" open -n -b \"com.microsoft.VSCode\" --args \$* ;}" >> $HOME/.zshrc
	source $HOME/.zshrc 2>/dev/null
	echo "${LGREEN}Done :D${NC}"
else
	echo "${LGREEN}OK :D${NC}"
fi

# install brew
brewPath="$(brew --prefix 2>/dev/null)"
if [[ -x $brewPath ]]; then
	echo "⚙️  ${LCYAN}brew is already at here: ${NC}${W}$brewPath${NC}"
else
	read -n1 -p "${YELLOW}If you want to change your dock, you have to install brew. Do you want to install brew? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		read -p "${YELLOW}Where do you want to install it? (g for goinfre / h for home / or insert the full path)${NC} " input
		if [ -n "$input" ] && [ "$input" = "g" ]; then
			brewPath="$HOME/goinfre"
		elif [ -n "$input" ] && [ "$input" = "h" ]; then
			brewPath="$HOME"
		elif [ -n "$input" ]; then
			brewPath="$input"
		else
			echo "⚠️  ${LRED}invalid path, exiting :(${NC} ⚠️ "
			if [ -n "$input_ohmyzsh" ] && ["$input_ohmyzsh" = "y"]; then
				zsh
			fi
			exit 1
		fi
		if [[ -x $brewPath/.brew ]]; then
			echo "# brew" >> $HOME/.zshrc
			echo "export brewPath=${brewPath}" >> $HOME/.zshrc && echo 'export PATH=$brewPath/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc 2>/dev/null && brew update
			echo "${LCYAN}brew already installed in${NC} ${W}$brewPath${NC}"
		else
			echo "💾 ${LCYAN}brew will be installed in${NC} ${W}$brewPath${NC} 💾"
			echo "" >> $HOME/.zshrc
			echo "# brew" >> $HOME/.zshrc
			git clone --depth=1 https://github.com/Homebrew/brew $brewPath/.brew && echo "export brewPath=${brewPath}" >> $HOME/.zshrc && echo 'export PATH=$brewPath/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc 2>/dev/null && brew update
			brewPath="$(brew --prefix)"
			echo "${LGREEN}Done :D${NC}"
		fi
	else
		if [ -n "$input_ohmyzsh" ] && ["$input_ohmyzsh" = "y"]; then
			zsh
		fi
   		echo "${LRED}brew not installed :(${NC}"
	fi
fi

source $HOME/.zshrc 2>/dev/null

# install tree
if [[ -x "$(brew --prefix tree 2>/dev/null)" ]]; then
	echo "🥕 ${LCYAN}tree already installed${NC}"
elif [ -x $brewPath ]; then
	read -n1 -p "${YELLOW}Do you want to install tree? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		brew install tree
		source $HOME/.zshrc 2>/dev/null
		echo "${LGREEN}Done :D${NC}"
	else
		echo "${LRED}tree not installed :(${NC}"
	fi
fi

# [set dock](https://gist.github.com/kamui545/c810eccf6281b33a53e094484247f5e8)
read -n1 -p "${YELLOW}Do you want to change your dock? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	echo "${W}Changing dock...${NC}"
	./utils/dock.sh
	echo "🏁 ${LGREEN}Restarted the Dock${NC}"
	echo "🥳 ${LGREEN}Finished creating default Dock${NC} 🥳"
else
	echo "${LGREEN}OK :)${NC}"
fi

# uninstall brew
read -n1 -p "${YELLOW}Do you want to remove brew? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	rm -rf $brewPath
	source $HOME/.zshrc 2>/dev/null
	echo "${LGREEN}Done :D${NC}"
else
	echo "${LGREEN}OK :D${NC}"
fi

echo "🎉 ${LCYAN}Setting Finished ${NC}🎉"
source $HOME/.zshrc 2>/dev/null
if [ -n "$input_ohmyzsh" ] && [ "$input_ohmyzsh" = "y" ]; then
	zsh
fi
