# ==============
# oh-my-zsh
# ==============
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="yanis"
plugins=(git)
source $ZSH/oh-my-zsh.sh

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
source /Users/yanis/z/z.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
