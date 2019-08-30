{ pkgs, ... }:
let
  inherit (pkgs) go neovim less fd;
  fd_cmd = "${fd}/bin/fd -t f -H";
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
  FZF_ALT_C_COMMAND =
    "while read line; do "
    + "line=\"'\${(Q)line}'\"; [[ -d \"'$line'\" ]] && echo \"'$line'\"; "
    + "done < $HOME/.cache/zsh-cdr/recent-dirs"
    ;
  FZF_DEFAULT_COMMAND = fd_cmd;
  FZF_CTRL_T_COMMAND = fd_cmd;
}
