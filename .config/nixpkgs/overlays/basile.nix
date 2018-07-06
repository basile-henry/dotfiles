self: super:

let
  haskellPackages = super.haskell.packages.ghc843;
in
{
  userPackages = super.userPackages or {} // {

    # Utilities
    htop            = super.htop;
    git             = super.git;
    hub             = super.gitAndTools.hub;
    neovim          = super.neovim.override {
      vimAlias = true;
      viAlias  = true;
    };

    yadm            = super.yadm;
    zsh             = super.zsh;
    ripgrep         = super.ripgrep;
    silver-searcher = super.silver-searcher;
    feh             = super.feh;

    # Haskell
    ghc             = haskellPackages.ghc;
    cabal-install   = haskellPackages.cabal-install;
    stylish-haskell = haskellPackages.stylish-haskell;
    hlint           = haskellPackages.hlint;
    ghcid           = haskellPackages.ghcid;

    # Elm
    elm             = super.elmPackages.elm;
    elm-format      = super.elmPackages.elm-format;

    # Rust
    rustc           = super.rustc;
    cargo           = super.cargo;

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
