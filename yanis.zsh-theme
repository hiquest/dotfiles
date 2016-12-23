ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}" # "%{$reset_color%}%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#
# Custom helpers.
#
git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo "$(parse_git_dirty)%{$fg_bold[yellow]%}$(work_in_progress)%{$reset_color%}$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

rbenv_version() {
  echo "%{$fg[red]%}[$(rbenv version | sed -e 's/ (set.*$//')]%{$reset_color%}"
}

time_in_clt() {
  echo "%{$fg[yellow]%}c$(TZ=US/Eastern date +"%H:%M")%{$reset_color%}"
}

# time_in_smr() {
#   echo "%{$fg[yellow]%}s$(TZ=Europe/Samara date +"%H:%M")%{$reset_color%}"
# }

itunes_playing() {
  artist=`osascript -e '
  tell application "iTunes"
    try
      if it is running then
        artist of current track as string
      end if
    end try
  end tell'`
  name=`osascript -e '
  tell application "iTunes"
    try
      if it is running then
        name of current track as string
      end if
    end try
  end tell'`

  test -z $artist \
    && echo "" \
    || echo "%{$fg[green]%}♫$artist - $name♫%{$reset_color%}"
}

curr_usd() {
  val=`cat /Users/yanis/.track/usd`
  echo "%{$fg[red]%}\$$val%{$reset_color%}"
}

#
# Formatting
#

# RVM component of prompt
ZSH_THEME_RVM_PROMPT_PREFIX="%{$fg[red]%}["
ZSH_THEME_RVM_PROMPT_SUFFIX="]%{$reset_color%}"

# Combine it all into a final right-side prompt
RPS1='$(git_custom_status) $(rbenv_version) $(time_in_clt) $(itunes_playing)$EPS1'

PROMPT="%{$fg[cyan]%}[%~% ]%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b "
