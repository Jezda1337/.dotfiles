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
alias github="cd ~/Desktop/github/"
alias sylva="cd ~/Desktop/github/sylva-enterprise/"
alias tx=tmux

# bun completions
[ -s "/home/radoje/.bun/_bun" ] && source "/home/radoje/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH:$HOME/go/bin:$HOME/pkg/tmux:$HOME/.local/share/nvim/mason/bin"
