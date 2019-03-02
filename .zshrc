####################
# ZSH/Terminal Setup
####################
export ZSH=~/.oh-my-zsh
ZSH_THEME="yanis" # or 'random'
plugins=()
source $ZSH/oh-my-zsh.sh
autoload -U compinit && compinit # Required by zsh-completions
export TERM="xterm-256color"
export EDITOR='nvim'
export LANG="en_US.UTF-8"

#######################
## Helpers
#######################
source_if_exists() {
  [ -f $1 ] && source $1
}

#######################
## Utils
#######################
source_if_exists ~/z/z.sh # rupa/z

###############
## Fuzzy Finder
###############
source_if_exists ~/.fzf.zsh # Fuzzy Finder
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore app/assets/fonts --ignore node_modules --ignore app/assets/images --ignore "*webpack.bundle.js" -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

######################
## ENV vars and aliases
######################
source_if_exists ~/.unsafe.env # private env vars
source_if_exists ~/.aliases

######################
## Custom BIN
######################
export PATH="$PATH:/Users/yanis/bin"

######################
## Ruby setup
######################
eval "$(rbenv init -)"

######################
## Android setup
######################
export ANDROID_HOME=/Users/yanis/Library/Android/sdk

######################
## Google SDK
######################
GSDK_HOME='/Users/yanis/bin/google-cloud-sdk'
source_if_exists "$GSDK_HOME/path.zsh.inc"
source_if_exists "$GSDK_HOME/completion.zsh.inc"
export PYTHONPATH="$PYTHONPATH:$GSDK_HOME/platform/google_appengine/"

######################
## NVM - NODE MANAGER
######################
nvmi() {
  # this is too slow to run on startup
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm use v8.9.4  # need this for legacy project
}
