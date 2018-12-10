self: super:

let
  haskellPackages = super.haskell.packages.ghc844;

  dhall-haskell = import (builtins.fetchGit {
      name = "dhall-haskell";
      url = https://github.com/dhall-lang/dhall-haskell/;
      rev = "67ebf6efd67f68fdae742311497f09854ee04457";
    });
in
{
  userPackages = super.userPackages or {} // {

    nix             = super.nix;

    # Nix
    nix-serve       = super.nix-serve;

    # Utilities
    htop            = super.htop;
    yadm            = super.yadm;
    zsh             = super.zsh;
    tmux            = super.tmux;
    feh             = super.feh;
    awscli          = super.awscli;
    eternal-terminal= super.eternal-terminal;

    # Games
    infinisweep     = import (builtins.fetchGit {
      name = "infinisweep";
      url = https://github.com/basile-henry/infinisweep/;
      rev = "5dcad8cb00c3d8a2d0488cf3953ed6344761994f";
    }) {};

    # Comms
    weechat         = super.weechat;

    # Dev
    git             = super.git;
    ripgrep         = super.ripgrep;
    silver-searcher = super.silver-searcher;
    hub             = super.gitAndTools.hub;
    neovim          = super.neovim.override {
      vimAlias = true;
      viAlias  = true;
    };
    docker          = super.docker;
    docker-compose  = super.docker-compose;

    # Shell
    shellcheck      = super.shellcheck;

    # Haskell
    ghc             = haskellPackages.ghc;
    cabal-install   = haskellPackages.cabal-install;
    stylish-haskell = haskellPackages.stylish-haskell;
    hlint           = haskellPackages.hlint;
    ghcid           = haskellPackages.ghcid;

    # Dhall
    dhall           = dhall-haskell.dhall;
    dhall-bash      = dhall-haskell.dhall-bash;
    dhall-json      = dhall-haskell.dhall-json;
    dhall-text      = dhall-haskell.dhall-text;

    # Elm
    elm             = super.elmPackages.elm;

    # Rust
    rustup          = super.rustup;

    # Python
    python          = super.python;
    python3         = super.python3;

    # Rebuild tool
    nix-rebuild     = super.writeScriptBin "nix-rebuild"
      ''
        #!${super.stdenv.shell}
        exec nix-env -f '<nixpkgs>' -r -iA userPackages
      '';
  };
}
