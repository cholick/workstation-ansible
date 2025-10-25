# Source Prezto.
if [[ -s ~/.zprezto/init.zsh ]]; then
  	source ~/.zprezto/init.zsh
fi

# Aliases

alias history="fc -l 1"

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias rm='nocorrect rm'
alias 🐱='cat'
alias dnsmasq-restart="sudo launchctl stop homebrew.mxcl.dnsmasq && sudo launchctl start homebrew.mxcl.dnsmasq"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias jetbrains="/Applications/GoLand.app/Contents/MacOS/goland -e"
alias fix-download="sudo xattr -r -d com.apple.quarantine"
alias clear-pat="git config --local credential.helper ''"
alias codespace-cleanup="gh codespace list --json name,lastUsedAt | jq -r 'sort_by(.lastUsedAt)[:5][] | .name' | xargs -n1 -I{} gh codespace delete -c {} --force"
alias slack-hdr-fix="killall Slack ; open /Applications/Slack.app/ --args --force-color-profile=srgb"
alias clear-pat="git credential-osxkeychain erase <<< $'protocol=https\nhost=github.com'"
# Revisit photo-clean on new phone - other potential tags Pixel not currently using
alias photo-clean='exiftool -gps:all= -overwrite_original'

# Configure zsh plugins

export HISTFILE=~/.zsh_history
export HISTSIZE=40000
export SAVEHIST=40000

setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
unsetopt SHARE_HISTORY

setopt HIST_VERIFY

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST

# Care more about curl with query params than globbing files matches
setopt NO_NOMATCH
unsetopt correct
setopt clobber

# kubectl.docker messes up my "kub↹" completion 
zstyle ':completion:*' ignored-patterns 'kubectl.docker|kinit|kubelogin|kustomize*'

# https://serverfault.com/questions/353270/excluding-environment-variables-from-zsh-autocomplete
function _parameters() {}

# Functions
alias serve_dir='python3 -m http.server'

killport() {
	if [ -z $1 ]; then
		echo 'Port is required. Usage: "killport 8000"';
		return
	fi
	local pid=`lsof  -i :$1 | grep LISTEN | awk '{print $2}'`
	if [ -z $pid ]; then
		echo "No process running on $1"
	else
		echo "Killing process [$pid]"
		kill $pid
	fi
}

fix-terminal-header() {
	printf '\e]0;\a'
}

# https://forums.macrumors.com/threads/time-synchronization-command-line-in-macos-big-sur.2279396/page-2
fix-time() {
	sudo pkill timed
}


# Configurations
export DOCKER_CLI_HINTS=false
export DOCKER_SCAN_SUGGEST=false
export EDITOR=vim

export PATH=/usr/local/bin:$HOME/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=$HOME/Applications/brew/bin:$PATH
export PATH=$HOME/Applications/brew/sbin:$PATH
export PATH=$PATH:$HOME/Applications

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# *vm
export NVM_DIR="$HOME/.nvm"
function nvm {
    unset -f nvm
	echo "Loading nvm"
	. "/Users/$HOME/Applications/brew/opt/nvm/nvm.sh"
	nvm $@
}

function pyenv {
	unset -f pyenv
	echo "Loading pyenv"
	if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
	pyenv $@
}

function rvm {
	unset -f rvm
	echo "Loading rvm"
	export PATH="$PATH:$HOME/.rvm/bin"
	[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
	rvm $@
}
