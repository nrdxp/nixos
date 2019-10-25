{ dirs, ... }:
self: super: {
  zsh-plugins = super.callPackage "${dirs.pkgs}/zsh-plugins.nix" {};
}
