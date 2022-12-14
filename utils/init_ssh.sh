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
	echo -e "${white}SSH key \`${cyan}~/.ssh/id_rsa${white}\` already exists, using it${reset}"
	key_already_exists=true
else
	echo -e "${white}Generating SSH key \`${cyan}~/.ssh/id_rsa${white}\`${reset}"
	ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -C "$USER"
fi

# Start and use SSH agent
echo -e "\n${white}Starting SSH agent and adding key${reset}"
eval "$(ssh-agent >/dev/null)"
ssh-add ~/.ssh/id_rsa

# Show the public key
echo -e "\n${white}Here is your public key:\n---------${reset}"
cat ~/.ssh/id_rsa.pub
echo -e "${white}---------${reset}"

# If possible, propose to copy the public key to the clipboard
if [ -x "$(command -v pbcopy)" ] || [ -x "$(command -v xclip)" ] || [ -x "$(command -v xsel)" ]; then
	read -n1 -p "${white}Do you want to copy it to your clipboard? [${cyan}Y${white}/n]${reset} " input
	echo -e "\n"
	if [ -n "$input" ] && [ "$input" = "y" ]; then
		[ -x "$(command -v pbcopy)" ] && pbcopy < ~/.ssh/id_rsa.pub
		[ -x "$(command -v xclip)" ] && xclip -selection clipboard < ~/.ssh/id_rsa.pub
		[ -x "$(command -v xsel)" ] && xsel --clipboard < ~/.ssh/id_rsa.pub
	fi
fi

# Show some help to add the key to intra.42.fr
echo -e "${white}Make sure that it's set in your intra settings (or github/gitlab/whatever): ${cyan}https://profile.intra.42.fr/gitlab_users\n${reset}"
if [ ! -z ${key_already_exists+x} ]; then
	fingerprint="$(ssh-keygen -E md5 -l -f ~/.ssh/id_rsa | cut -d: -f2- | cut -d' ' -f1)"
	echo -e "${white}To check if your key is already set, open the settings page and check if one of your keys has this fingerprint:\n${cyan}${fingerprint}\n${reset}"
fi

# If possible, open intra SSH settings page
[ -x "$(command -v open)" ] && open 'https://profile.intra.42.fr/gitlab_users' &>/dev/null ;:
[ -x "$(command -v xdg-open)" ] && xdg-open 'https://profile.intra.42.fr/gitlab_users' &>/dev/null ;:

# open github settings page
[ -x "$(command -v open)" ] && open 'https://github.com/settings/keys' &>/dev/null ;:
[ -x "$(command -v xdg-open)" ] && xdg-open 'https://github.com/settings/keys' &>/dev/null ;:
