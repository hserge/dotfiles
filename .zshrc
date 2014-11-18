export PATH=/usr/local/bin:/usr/local/sbin:vendor/bin:$PATH

# This setting is for the new UTF-8 terminal support
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Options
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt AUTO_CD
setopt NO_BEEP
setopt NO_BG_NICE

SAVEHIST=5000
HISTFILE=~/.zsh_history

export UNAME_S=$(uname -s 2>&1 || echo "Linux" )

# https://github.com/Ptico/dotfiles/tree/master/zsh
#source ~/.zsh/lscolors.zsh
#source ~/.zsh/functions.zsh
#source ~/.zsh/completion.zsh
source ~/.zsh/keybind.zsh
source ~/.zsh/aliases.zsh


# olivierverdier/zsh-git-prompt
export ZSH_THEME_GIT_PROMPT_NOCACHE="True"
source ~/.zsh/gitprompt.zsh
# an example prompt
PROMPT='%{$fg_bold[yellow]%}%n@%m%~%{$reset_color%} $(git_super_status) %# '

# brewed zsh-completions plugin
fpath=(/usr/local/share/zsh-completion:ws $fpath)

# brewed zsh-syntax-highlighting.zsh plugin
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# source fit-flow-avh compilations
#source /usr/local/share/zsh/site-functions/git-flow-completion.zsh%
