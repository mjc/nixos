{pkgs, ...}: {
  home.packages = with pkgs; [
    fd
    ripgrep
    bat
    fd
    ripgrep
  ];
}
