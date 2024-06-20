{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = with pkgs.buildPackages; [
    git
    gh
    nodePackages.cspell

    # nix lang
    alejandra # nixos formatter
    nil # nix language server
  ];
  shellHook = ''
    export GH_CONFIG_DIR=$HOME/.config/gh/personal
  '';
}
