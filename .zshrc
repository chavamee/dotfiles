source ~/.zshenv

#Enable colors
autoload -U colors && colors

#Bind ncmpcpp to Alt-\
ncmpcppShow() { BUFFER="ncmpcpp"; zle accept-line;  }
zle -N ncmpcppShow
bindkey '^[\' ncmpcppShow

#Enable history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "${key[PageUp]}"    ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}"  ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

eval `dircolors -b`

#Autocompletion with Arrow-key driven interface
zstyle ':completion:*' menu select
#Color files in autocomplete as ls does
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#Reload autocomplete to find newly added binaries
zstyle ':completion:*' rehash true
#Enable cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
#Ignore CVS files
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'
#Fuzzy autocompletion
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' \
        max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
#Ignore unknown functions
zstyle ':completion:*:functions' ignored-patterns '_*'
#Remove trailing forward slash
zstyle ':completion:*' squeeze-slashes true

#Enable autocompletion
autoload -U compinit
compinit
setopt completealiases

#Enable completion on powerpill
compdef _pacman powerpill=pacman

#Command not found hook -  pkgfile
source /usr/share/doc/pkgfile/command-not-found.zsh

#Enable zsh syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#Enable prompts
autoload -U promptinit
promptinit

PROMPT=" %{$fg_bold[white]%}%2~%{$reset_color%} %{$fg[yellow]%}]%{$reset_color%} "

#Set history settings
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

bindkey '^R' history-incremental-search-backward

# turn on spelling correction
setopt correct
# don't save duplicates in command history
setopt histignoredups
# don't allow accidental file over-writes
setopt noclobber
#don't store commands prefixed with a space
setopt histignorespace

# Program aliases
alias chronyc="sudo chronyc -a"
alias gdb='gdb -q'

# File manipulation and search
alias rm=' timeout 3 rm -Iv --one-file-system'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias mv=' timeout 8 mv -iv'
alias cp=' timeout 8 cp -iv'
alias mkdir='mkdir -p -v'

# Bluetooth (un)lock
alias unblockblue='sudo rfkill unblock bluetooth && sudo systemctl start bluetooth'
alias blockblue='sudo systemctl stop bluetooth && sudo rfkill block bluetooth'

#Enable help
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-svn
autoload -Uz run-help-svk
unalias run-help
alias help=run-help

#Exports
export EDITOR=/usr/bin/nvim
export XDG_CONFIG_HOME=$HOME/.config
export GOBIN=$HOME/.bin

#Enable fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
#Enable keycahin
eval $(keychain --eval --quiet id_rsa)
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
