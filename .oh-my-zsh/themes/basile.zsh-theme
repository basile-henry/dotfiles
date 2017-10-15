# Nix shell
__nix_status() {
  if [ -n "$IN_NIX_SHELL" ]; then
    echo -n "%{$fg_bold[green]%}[nix-shell]%{$reset_color%} "
  fi
}

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='
%{$fg_bold[blue]%}%M%{$reset_color%} $(__nix_status)%{$fg[cyan]%}%c $(git_prompt_info)
${ret_status}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

