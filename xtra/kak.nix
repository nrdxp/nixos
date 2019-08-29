{ pkgs, ... }:
{ imports = [ ./home.nix ];
  environment.systemPackages = with pkgs; with pkgs.elmPackages;
  let kak = kakoune.override {
    configure.plugins = with kakounePlugins;
    [ (kak-fzf.override { fzf = pkgs.skim; })
      kak-powerline
      kak-auto-pairs
      kak-vertical-selection
      kak-buffers
    ];
  };
  in
  [ kak kak-lsp elm elm-analyse elm-format elm-test ];

  programs.zsh.shellAliases =
  { k = "kak";
  };
  home-manager.users.nrd.home.file = with builtins;
  { ".config/kak/kakrc".source = ./kak/kakrc;
    ".config/kak-lsp/kak-lsp.toml".source = ./kak/kak-lsp.toml;
    ".config/kak/autoload/plugins".source = ./kak/plugins;
    ".config/kak/autoload/default".source = "${pkgs.kakoune-unwrapped}/share/kak/rc";
    ".config/kak/autoload/move-line.kak".text =
      readFile ( fetchurl
        https://raw.githubusercontent.com/alexherbo2/move-line.kak/master/rc/move-line.kak
      ) + ''
      map global normal "'" ': move-line-below %val{count}<ret>'
      map global normal "<a-'>" ': move-line-above %val{count}<ret>'
      '';
    ".config/kak/autoload/kakboard.kak".text =
      readFile ( fetchurl
        https://raw.githubusercontent.com/lePerdu/kakboard/master/kakboard.kak
      ) + ''
      hook global WinCreate .* %{ kakboard-enable }
      '';
  };
}
