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
   * Set Homebrew as default profile
   * Font: 14pt Menlo
   * Keyboard -> Check "Use Option as Meta key"
   * Advanced -> Disable "Allow VT100 application keypad mode" (so [numpad "enter" works in terminal](https://vi.stackexchange.com/questions/11581/why-doesnt-my-numpad-work-right-in-my-terminal))
1. Finder
   * General -> New Finder window -> Desktop
   * View -> Show Path Bar
   * Preferences -> Advanced -> Keep folders on top (both options)
   * Preferences -> Sidebar -> Show Hard disks, Hide air drop

System:
1. Accessibility
   * Display -> Menu bar size: Large
   * Display -> Show window title icons
   * Pointer -> Disable shake
1. Control Center
   * Modules -> Sound -> Always show
   * Battery -> Show Percentage
1. Desktop & Dock -> Desktop & Stage Manager -> Click wallpaper to reveal desktop -> Only in Stage manager
1. Desktop & Dock -> Minimize windows using -> Scale Effect
1. Desktop & Dock -> Uncheck "Close windows when quitting an application"
1. Desktop & Dock -> Hotcorners
   * Upper left -> Disable screensaver
   * Lower Left -> Display to sleep
   * Lower right -> Desktop
1. Desktop & Dock -> Diable all four tiling options (drag windows to edges to tile, etc)
1. Displays -> Universal Control -> Disable "Push throw edge" and "Automatically reconnect"
1. Keyboard -> Shortcuts
   1. Toggle on Function keys
   1. Remove conflicting OS shortcuts: Keyboard -> Shortcuts
      * Services -> Text -> Search man Page Index... (It's set to ⇧⌘A, which conflicts with JetBrains tooling's "Find Action")
      * App Shortcuts -> Show Help menu
      * Spotlight -> Search (replaced by Alfred)
      * Display -> Disable both (these mess with kvm switch hotkey)
   1. Hotkeys
      * Mission Control: F8
      * Mission Control
         * Move left a space: ⌃⌘←
         * Move right a space: ⌃⌘→
1. Private & Security -> Full Disk Access -> `sshd-keygen-wrapper` (needed for the `rsync`s transferring data across machines)
1. Notifications -> Allow when mirror/sharing
1. Trackpad
   * Point and Click -> Secondary Click -> Bottom Right
   * Point and Click -> Enable tap to click
   * Swipe between pages -> Swith with Three Fingers
1. Menu Bar -> Show Menu Bar Background

Replacement scirpt for the OSX role


```shell
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 25
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false

defaults write -g AppleShowScrollBars -string "Always"

defaults write -g com.apple.swipescrolldirection -bool false
defaults write -g NSScrollAnimationEnabled -bool false

# Tahoe has a really annoying pop-in animation, this turns that off
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

defaults write -g AppleShowAllExtensions -bool true
# Default to list view in finder windows
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv

# Don't re-arrange spaces based on LRU
defaults write com.apple.dock mru-spaces -bool false
```

### Additional scripting

```
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

### Alred
Install [Alfred Workflows](https://github.com/cholick?tab=repositories&q=alfred)

### References

* https://whiskykilo.com/mac-tweaks/
* https://github.com/hjuutilainen/dotfiles/blob/master/bin/osx-user-defaults.sh
* https://github.com/josh-/dotfiles/blob/master/osx
* https://github.com/mathiasbynens/dotfiles/blob/master/.osx
* https://gist.github.com/zenorocha/7159780
* https://github.com/seattle-beach/alfalfa
* https://github.com/kejadlen/dotfiles
