{pkgs, ...}: {
  home.packages = with pkgs; [
    jq

    git
    gh
    nodePackages.cspell

    # nix lang
    alejandra # nixos formatter
    nil # nix language server

    # rust lang
    clang
    llvm
    mold
    rustup
  ];
}
