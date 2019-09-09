{ pkgs, ... }:
let
  inherit (pkgs) go neovim less fd;
  fd_cmd = "${fd}/bin/fd -t f";
  editor = "${neovim}/bin/nvim";
in
{
  # default editor
  EDITOR = "${editor}";
  VISUAL = "${editor}";
  # bat paging only works by setting this manually for some reason
  BAT_PAGER = "${less}/bin/less";
  # set goroot
  GOROOT = [ "${go}/share/go" ];
  # custome fzf commands
  SKIM_ALT_C_COMMAND =
    "while read line; do "
    + "line=\"'\${(Q)line}'\"; [[ -d \"'$line'\" ]] && echo \"'$line'\"; "
    + "done < $HOME/.cache/zsh-cdr/recent-dirs"
    ;
  SKIM_DEFAULT_COMMAND = fd_cmd;
  SKIM_CTRL_T_COMMAND = fd_cmd;
}
