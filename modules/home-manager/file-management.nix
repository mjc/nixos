{pkgs, ...}: {
  home.packages = with pkgs; [
    bat
    fd
    ripgrep-all
  ];
}
