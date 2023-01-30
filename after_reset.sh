#/usr/bin/env zsh

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    after_reset.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cheseo <cheseo@student.42seoul.kr>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/08/19 12:17:37 by cheseo            #+#    #+#              #
#    Updated: 2023/01/30 21:02:40 by cheseo           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

LRED=$'\033[1;31m'
LCYAN=$'\033[1;36m'
LGREEN=$'\033[1;32m'
YELLOW=$'\033[1;33m'
W=$'\033[1;37m'
NC=$'\033[0m'

echo "${W}Welcome to is reset_sh${NC}🥕"

# install 42 header
read -n1 -p "${YELLOW}Do you want to change intra ID for header? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	read -p "${YELLOW}insert your intra ID:${NC} " username
	if [ -n "$username" ]; then
		echo "" >> $HOME/.zshrc
		echo "# 42header setting" >> $HOME/.zshrc
		echo "export USER='$username'" >> $HOME/.zshrc
		echo "export MAIL='$username@student.42seoul.kr'" >> $HOME/.zshrc
		echo "let g:user42 = '$username'" >> $HOME/.vimrc
		echo "let g:mail42 = '$username@student.42seoul.kr'" >> $HOME/.vimrc
		source $HOME/.zshrc 2>/dev/null
		echo "${LGREEN}Done :D${NC}"
	else
		echo "⚠️  ${LRED}invalid input, failed to set user and mail for 42header :(${NC} ⚠️ "
	fi
else
	echo "${LRED}OK :(${NC}"
fi

# install 42toolbox
if [[ -x "$(find ~ -type d -iname '42toolbox' 2>/dev/null)" ]]; then
	echo "🛠  ${LCYAN}42toolbox already installed${NC}"
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
	./utils/init_ssh.sh
	echo "${LGREEN}Done :D${NC}"
else
	echo "${LRED}OK :(${NC}"
fi

# install brew
brewPath="$(brew --prefix 2>/dev/null)"
if [[ -x $brewPath ]]; then
	echo "⚙️  ${LCYAN}brew is already at here: ${NC}${W}$brewPath${NC}"
else
	read -n1 -p "${YELLOW}If you want to change your dock, you have to install brew. Do you want to install brew? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
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
   		echo "⚠️  ${LRED}brew not installed, exiting :(${NC} ⚠️ "
		exit 1
	fi
fi

source $HOME/.zshrc 2>/dev/null

# install tree
if [[ -x "$(brew --prefix tree 2>/dev/null)" ]]; then
	echo "🥕 ${LCYAN}tree already installed${NC}"
else
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

# [set dock](https://appleshare.it/posts/use-dockutil-in-a-script/)
dockPath="$(brew --prefix dockutil 2>/dev/null)"
if [[ -x $dockPath ]]; then
	echo "${LCYAN}dockutil already installed${NC}"
else
	read -n1 -p "${YELLOW}Do you want to install dockutil to change your dock? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		brew install dockutil
		source $HOME/.zshrc 2>/dev/null
		echo "${LGREEN}Done :D${NC}"
	else
		echo "${LRED}dockutil not installed :(${NC}"
	fi
fi

# Change the path if you want more/less applications to be in your dock
apps=(
"/System/Applications/Launchpad.app"
"/Applications/Google Chrome.app"
"/Applications/Visual Studio Code.app"
"/Applications/Slack.app"
"/Applications/iTerm.app"
"/System/Applications/Notes.app"
"/System/Applications/System Preferences.app"
"${HOME}/Downloads"
)

if [[ -x $dockPath ]]; then
	# Create a clean Dock
	dockutil --remove all --no-restart
	echo "🧹 ${LGREEN}clean-out the Dock${NC}"

	# Loop to check whether App is installed or not"
	for app in "${apps[@]}";
	do
		if [[ -e ${app} ]]; then
			dockutil --add "$app" --no-restart;
		else
			echo "${LRED}${app} not installed${NC}"
		fi
	done

	# Kill dock to use new settings
	killall -KILL Dock
	echo "🏁 ${LGREEN}Restarted the Dock${NC}"

	echo "🥳 ${LGREEN}Finished creating default Dock${NC} 🥳"

	# uninstall dockutil
	echo "${LGREEN}removing dockutil${NC}"
	brew uninstall dockutil
	source $HOME/.zshrc 2>/dev/null
fi

read -n1 -p "${YELLOW}Do you want to remove brew? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	rm -rf $brewPath
	source $HOME/.zshrc 2>/dev/null
	echo "${LGREEN}Done :D${NC}"
else
	echo "${LGREEN}OK :D${NC}"
fi

read -n1 -p "${YELLOW}Do you want to open vscode by \"code .\" command? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	echo "" >> $HOME/.zshrc
	echo "# run vscode in terminal" >> $HOME/.zshrc
	echo "code () { VSCODE_CWD=\"\$PWD\" open -n -b \"com.microsoft.VSCode\" --args $* ;}" >> $HOME/.zshrc
	source $HOME/.zshrc 2>/dev/null
	echo "${LGREEN}Done :D${NC}"
else
	echo "${LGREEN}OK :D${NC}"
fi

source $HOME/.zshrc 2>/dev/null
echo "🎉 ${LCYAN}Setting Finished ${NC}🎉"
exec zsh -l
