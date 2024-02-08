#!/usr/bin/env bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    ko_after_reset.sh                                  :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cheseo <cheseo@student.42seoul.kr>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/08/19 12:17:37 by cheseo            #+#    #+#              #
#    Updated: 2024/02/07 19:52:42 by cheseo           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

LRED=$'\033[1;31m'
LCYAN=$'\033[1;36m'
LGREEN=$'\033[1;32m'
YELLOW=$'\033[1;33m'
W=$'\033[1;37m'
NC=$'\033[0m'

# install oh_my_zsh
read -n1 -p "${YELLOW}oh_my_zsh를 설치하겠습니까? (y/n)${NC} " input_ohmyzsh
echo ""
if [ -n "$input_ohmyzsh" ] && [ "$input_ohmyzsh" = "y" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
else
	echo "${LRED}OK :(${NC}"
fi

# 42 header setting
read -n1 -p "${YELLOW}인트라 ID를 변경하고 싶습니까? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	read -p "${YELLOW}인트라 ID를 입력해주세요:${NC} " username
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
		echo "⚠️  ${LRED}유효하지 않은 입력으로 헤더 설정에 실패했습니다 :(${NC} ⚠️ "
	fi
else
	echo "${LRED}OK :(${NC}"
fi

# github config setting
read -n1 -p "${YELLOW}GitHub config의 user.name과 user.email을 변경하고 싶습니까? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	read -p "${YELLOW}GitHub user name:${NC} " username
	read -p "${YELLOW}GitHub user email:${NC} " useremail
	if [ -n "$username" ] && [ -n "$useremail" ]; then
		git config --global user.name "$username"
		git config --global user.email "$useremail"
	else
		echo "⚠️  ${LRED}유효하지 않은 입력으로 GitHub config 설정에 실패했습니다 :(${NC} ⚠️ "
	fi
else
	echo "${LRED}OK :(${NC}"
fi

# install 42toolbox
if [[ -x "$(find $HOME -type d -iname '42toolbox' 2>/dev/null)" ]]; then
	echo "🛠  ${LCYAN}42toolbox는 이미 설치되어 있습니다.${NC}"
else
	read -n1 -p "${YELLOW}42toolbox를 설치할까요? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		read -p "${YELLOW}어디에 설치할까요? (g for goinfre / h for home / 원하는 전체 경로를 입력하세요)${NC} " input
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
			echo "⚠️  ${LRED}유효하지 않은 경로입니다. 42toolbox 설치에 실패했습니다. :(${NC} ⚠️ "
		fi
	else
		echo "${LRED}42toolbox를 설치하지 않았습니다 :(${NC}"
	fi
fi

# ssh key
if [ -f ~/.ssh/id_rsa ]; then
	echo -e "${white}SSH key \`${LCYAN}~/.ssh/id_rsa${W}\`가 이미 존재합니다${NC}"
else
	read -n1 -p "${YELLOW}ssh키가 필요하신가요? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		./utils/ko_init_ssh.sh
		echo "${LGREEN}Done :D${NC}"
	else
		echo "${LRED}OK :(${NC}"
	fi
fi

# run vscode in terminal
read -n1 -p "${YELLOW}\"code .\" 명령어를 사용하시겠습니까? 터미널에서 vscode를 열어주는 명령어입니다. (y/n)${NC} " input
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
	echo "⚙️  ${LCYAN}brew가 이미 이 경로에 있습니다: ${NC}${W}$brewPath${NC}"
else
	read -n1 -p "${YELLOW}brew를 설치할까요? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		read -p "${YELLOW}어디에 설치할까요? (g for goinfre / h for home / 원하는 전체 경로를 입력하세요)${NC} " input
		if [ -n "$input" ] && [ "$input" = "g" ]; then
			brewPath="$HOME/goinfre"
		elif [ -n "$input" ] && [ "$input" = "h" ]; then
			brewPath="$HOME"
		elif [ -n "$input" ]; then
			brewPath="$input"
		else
			echo "⚠️  ${LRED}유효하지 않은 경로임으로 종료합니다 :(${NC} ⚠️ "
			if [ -n "$input_ohmyzsh" ] && ["$input_ohmyzsh" = "y"]; then
				zsh
			fi
			exit 1
		fi
		if [[ -x $brewPath/.brew ]]; then
			echo "# brew" >> $HOME/.zshrc
			echo "export brewPath=${brewPath}" >> $HOME/.zshrc && echo 'export PATH=$brewPath/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc 2>/dev/null && brew update
			echo "${LCYAN}brew는 이미${NC} ${W}$brewPath${NC}에 설치되어 있습니다."
		else
			echo "💾 ${LCYAN}brew 위치: ${NC} ${W}$brewPath${NC} 💾"
			echo "" >> $HOME/.zshrc
			echo "# brew" >> $HOME/.zshrc
			git clone --depth=1 https://github.com/Homebrew/brew $brewPath/.brew && echo "export brewPath=${brewPath}" >> $HOME/.zshrc && echo 'export PATH=$brewPath/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc 2>/dev/null && brew update
			brewPath="$(brew --prefix)"
			echo "${LGREEN}Done :D${NC}"
		fi
	else
	   	echo "${LRED}brew가 설치되지 않았습니다 :(${NC}"
	fi
fi

# install tree
if [[ -x "$(brew --prefix tree 2>/dev/null)" ]]; then
	echo "🥕 ${LCYAN}tree는 이미 설치되어 있습니다.${NC}"
elif [ -x $brewPath ]; then
	read -n1 -p "${YELLOW}tree를 설치할까요? (y/n)${NC} " input
	echo ""
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		brew install tree
		source $HOME/.zshrc 2>/dev/null
		echo "${LGREEN}Done :D${NC}"
	else
		echo "${LRED}tree가 설치되지 않았습니다 :(${NC}"
	fi
fi

# [set dock](https://gist.github.com/kamui545/c810eccf6281b33a53e094484247f5e8)
read -n1 -p "${YELLOW}Dock을 변경하고 싶습니까? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	echo "${W}Dock 변경중...${NC}"
	./utils/dock.sh
	echo "🏁 ${LGREEN}Dock 재시작${NC}"
	echo "🥳 ${LGREEN}Dock 변경 완료${NC} 🥳"
else
	echo "${LGREEN}OK :)${NC}"
fi

# brew 삭제
read -n1 -p "${YELLOW}brew를 지우시겠습니까? (y/n)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "y" ]; then
	rm -rf $brewPath/.brew
	source $HOME/.zshrc 2>/dev/null
	echo "${LGREEN}Done :D${NC}"
else
	echo "${LGREEN}OK :D${NC}"
fi

if ! grep -q "42_reset()" "$HOME/.zshrc"; then
	echo "alias 42_reset='bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/veggie-garden/42_reset_sh/main/42_reset.sh)\"'" >> $HOME/.zshrc
fi
source $HOME/.zshrc 2>/dev/null
echo ""
echo "                                          ██████                              "
echo "                                        ██▒▒▒▒████                            "
echo "                                  ████  ██▒▒██▒▒██                            "
echo "                                ██░░░░██▒▒██▒▒▒▒██                            "
echo "                              ██░░██░░░░██▒▒████                              "
echo "                            ██░░░░░░██░░░░██                                  "
echo "                          ██░░░░░░░░░░░░░░░░██                                "
echo "                        ██░░░░░░░░░░░░░░░░░░██                                "
echo "                        ██░░░░██░░░░░░░░░░██                                  "
echo "                      ██░░░░░░░░██░░░░░░██                                    "
echo "                      ██░░░░██░░░░██░░██                                      "
echo "                    ██░░░░░░░░██░░████                                        "
echo "                    ██░░░░░░░░████                                            "
echo "                      ████████                                                "
echo "                                                                              "
echo " ██   ██ ██████          ██████  ███████ ███████ ███████ ████████ "
echo " ██   ██      ██         ██   ██ ██      ██      ██         ██    "
echo " ███████  █████          ██████  █████   ███████ █████      ██    "
echo "      ██ ██              ██   ██ ██           ██ ██         ██    "
echo "      ██ ███████ ███████ ██   ██ ███████ ███████ ███████    ██    "
echo ""
echo "🎉 ${LCYAN}설정 완료 ${NC}🎉"
echo "${W}설정을 변경하고 싶다면 \`${LCYAN}42_reset${W}\` 명령어를 터미널에 입력하세요${NC}"
echo ""
echo "${W}* GitHub: https://github.com/veggie-garden/42_reset_sh${NC}"
zsh
