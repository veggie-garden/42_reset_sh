#!/usr/bin/env bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    42_reset.sh                                        :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cheseo <cheseo@student.42seoul.kr>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/08 19:46:50 by cheseo            #+#    #+#              #
#    Updated: 2024/02/08 19:46:50 by cheseo           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

LRED=$'\033[1;31m'
LCYAN=$'\033[1;36m'
LGREEN=$'\033[1;32m'
YELLOW=$'\033[1;33m'
W=$'\033[1;37m'
NC=$'\033[0m'

echo "${W}Welcome to 42_reset_sh${NC}🥕"

# choose language
read -n1 -p "${YELLOW}Which language do you want? (e for English / k for Korean) (e/k)${NC} " input
echo ""
if [ -n "$input" ] && [ "$input" = "e" ]; then
	./after_reset.sh
elif [ -n "$input" ] && [ "$input" = "k" ]; then
	./ko_after_reset.sh
else
	echo "${LGREEN}Wrong input, automatically set to English${NC}"
	./after_reset.sh
fi
