# workstation-ansible
### Dotfile (Sort of)

This repo was an ansible playbook at one point, but the cost of maintaining that didn't make sense for how
often I needed to configure a new machine (and tooling like IDE's have added things like setting sync).

It's now more of a rough set of notes, though it still includes some dotfiles (without the scripting to put them in place)

### Setup
1. Chrome: login & sync settings (customize to exclude Open Tabs, Passwords, and Payment Methods)
1. GoLand, PyCharm, Rubymine, Datagrip - configure settings sync. Settings that don't sync:
   * Advanced Settings -> Markdown -> Toggle "Hide floating toolbar"
1. Zoom: disable most hotkeys, make hotkeys global
1. Provision GitHub Personal Access Token: https://github.com/settings/tokens

### macOS Config

1. Terminal
   * Font: 14pt Menlo
   * Keyboard -> Check "Use Option as Meta key"
   * Advanced -> Disable "Allow VT100 application keypad mode" (so [numpad "enter" works in terminal](https://vi.stackexchange.com/questions/11581/why-doesnt-my-numpad-work-right-in-my-terminal))
1. Finder
   * Preferences -> Sidebar -> Show Hard disks, Hide air drop

System:
1. Keyboard -> Shortcuts
   1. Remove conflicting OS shortcuts: Keyboard -> Shortcuts
      * Services -> Text -> Search man Page Index... (It's set to ⇧⌘A, which conflicts with JetBrains tooling's "Find Action")
      * App Shortcuts -> Show Help menu
      * Display -> Disable both (these mess with kvm switch hotkey)
   1. Hotkeys
      * Mission Control: F8
      * Mission Control
         * Move left a space: ⌃⌘←
         * Move right a space: ⌃⌘→
1. Private & Security -> Full Disk Access -> `sshd-keygen-wrapper` (needed for the `rsync`s transferring data across machines)
1. Notifications -> Allow when mirror/sharing
1. Menu Bar -> Show Menu Bar Background

Scriptable settings:

```shell
# Faster key repeat
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 25

# General
defaults write -g AppleMenuBarFontSize -string "large"

# Finder
## New window -> Desktop
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder ShowPathbar -bool true
## View options
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowTabBar -bool true
# Default to list view in finder windows
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv

# Click wallpaper to reveal desktop -> Only in Stage Manager
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# Disable window tiling
defaults write com.apple.WindowManager EnableTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTopTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTilingOptionAccelerator -bool false
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false

# Hot corners (values: 0=none, 2=mission control, 4=desktop, 5=screensaver start, 6=disable screensaver, 10=display sleep)
defaults write com.apple.dock wvous-tl-corner -int 6   # upper-left: disable screensaver
defaults write com.apple.dock wvous-bl-corner -int 10  # lower-left: display sleep
defaults write com.apple.dock wvous-br-corner -int 4   # lower-right: desktop

# Fix up scrolling
defaults write -g AppleShowScrollBars -string "Always"
defaults write -g com.apple.swipescrolldirection -bool false
defaults write -g NSScrollAnimationEnabled -bool false

# Disable shake to locate pointer
defaults write ~/Library/Preferences/.GlobalPreferences CGDisableCursorLocationMagnification -bool true

# Trackpad
## Secondary click bottom-right
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
## Tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
## Three-finger swipe between pages
# defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 1

# Universal Control: Disable "Push through edge" and "Automatically reconnect"
defaults write com.apple.universalcontrol DisableMagicEdges -bool true
defaults write com.apple.universalcontrol SuspendPairing -bool true

# Disable Spotlight shortcut (replaced by Alfred)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '<dict><key>enabled</key><false/></dict>'
# Use F-keys as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# Terminal: Set Homebrew as default profile
defaults write com.apple.Terminal "Default Window Settings" -string "Homebrew"
defaults write com.apple.Terminal "Startup Window Settings" -string "Homebrew"

# Remove all the junk Apple pins to the dock on a new Mac
defaults write com.apple.dock persistent-apps -array

# Show battery percentage
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true

# Minimize windows using Scale Effect
defaults write com.apple.dock mineffect -string "scale"

# Don't close windows when quitting
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool true

# Hating em dashes before it was cool
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false

# Tahoe has a really annoying pop-in animation, this turns that off (new to Tahoe, setting not in Sequoia)
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Always show sound option in menu bar
defaults -currentHost write com.apple.controlcenter Sound -int 18

# Don't re-arrange spaces based on LRU
defaults write com.apple.dock mru-spaces -bool false

# sudo
## Show window title icons
sudo defaults write com.apple.universalaccess showWindowTitlebarIcons -bool true
```

Logout and login after writing defaults.

### Additional scripting

```shell
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true
git config --global core.excludesfile ~/.gitignore_global

# known_hosts predates servers being ephemeral & makes no sense now
cat << EOF >  ~/.ssh/config
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
EOF
```

### Sublime
* For color customization, show current scope with: ⌥ + ⌘ + P
* `Breakers.default.sublime-color-scheme` shouldn't be needed; it's included just in case Sublime removes it

### VSCode
In theory, settings sync deals with all this. To export settings: `~/Library/Application\ Support/Code/User/settings.json` 

### Alfred
Install [Alfred Workflows](https://github.com/cholick?tab=repositories&q=alfred)

### References

* https://whiskykilo.com/mac-tweaks/
* https://github.com/hjuutilainen/dotfiles/blob/master/bin/osx-user-defaults.sh
* https://github.com/josh-/dotfiles/blob/master/osx
* https://github.com/mathiasbynens/dotfiles/blob/master/.osx
* https://gist.github.com/zenorocha/7159780
* https://github.com/seattle-beach/alfalfa
* https://github.com/kejadlen/dotfiles
