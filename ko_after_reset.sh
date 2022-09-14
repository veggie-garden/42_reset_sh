#/usr/bin/env bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ko_after_reset.sh                                  :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cheseo <cheseo@student.42seoul.kr>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/08/19 12:17:37 by cheseo            #+#    #+#              #
#    Updated: 2022/09/14 11:54:52 by cheseo           ###   ########.fr        #
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
if [[ -x $HOME/.vim/plugin ]]; then
	echo "${LCYAN}42header 플러그인이 이미 설치되어 있습니다.${NC}"
	read -n1 -p "${YELLOW}인트라 ID를 변경하고 싶습니까? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		read -p "${YELLOW}인트라 ID를 입력해주세요:${NC} " username
		if [ -n "$username" ]; then
			echo "let g:user42 = '$username'" >> ~/.vimrc
			echo "let g:mail42 = '$username@student.42seoul.kr'" >> ~/.vimrc
			sh ./utils/set_header.sh
		else
			echo "⚠️  ${LRED}유효하지 않은 입력으로 헤더 설정에 실패했습니다 :(${NC} ⚠️ "
		fi
	else
		echo "${LGREEN}OK :)${NC}"
	fi
else
	read -n1 -p "${YELLOW}42헤더 플러그인을 설치할까요? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		read -p "${YELLOW}인트라 ID를 입력해주세요:${NC} " username
		if [ -n "$username" ]; then
			echo "let g:user42 = '$username'" >> ~/.vimrc
			echo "let g:mail42 = '$username@student.42seoul.kr'" >> ~/.vimrc
			sh ./utils/set_header.sh
		else
			echo "⚠️  ${LRED}유효하지 않은 입력으로 헤더 설정에 실패했습니다 :(${NC} ⚠️ "
		fi
	else
		echo "${LRED}OK :(${NC}"
	fi
fi

# install 42toolbox
if [[ -x $HOME/42toolbox ]]; then
        echo "${LCYAN}42toolbox는 이미 설치되어 있습니다.${NC}"
else
	read -n1 -p "${YELLOW}42toolbox를 설치할까요? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		git clone https://github.com/alexandregv/42toolbox.git ~/42toolbox
		echo "${LGREEN}Done :D${NC}"
	else
		echo "${LRED}42toolbox를 설치하지 않았습니다 :(${NC}"
	fi
fi

# ssh key reset
read -n1 -p "${YELLOW}ssh키가 필요하신가요? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	./utils/ko_init_ssh.sh
	echo "${LGREEN}Done :D${NC}"
else
	echo "${LRED}OK :(${NC}"
fi

# install brew
rm -rf $HOME/goinfre/brew
read -n1 -p "${YELLOW}Dock을 변경하려면 brew를 설치해야 합니다. brew를 설치할까요? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	read -p "${YELLOW}어디에 저장할까요? (g for goinfre / h for home / 원하는 경로를 입력해주세요${NC} ${LRED}[홈 디렉토리에 생성됩니다]${NC}${YELLOW})${NC} " input
	if [ -n "$input" ] && [ "$input" = "g" ]; then
		brewPath="$HOME/goinfre"
	elif [ -n "$input" ] && [ "$input" = "h" ]; then
		brewPath="$HOME"
	elif [ -n "$input" ]; then
		brewPath="$HOME/$input"
	else
		echo "⚠️  ${LRED}유효하지 않은 경로임으로 종료합니다 :(${NC} ⚠️ "
		exit 1
	fi
	if [[ -x $brewPath/brew ]]; then
		echo "${LCYAN}brew는 이미${NC} ${W}$brewPath${NC}에 설치되어 있습니다."
	else
		echo "💾 ${LCYAN}brew 위치: ${NC} ${W}$brewPath${NC} 💾"
		#echo "export brewPath=${brewPath}" >> $HOME/.zshrc
		git clone --depth=1 https://github.com/Homebrew/brew $brewPath/brew && echo "export brewPath=${brewPath}" >> $HOME/.zshrc && echo 'export PATH=$brewPath/brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc && brew update
		echo "${LGREEN}Done :D${NC}"
	fi
else
   	echo "⚠️  ${LRED}brew가 설치되지 않았습니다. 종료합니다 :(${NC} ⚠️ "
	exit 1
fi

# install tree
if [[ -x $brewPath/brew/bin/tree ]]; then
	echo "${LCYAN}tree는 이미 설치되어 있습니다.${NC}"
else
	read -n1 -p "${YELLOW}tree를 설치할까요? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		brew install tree
		echo "${LGREEN}Done :D${NC}"
	else
		echo "${LRED}tree가 설치되지 않았습니다 :(${NC}"
	fi
fi

# [set dock](https://appleshare.it/posts/use-dockutil-in-a-script/)
if [[ -x $brewPath/brew/bin/dockutil ]]; then
	echo "${LCYAN}dockutil은 이미 설치되어 있습니다.${NC}"
else
	read -n1 -p "${YELLOW}dockutil을 설치할까요? dock을 변경하려면 설치해야 합니다 (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		brew install dockutil
		echo "${LGREEN}Done :D${NC}"
	else
		echo "${LRED}dockutil이 설치되지 않았습니다 :(${NC}"
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

if [[ -x $brewPath/brew/bin/dockutil ]]; then
	# Create a clean Dock
	dockutil --remove all --no-restart
	echo "🧹 ${LGREEN}Dock 치우는 중${NC}"

	# Loop to check whether App is installed or not"
	for app in "${apps[@]}";
	do
		if [[ -e ${app} ]]; then
			dockutil --add "$app" --no-restart;
		else
			echo "${LRED}${app}(은/는) 설치되어 있지 않습니다.${NC}"
		fi
	done

	# Kill dock to use new settings
	killall -KILL Dock
	echo "🏁 ${LGREEN}Dock 재시작${NC}"

	echo "🥳 ${LGREEN}Dock 변경 완료${NC} 🥳"

	# uninstall dockutil
	echo "${LGREEN}dockutil 삭제${NC}"
	brew uninstall dockutil
fi

read -n1 -p "${YELLOW}Do you want to remove brew? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	rm -rf $brewPath/brew
	echo "${LGREEN}Done :D${NC}"
else
	echo "${LGREEN}OK :D${NC}"
fi

echo "🎉 ${LCYAN}Setting Finished ${NC}🎉"
