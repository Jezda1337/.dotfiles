#
# ~/.bashrc
#

# starship nice shell
eval "$(starship init bash)"

# git tab completions
source "/usr/share/git/completion/git-completion.bash"

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

export PATH="$PATH:/home/radoje/pkgs/alacritty/target/release:/home/radoje/pkgs/grim/build:/home/radoje/pkgs/yazi/target/release:$HOME/.local/share/nvim/mason/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# aliases
alias ls="exa --no-user --icons --sort=ext --long --header --git"
alias ls-t="exa --icons --long --tree --level=2"
alias tx="tmux"

# exports
export EDITOR="nvim"

source /home/radoje/.config/broot/launcher/bash/br
