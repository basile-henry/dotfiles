# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

source ~/.profile

# Path to your oh-my-zsh installation.
export ZSH=/home/basile/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="basile"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git cabal stack z vi-mode)

source $ZSH/oh-my-zsh.sh

###############################
# Editor
###############################

export EDITOR='nvim'
KEYTIMEOUT=1

###############################
# Aliases
###############################

alias zshconfig="$EDITOR ~/.zshrc"
alias sl=ls
alias vim="TERM=screen-256color $EDITOR"

# git
alias gw="git worktree list"
alias gwa="git worktree add"
alias gwp="git worktree prune"

function jet() {
  et jet -c "cd $1; zsh --login"
}

export PATH=$HOME/.local/bin:/opt/Xilinx/Vivado/2017.1/bin:/opt/intelFPGA_pro/18.1/quartus/bin:$PATH

###############################
# Nix
###############################

# Remove the completion for ns, we use that name as a function
compdef -d ns

ns(){
  nix-shell --command "IN_NIX_SHELL=1 exec zsh; return" "$@"
}

nb(){
  nix-build --no-out-link -j8 --cores 8 "$@"
}

# Change worktree but stay in the same relative directory.
# (only works if the destination directory exists obviously)
cw(){
  current_wt=$(git rev-parse --show-toplevel)
  cd $(dirname $current_wt)/"$1"/$(realpath --relative-to=$current_wt .)
}

ghd(){
  run="ghcid --command \"cabal new-repl $@\""
  nix-shell -j8 --cores 8 --run "$run"
}

###############################
# Fix binding issues in vi-mode
###############################

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey '^[[3~' delete-char

# Change audio sink bindings in i3/config
chsink() {
  sed -i.bak 's/\(pactl.* \)[0-9]\+/\1'$1'/' ~/.i3/config;
  i3-msg reload;
  i3-msg restart;
}

rg2vim() { vim -c "$(rg -n $1 | peco --select-1 | awk -F\: 'BEGIN {ORS="|"}; {print (NR==1 ? "e " : "tabe ") $1"|:"$2}')" }

# if [[ "${terminfo[kcul1]}" != "" ]]; then
#   zle -N backward-word
#   bindkey "^${terminfo[kcul1]}" backward-word
# fi
# if [[ "${terminfo[kcur1]}" != "" ]]; then
#   zle -N foreward-word
#   bindkey "^${terminfo[kcur1]}" foreward-word
# fi

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add
