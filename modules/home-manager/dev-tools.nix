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

  home.file = {
    ".cargo/config.toml" = {
      text = ''
        [target.x86_64-unknown-linux-gnu]
        linker = "${pkgs.clang}/bin/clang"
        rustflags = ["-C", "link-arg=--ld-path=${pkgs.mold}/bin/mold", "-C", "target-cpu=native", "-Z", "threads=8"]
      '';
      executable = false;
    };
  };
}
