eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"

plugins=(zsh-autosuggestions)

# macos only
#source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

alias python=/usr/bin/python3
alias ls="exa --no-user --icons --long --header --git"
alias ls-t="exa --icons --long --tree --level=2"
alias config='/usr/bin/git --git-dir=$HOME/Desktop/github/.dotfiles/ --work-tree=$HOME'

alias vim=nvim
