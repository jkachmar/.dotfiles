{ pkgs ? import ./pinned.nix {} }:

let
  easy-dhall = import ./easy-dhall.nix;
  easy-ps = import ./easy-ps.nix {};

  i3-pkgs = rec {
    # i3 = pkgs.i3;
    # old overrides:
    i3 = pkgs.i3.overrideAttrs (old: rec {
      name = "i3-${version}";
      version = "4.16.1";

      src = pkgs.fetchurl {
        url = "https://i3wm.org/downloads/i3-4.16.tar.bz2";
        sha256 = "1d2mnryn7m9c6d69awd7lwzadliapd0ahi5n8d0ppqy533ssaq6c";
      };
    });

    polybar = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };

    inherit (pkgs)
    scrot
    i3status
    feh
    rofi;
  };

  prefetch-url = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "prefetch-url";
    rev = "18b809cdab5c5b3c7756581267272616691a3a8e";
    sha256 = "1kk69ddmv1jhck642nnlkixik64bfmdq7g3555q67xkbdnklfmjy";
  }) {};

  prefetch-github = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "prefetch-github";
    rev = "01f2706918fa7c6dfbcd4d495fa94d933c86d9ff";
    sha256 = "02gnrhqy02bc97wwff89h96hgri4r9m8ardqfay1fwg9pdghcj3p";
  }) {};

  update-fetch-derivations = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "update-fetch-derivations";
    rev = "fe451e679fcf62e4471a4d717096f8a272cf3688";
    sha256 = "0if84dgb7hz061i83j4a8v4g0crcj2y9v6cl7sr50djlcy4qgrc1";
  }) {};

  polyglot = pkgs.stdenv.mkDerivation {
    name = "polyglot";
    src = pkgs.fetchurl {
      url = "https://github.com/vmchale/polyglot/releases/download/0.5.16/poly-x86_64-unknown-linux-icc";
      sha256 = "1c9bk7bkrs39l660077cr356d5r0v0cmyh0swymcm6gy1dsivv4n";
    };

    unpackPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/polyglot
      chmod +x $out/bin/polyglot
    '';

    dontInstall = true;
  };

  alacritty = pkgs.stdenv.mkDerivation {
    name = "alacritty";
    src = pkgs.fetchurl {
      url = "https://github.com/jwilm/alacritty/releases/download/v0.2.7/Alacritty-v0.2.7-x86_64.tar.gz";
      sha256 = "0g11zah3mxz52768c2kr6fjkd2crr2jm194lv14bmpjgvidvj9y4";
    };

    unpackPhase = ''
      mkdir -p $out/bin
      tar xf $src -C $out/bin
      chmod u+w $out/bin/alacritty
    '';

    dontInstall = true;
  };

  z = import ./z.nix { inherit pkgs; };
  liquidprompt = import ./liquidprompt.nix { inherit pkgs; };

  ps-pkgs = {
    inherit (easy-ps.inputs)
    purs
    psc-package-simple
    purp
    spacchetti-cli;
  };

  dhall-pkgs = {
    inherit (easy-dhall)
    dhall-simple
    dhall-json-simple
    dhall-bash-simple
    dhall-text-simple;
  };

  gnome3-pkgs = {
    inherit (pkgs.gnome3)
    # nautilus
    eog
    evince;
  };

  firefox = import ./firefox.nix { inherit pkgs; };

in   i3-pkgs
  // dhall-pkgs
  // ps-pkgs
  // gnome3-pkgs
  // {

    inherit alacritty;
    inherit firefox;
    inherit liquidprompt;
    inherit polyglot;
    inherit prefetch-github;
    inherit prefetch-url;
    inherit update-fetch-derivations;
    inherit z;

    inherit (pkgs)

    autorandr
    bash-completion
    colordiff
    colormake
    disper
    emacs
    fd
    fzf
    gitg
    gnumake
    jq
    neovim
    nix-bash-completions
    nodejs-10_x
    noto-fonts-cjk
    pavucontrol
    perl
    perlcritic
    playerctl
    ripgrep
    shellcheck
    sqlitebrowser
    tig
    tmux
    xdotool
    watchexec
    ;

    inherit(pkgs.gitAndTools)
    git-extras
    hub;
  }
