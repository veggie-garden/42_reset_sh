#!/usr/bin/env bash

source /dev/stdin <<< "$(curl -s https://raw.githubusercontent.com/veggie-garden/42_reset_sh/main/utils/dock_functions.sh)"

# Change the path if you want more/less applications to be in your dock
declare -a apps=(
	"/System/Applications/Launchpad.app"
	"/Applications/Google Chrome.app"
	"/Applications/Visual Studio Code.app"
	"/Applications/Slack.app"
	"/Applications/iTerm.app"
	"/System/Applications/Notes.app"
	"/System/Applications/System Preferences.app"
	"${HOME}/Downloads"
);

declare -a folders=(
    ~/Downloads
);

clear_dock
disable_recent_apps_from_dock

for app in "${apps[@]}"; do
    add_app_to_dock "$app"
done

for folder in "${folders[@]}"; do
    add_folder_to_dock $folder
done

killall Dock
