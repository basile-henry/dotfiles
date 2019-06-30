self: super:

let
  haskellPackages = super.haskell.packages.ghc864;

  dhall-haskell = import (super.pkgs.fetchFromGitHub {
    owner  = "dhall-lang";
    repo   = "dhall-haskell";
    rev    = "1.24.0";
    sha256 = "0jlzimgaqdi1yj2z03p3hxlb594cd5fnw6m27gn6cwc3f37g4h68";
    fetchSubmodules = true;
  });
in
{
  userPackages = super.userPackages or {} // {

    nix             = super.nix;

    # Nix
    nix-serve       = super.nix-serve;
    niv             = (import (super.pkgs.fetchFromGitHub {
      owner  = "nmattia";
      repo   = "niv";
      rev    = "099f9ea92169c2edbc3ca33313b68f5e9686e800";
      sha256 = "1rqaw2r5wbbfpbxjgwrwzf619la1iqvzp3mhq1mfz9vk4hjd3335";
    }) {}).niv;

    # Utilities
    htop            = super.htop;
    yadm            = super.yadm;
    zsh             = super.zsh;
    tmux            = super.tmux;
    feh             = super.feh;
    awscli          = super.awscli;
    watchexec       = super.watchexec;
    light           = super.light;
    bat             = super.bat;
    fd              = super.fd;
    polybar         = super.polybar;

    # Games
    dwarf-fortress  = super.dwarf-fortress;
    infinisweep     = import (builtins.fetchGit {
      name = "infinisweep";
      url = https://github.com/basile-henry/infinisweep/;
      rev = "5dcad8cb00c3d8a2d0488cf3953ed6344761994f";
    }) {};

    # Comms
    weechat         = super.weechat;

    # Dev
    git             = super.git;
    git-lfs         = super.git-lfs;
    git-secret      = super.git-secret;
    ripgrep         = super.ripgrep;
    silver-searcher = super.silver-searcher;
    hub             = super.gitAndTools.hub;
    neovim          = super.neovim.override {
      vimAlias = true;
      viAlias  = true;
    };
    vscode          = super.vscode;

    docker          = super.docker;
    docker-compose  = super.docker-compose;
    miniserve       = super.miniserve;
    ctags           = super.ctags;

    # Shell
    shellcheck      = super.shellcheck;

    # Haskell
    ghc             = haskellPackages.ghc;
    cabal-install   = haskellPackages.cabal-install;

    stylish-haskell = haskellPackages.stylish-haskell;
    hlint           = haskellPackages.hlint;
    ghcid           = haskellPackages.callCabal2nix "ghcid" (
      super.pkgs.fetchFromGitHub {
        owner = "basile-henry";
        repo = "ghcid";
        rev = "9359c60ae253c0c0a80fbd96aa1bdf891ae7e9b2";
        sha256 = "02z1aimhs6ixgqymm6y5521iy599xdm6w0061r21xw82dzb7yvrh";
      }) {};
    hasktags        = haskellPackages.hasktags;

    # Dhall
    dhall           = dhall-haskell.dhall;
    dhall-bash      = dhall-haskell.dhall-bash;
    dhall-json      = dhall-haskell.dhall-json;
    dhall-text      = dhall-haskell.dhall-text;

    # Elm
    elm             = super.elmPackages.elm;
    elm-format      = super.elmPackages.elm-format;

    # Rust
    rustup          = super.rustup;

    # Python
    python          = super.python3;

    # Rebuild tool
    nix-rebuild     = super.writeScriptBin "nix-rebuild"
      ''
        #!${super.stdenv.shell}
        exec nix-env -f '<nixpkgs>' -r -iA userPackages
      '';
  };
}
