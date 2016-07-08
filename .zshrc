# Path to your oh-my-zsh installation.
export ZSH=/Users/yanis/.oh-my-zsh
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
ZSH_THEME="yanis" # or 'random'
plugins=(git rbenv colored-man-pages zsh-completions)
# ENABLE_CORRECTION="true"
source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

# Rbenv setup
eval "$(rbenv init -)"

# Required by zsh-completions
autoload -U compinit && compinit

source_if_exists() {
  [ -f $1 ] && source $1
}

# rupa/z
source_if_exists ~/z/z.sh

# Fuzzy Finder
source_if_exists ~/.fzf.zsh

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore node_modules --ignore app/assets/fonts --ignore app/assets/images --ignore webpack.bundle.js -g ""'

export ANDROID_HOME=/Users/yanis/Library/Android/sdk

export TERM="xterm-256color"

source_if_exists ~/.unsafe.env

# Read aliases
source_if_exists ~/.aliases
source_if_exists ~/.aliases_dev # mostly for developer's machine only
source_if_exists ~/.aliases_unsafe