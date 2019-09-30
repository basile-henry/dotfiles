self: super:

{
  userPackages = super.userPackages or {} // {

    # Nix
    inherit (super)
      nix-repl
      nix-serve;

    # Utilities
    inherit (super)
      htop
      yadm
      zsh
      tmux
      ripgrep
      silver-searcher
      fzf
      feh
      gawk
      git-secret
      miniserve
      watchexec
      weechat;

    # Dev
    inherit (super)
      git
      git-lfs
      docker
      ctags;
    inherit (super.gitAndTools) hub;
    neovim = super.neovim.override {
      vimAlias = true;
      viAlias  = true;
    };

    # Shell
    inherit (super)
      shellcheck;

    # Haskell
    inherit (super.haskellPackages)
      ghc
      ghcid
      cabal-install
      cabal2nix
      stylish-haskell
      hlint
      hasktags;

    # Elm
    inherit (super.elmPackages)
      elm
      elm-format;

    # Rust
    inherit (super)
      rustup;

    # Python
    inherit (super.python3Packages)
      python
      ipython
      pylint
      mypy;

    # Rebuild tool
    nix-rebuild     = super.writeScriptBin "nix-rebuild"
      ''
        #!${super.stdenv.shell}
        exec nix-env -f '<nixpkgs>' -r -iA userPackages
      '';
  };
}
