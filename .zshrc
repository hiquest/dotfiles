# current path (yellow), $ (green)
PROMPT='%F{cyan}%~%f%F{yellow}$%f '

# autocomplete for ssh and other sruff
autoload -U compinit
compinit

# ====================
# history
# ====================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000 # How many commands to keep in memory
SAVEHIST=50000 # How many commands to keep on disk
setopt APPEND_HISTORY # Append to history file instead of overwriting it
setopt SHARE_HISTORY # Share history between all open terminal sessions
setopt INC_APPEND_HISTORY # Write commands to history immediately, not only when shell exits
setopt HIST_IGNORE_DUPS # Avoid saving duplicate commands next to each other
setopt HIST_IGNORE_ALL_DUPS # Remove older duplicate entries when a new duplicate is added
setopt HIST_FIND_NO_DUPS # Do not show duplicate commands when searching history
setopt HIST_REDUCE_BLANKS # Remove extra blanks before saving
setopt HIST_IGNORE_SPACE # Do not save commands starting with a space
setopt HIST_NO_STORE # Do not save the history command itself
setopt EXTENDED_HISTORY # Save timestamp and duration for each command


# =====================
# set the title the current dir
# =====================
# Set iTerm2 / terminal tab title to current directory
function set_tab_title_to_cwd() {
  local title="${PWD/#$HOME/~}"
  print -Pn "\e]0;${title}\a"
}

# Run once when shell starts
set_tab_title_to_cwd

# Run after every directory change
autoload -Uz add-zsh-hook
add-zsh-hook chpwd set_tab_title_to_cwd

# ==============
# imports
# ==============
source $HOME/.aliases
source $HOME/.secrets

export EDITOR='nvim'

# ==============
# FZF
# ==============
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git/*'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ==============
# rbenv
# ==============
eval "$(rbenv init - zsh)"

# ==============
# rupa/z
# ==============
source ~/z/z.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="$HOME/.local/bin:$PATH"
