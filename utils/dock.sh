#!/usr/bin/env bash

# https://github.com/rpavlick/add_to_dock

# adds an application to macOS Dock
# usage: add_app_to_dock "Application Name"
# example add_app_to_dock "/System/Applications/Music.app"

function add_app_to_dock {
    app="${1}"

    if open -Ra "${app}"; then
        echo "$app added to the Dock."

        defaults write com.apple.Dock persistent-apps -array-add "<dict>
                <key>tile-data</key>
                <dict>
                    <key>file-data</key>
                    <dict>
                        <key>_CFURLString</key>
                        <string>${app}</string>
                        <key>_CFURLStringType</key>
                        <integer>0</integer>
                    </dict>
                </dict>
            </dict>"
    else
        echo "ERROR: Application $1 not found."
    fi
}

# adds a folder to macOS Dock
# usage: add_folder_to_dock "Folder Path" -a n -d n -v n
# example: add_folder_to_dock "~/Downloads" -a 2 -d 0 -v 1
# key:
# -a or --arrangement
#   1 -> Name
#   2 -> Date Added
#   3 -> Date Modified
#   4 -> Date Created
#   5 -> Kind
# -d or --displayAs
#   0 -> Stack
#   1 -> Folder
# -v or --showAs
#   0 -> Automatic
#   1 -> Fan
#   2 -> Grid
#   3 -> List
function add_folder_to_dock {
    folder="${1}"
    arrangement="1"
    displayAs="0"
    showAs="0"

    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -a|--arrangement)
                if [[ $2 =~ ^[1-5]$ ]]; then
                    arrangement="${2}"
                fi
                ;;
            -d|--displayAs)
                if [[ $2 =~ ^[0-1]$ ]]; then
                    displayAs="${2}"
                fi
                ;;
            -v|--showAs)
                if [[ $2 =~ ^[0-3]$ ]]; then
                    showAs="${2}"
                fi
                ;;
        esac
        shift
    done

    if [ -d "$folder" ]; then
        echo "$folder added to the Dock."

        defaults write com.apple.dock persistent-others -array-add "<dict>
                <key>tile-data</key>
                <dict>
                    <key>arrangement</key>
                    <integer>${arrangement}</integer>
                    <key>displayas</key>
                    <integer>${displayAs}</integer>
                    <key>file-data</key>
                    <dict>
                        <key>_CFURLString</key>
                        <string>file://${folder}</string>
                        <key>_CFURLStringType</key>
                        <integer>15</integer>
                    </dict>
                    <key>file-type</key>
                    <integer>2</integer>
                    <key>showas</key>
                    <integer>${showAs}</integer>
                </dict>
                <key>tile-type</key>
                <string>directory-tile</string>
            </dict>"
    else
        echo "ERROR: Folder $folder not found."
    fi
}

function add_spacer_to_dock {
    defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
}

function add_small_spacer_to_dock {
    defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'
}

function clear_apps_from_dock {
    defaults delete com.apple.dock persistent-apps
}

function clear_others_from_dock {
    defaults delete com.apple.dock persistent-others
}

function clear_dock {
    clear_apps_from_dock
    clear_others_from_dock
}

function disable_recent_apps_from_dock {
    defaults write com.apple.dock show-recents -bool false
}

function enable_recent_apps_from_dock {
    defaults write com.apple.dock show-recents -bool true
}

function reset_dock {
    defaults delete com.apple.dock
    killall Dock
}


#!/usr/bin/env bash

# Change the path if you want more/less applications to be in your dock
declare -a apps=(
    '/System/Applications/Launchpad.app'
    '/Applications/Google Chrome.app'
    '/Applications/Visual Studio Code.app'
    '/Applications/Slack.app'
    '/Applications/iTerm.app'
    '/System/Applications/Notes.app'
    '/System/Applications/System Preferences.app'
    '${HOME}/Downloads'
);

declare -a folders=(
    ~/Downloads
);

clear_dock

disable_recent_apps_from_dock

for app in '${apps[@]}'; do
    add_app_to_dock '$app'
done

for folder in '${folders[@]}'; do
    add_folder_to_dock $folder
done

killall Dock
