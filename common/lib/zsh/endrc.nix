{ pkgs, ... }:
let
  inherit (pkgs) gawk gnused lsd less man ripgrep;
  TMUX = "\${+TMUX}";
in
''
  # history substring search keybinds
  bindkey '^[OA' history-substring-search-up
  bindkey '^[OB' history-substring-search-down

  zle -N zle-line-init

  # if in tmux launch fzf in tmux pane
  [[ ${TMUX} == 1 ]] \
    && SKIM_TMUX=1

  #load compinit
  autoload -Uz compinit
  typeset -i updated_at=$(date +'%j' -r ~/.zcompdump ||
  stat -f '%Sm' -t '%j' ~/.zcompdump)
  if [ $(date +'%j') != $updated_at ]; then
  compinit
  else
  compinit -C
  fi

  # Case insens only when no case match; after all completions loaded
  zstyle ':completion:*' matcher-list \
  "" 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

  # Auto rehash for new binaries
  zstyle ':completion:*' rehash true

  # Key binds
  bindkey "jj" vi-cmd-mode
  bindkey -v '^?' backward-delete-char

  # keep shell state frozen
  ttyctl -f

  # colorful man pages
  man () {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    ${man}/bin/man "$@"
  }

  # so completion works
  nixos () { cd ~nixos }
  nixpkgs () { cd ~nixpkgs }

  # convenient less wrappers
  t () {
    ${lsd}/bin/lsd -l --tree --color always --icon always $@ | ${less}/bin/less
  }
  ta () {
    ${lsd}/bin/lsd -lA --tree --color always --icon always $@ | ${less}/bin/less
  }

  # pipe rg into less with colors
  rgl () {
    ${ripgrep}/bin/rg --color=always $@ | ${less}/bin/less
  }

  } > /dev/null

  # set colorscheme if it exists and was not set at the top
  type -w base16_snazzy &> /dev/null \
  && {
    [[ -f ~/.base16_theme ]] || base16_snazzy
  }
''
