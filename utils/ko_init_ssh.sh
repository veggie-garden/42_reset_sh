#!/usr/bin/env bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    init_ssh.sh                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aguiot-- <aguiot--@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/11/06 18:07:12 by aguiot--          #+#    #+#              #
#    Updated: 2021/11/06 18:21:44 by aguiot--         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Colors
white=$'\033[1;37m'
cyan=$'\033[1;96m'
reset=$'\033[0;39m'

# Generate SSH key pair if needed
if [ -f ~/.ssh/id_rsa ]; then
	echo -e "${white}SSH key \`${cyan}~/.ssh/id_rsa${white}\`가 이미 존재합니다.${reset}"
	key_already_exists=true
else
	echo -e "${white}SSH key 생성\`${cyan}~/.ssh/id_rsa${white}\`${reset}"
	ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -C "$USER"
fi

# Start and use SSH agent
echo -e "\n${white}SSH agent 실행 및 key 추가${reset}"
eval "$(ssh-agent >/dev/null)"
ssh-add ~/.ssh/id_rsa

# Show the public key
echo -e "\n${white}public key:\n---------${reset}"
cat ~/.ssh/id_rsa.pub
echo -e "${white}---------${reset}"

# If possible, propose to copy the public key to the clipboard
if [ -x "$(command -v pbcopy)" ] || [ -x "$(command -v xclip)" ] || [ -x "$(command -v xsel)" ]; then
	read -n1 -p "${white}SSH 키를 클립보드에 복사할까요? [${cyan}Y${white}/n]${reset} " input
	echo -e "\n"
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		[ -x "$(command -v pbcopy)" ] && pbcopy < ~/.ssh/id_rsa.pub
		[ -x "$(command -v xclip)" ] && xclip -selection clipboard < ~/.ssh/id_rsa.pub
		[ -x "$(command -v xsel)" ] && xsel --clipboard < ~/.ssh/id_rsa.pub
	fi
fi

# Show some help to add the key to intra.42.fr
echo -e "${white}인트라(또는 github/gitlab 등)에서 SSH key를 설정했는지 확인하세요: ${cyan}https://profile.intra.42.fr/gitlab_users\n${reset}"
if [ ! -z ${key_already_exists+x} ]; then
	fingerprint="$(ssh-keygen -E md5 -l -f ~/.ssh/id_rsa | cut -d: -f2- | cut -d' ' -f1)"
	echo -e "${white}key가 제대로 설정되었는지 확인하려면 fingerprint를 확인하세요. 이 key의 fingerprint:\n${cyan}${fingerprint}\n${reset}"
fi

# If possible, open intra SSH settings page
[ -x "$(command -v open)" ] && open 'https://profile.intra.42.fr/gitlab_users' &>/dev/null ;:
[ -x "$(command -v xdg-open)" ] && xdg-open 'https://profile.intra.42.fr/gitlab_users' &>/dev/null ;:

# open github settings page
[ -x "$(command -v open)" ] && open 'https://github.com/settings/keys' &>/dev/null ;:
[ -x "$(command -v xdg-open)" ] && xdg-open 'https://github.com/settings/keys' &>/dev/null ;:
