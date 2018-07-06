self: super:

let
  haskellPackages = super.haskell.packages.ghc843;
in
{
  userPackages = super.userPackages or {} // {

    # Utilities
    htop            = super.htop;
    git             = super.git;
    neovim          = super.neovim;
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

    # Rust
    rustc           = super.rustc;
    cargo           = super.cargo;
    
    # Rebuild tool
    nix-rebuild     = super.writeScriptBin "nix-rebuild"
      ''
        #!${super.stdenv.shell}
        exec nix-env -f '<nixpkgs>' -r -iA userPackages
      '';
  };
}
