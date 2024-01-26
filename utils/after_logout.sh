#!/usr/bin/env zsh

pkill -u "${USER}" -f "^/System/Applications/System Preferences.app/Contents/MacOS/System Preferences$" 2>/dev/null

# Keyboard/Delay Until Repeat (Long: 120 <---> Short: 15)
defaults -currentHost write ~/Library/Preferences/ByHost/.GlobalPreferences.plist InitialKeyRepeat -int 15
defaults write ~/Library/Preferences/.GlobalPreferences.plist InitialKeyRepeat -int 15

# Keyboard/Key Repeat (Slow: 120 <---> Fast: 2)
defaults -currentHost write ~/Library/Preferences/ByHost/.GlobalPreferences.plist KeyRepeat -int 2
defaults write ~/Library/Preferences/.GlobalPreferences.plist KeyRepeat -int 2

# Mouse/Tracking speed (Slow: 0 <---> Fast: 3)
defaults -currentHost write ~/Library/Preferences/ByHost/.GlobalPreferences.plist com.apple.mouse.scaling -int 2
defaults write ~/Library/Preferences/.GlobalPreferences.plist com.apple.mouse.scaling -int 2

cp utils/LoginScripts.plist ~/Library/LaunchAgents/LoginScripts.plist
launchctl load ~/Library/LaunchAgents/LoginScripts.plist
