#!/usr/bin/env zsh

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setting_zsh.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cheseo <cheseo@student.42seoul.kr>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/27 21:29:17 by cheseo            #+#    #+#              #
#    Updated: 2023/01/27 21:29:17 by cheseo           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

LRED=$'\033[1;31m'
LCYAN=$'\033[1;36m'
LGREEN=$'\033[1;32m'
YELLOW=$'\033[1;33m'
W=$'\033[1;37m'
NC=$'\033[0m'

echo "${W}Changing oh_my_zsh setting${NC}🥕"

text="if [[ -z \$ZSH_THEME_CLOUD_PREFIX ]]; then\n\tZSH_THEME_CLOUD_PREFIX='☁️ '\nfi\n\nPROMPT='%{\$fg_bold[cyan]%}\$ZSH_THEME_CLOUD_PREFIX %{\$fg_bold[green]%} %{\$fg[green]%}%c %{\$fg_bold[cyan]%}\$(git_prompt_info)%{\$fg_bold[blue]%} % %{\$reset_color%}'\n\nZSH_THEME_GIT_PROMPT_PREFIX=\"%{\$fg[green]%}[%{\$fg[cyan]%}\"\nZSH_THEME_GIT_PROMPT_SUFFIX=\"%{\$reset_color%}\"\nZSH_THEME_GIT_PROMPT_DIRTY=\"%{\$fg[green]%}] %{\$fg[yellow]%}✨ %{\$reset_color%}\"\nZSH_THEME_GIT_PROMPT_CLEAN=\"%{\$fg[green]%}]\""

echo $text > $HOME/.oh-my-zsh/themes/cloud.zsh-theme
sed -i -e 's/robbyrussell/cloud/g' $HOME/.zshrc
source $HOME/.zshrc 2>/dev/null
exec zsh -l

# bash -c "$(curl -fsSL https://raw.githubusercontent.com/veggie-garden/42_reset_sh/main/setting_zsh.sh)"
