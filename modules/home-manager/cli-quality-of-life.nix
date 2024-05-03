{pkgs, ...}: {
  home.packages = with pkgs; [
    emacs
    ncdu
    htop
    tmux
    thefuck
  ];
}
