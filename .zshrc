export ZSH=/Users/yanis/.oh-my-zsh
ZSH_THEME="yanis" # or 'random'
plugins=(rbenv)
source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

# Rbenv setup
eval "$(rbenv init -)"

# Required by zsh-completions
autoload -U compinit && compinit

source_if_exists() {
  [ -f $1 ] && source $1
}

source_if_exists ~/z/z.sh # rupa/z
source_if_exists ~/.fzf.zsh # Fuzzy Finder

# Setting ag as the default source for fzf
# By default, ag will ignore files whose names match patterns in .gitignore, .hgignore, or .ignore
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore app/assets/fonts --ignore app/assets/images --ignore "*webpack.bundle.js" -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export ANDROID_HOME=/Users/yanis/Library/Android/sdk

export TERM="xterm-256color"

source_if_exists ~/.unsafe.env

# Read aliases
source_if_exists ~/.aliases
source_if_exists ~/.aliases_unsafe

export PATH="$PATH:/Users/yanis/bin"
