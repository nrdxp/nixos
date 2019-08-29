{ usr, lib, ... }:
let
  inherit (lib) attrsets isString;
  inherit (attrsets) collect;
  inherit (builtins) concatStringsSep;
in
self: super: rec {
  neovim = super.neovim.override {
    configure = {
      customRC = let
        pluginRCs = concatStringsSep "\n\n"
          (collect isString usr.neovim.plugins);
      in
        concatStringsSep "\n\n" [
          usr.neovim."init.vim"
          pluginRCs
        ];

      packages.nvimPackage = with super.vimPlugins; {
        start = [
          base16-vim
          vim-polyglot
          airline
          deoplete-nvim
          neco-syntax
          vim-airline-themes
          vim-devicons
          tmux-navigator
          syntastic
          commentary
          neco-vim
          neosnippet-snippets
          neosnippet
          fzf-vim
          fzfWrapper
          gitgutter
          surround
          vim-better-whitespace
          deoplete-jedi
          delimitMate
          cute-python
          deoplete-rust
          easy-align
          haskellConcealPlus
        ];
      };
    };
  };
}
