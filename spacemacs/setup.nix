#!/usr/bin/env nix-shell
#!nix-shell ./setup.nix --run exit

{ pkgs ? import ../nix/pinned.nix {} }:

let
  elpaDevelop = "~/.emacs.d/elpa/develop/";
  melpaPackages = import ./melpa-packages.nix { inherit pkgs; };
  cpMelpaPackages = drv: ''
    mkdir -p ${elpaDevelop}
    SITE_LOCATION=${drv.outPath}/share/emacs/site-lisp/elpa/*
    echo "copying $SITE_LOCATION to ${elpaDevelop}"
    cp -R --no-preserve=mode $SITE_LOCATION ${elpaDevelop}
  '';
  copyMelpaPackages = builtins.map cpMelpaPackages (builtins.attrValues melpaPackages);

  brokenPackages = pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "broken-emacs-packages";
    rev = "772977babed4e90214067d3636e9130b8898ab71";
    sha256 = "1j0yw0ar2w8plyldivzybf4c0p7hh6gxls63k8dfx9qcmns6bmhg";
  };

in pkgs.stdenv.mkDerivation {
  name = "spacemacs-install";
  src = pkgs.fetchFromGitHub {
    owner = "syl20bnr";
    repo = "spacemacs";
    # warning: do not let this update to the useless master branch
    rev = "4b195ddfc9228256361e0b264fe974aa86ed51a8";
    sha256 = "123mc3hb13kq812l4nv2c7qbasqadyjj3nyhj5y8psg5lqdrl6qx";
  };
  phases = "unpackPhase";
  shellHook = ''
    echo $src
    echo "copying $src to ~/.emacs.d"
    cp -TR --no-preserve=mode $src ~/.emacs.d
    ${builtins.toString copyMelpaPackages}
    echo "copying broken packages"
    cp -R --no-preserve=mode ${brokenPackages.outPath}/* ${elpaDevelop}
    find ${brokenPackages.outPath} -maxdepth 1 -type d \
      -exec cp --no-preserve=mode -vR {} ${elpaDevelop} \;
  '';
}
