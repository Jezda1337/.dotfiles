# ~/.bashrc # # starship nice shell
eval "$(starship init bash)"

set -o vi

# git tab completions
source "/usr/share/git/completion/git-completion.bash"

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(fzf --bash)"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

export PATH="$PATH:/home/radoje/pkgs/alacritty/target/release:/home/radoje/pkgs/grim/build:/home/radoje/pkgs/yazi/target/release:$HOME/.local/share/nvim/mason/bin:/home/radoje/go/bin:$HOME/pkgs/eww/target/release/:$HOME/.local/bin"
#export npm_config_prefix="$HOME/.local"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# aliases
alias ls="exa --no-user --icons --sort=ext --long --header --git"
alias ls-t="exa --icons --long --tree --level=2"
alias tx="tmux new -s $1"

# exports
export BROWSER="$(which firefox)"
export EDITOR="$(which nvim)"

function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

function gc() {
 output=$(ollama run llama3.2:latest "Suggest commit messages for this changes keep it short: $(git diff)")
 echo "$output"
 echo "$output" | wl-copy
}

# pnpm
export PNPM_HOME="/home/radoje/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# Load Angular CLI autocompletion.
source <(ng completion script)
