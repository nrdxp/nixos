{ pkgs, ... }:
{ imports = [ ./home.nix ];
  environment.systemPackages = with pkgs; with pkgs.elmPackages;
  let kak = kakoune.override {
    configure.plugins = with kakounePlugins;
    [ kak-fzf
      kak-powerline
      kak-auto-pairs
      kak-vertical-selection
      kak-buffers
    ];
  };
  in
  [ kak kak-lsp elm elm-analyse elm-format elm-test ];

  home-manager.users.nrd.home.file =
  { ".config/kak/kakrc".source = ./kak/kakrc;
    ".config/kak-lsp/kak-lsp.toml".source = ./kak/kak-lsp.toml;
    ".config/kak/autoload/plugins".source = ./kak/plugins;
    ".config/kak/autoload/default".source = "${pkgs.kakoune-unwrapped}/share/kak/rc";
  };
}
