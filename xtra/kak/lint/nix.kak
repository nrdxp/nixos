hook -group lint global WinSetOption filetype=nix %{
  set buffer lintcmd '
    run () {
      nix-instantiate --parse $1 2>&1 >&- > /dev/null |
      awk ''
        {printf $NF ":" " "}
        !($NF="") !($(NF-1)="") {sub(/,  $/, "")}1
      ''
    } && run \
  '
  lint-enable
  set buffer formatcmd "nixpkgs-fmt"
  hook buffer BufWritePre .* %{
    format
    lint
  }
  lint
}
