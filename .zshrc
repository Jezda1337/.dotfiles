eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

plugins=(zsh-autosuggestions vi-mode fzf)

# macos only
#source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf
source <(fzf --zsh)


# If not running interactively, don't do anything
[[ $- != *i* ]] && return


alias tx=tmux

# aliases
alias ls="eza --no-user --icons --sort=ext --long --header --git"
alias ls-t="eza --icons --long --tree --level=2"

# exports
export BROWSER="$(which firefox)"
export EDITOR="$(which nvim)"
export PATH=$PATH:/Users/radojejezdic/go/bin

function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep extendedglob notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/radoje/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export ZVM_INIT_MODE=sourcing

# bun completions
[ -s "/Users/radojejezdic/.bun/_bun" ] && source "/Users/radojejezdic/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
