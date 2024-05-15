{pkgs, ...}: {
  home.packages = with pkgs; [
    emacs
    ncdu
    htop
    tmux
    thefuck
    ripgrep
    fd
  ];

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };
}
