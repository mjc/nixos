{
  pkgs,
  config,
  ...
}: {
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/dev-tools.nix
  ];

  home.packages = with pkgs; [
    emacs

    mosh

    jq
    fd
    ripgrep
    git

    thefuck
    starship
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

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autocd = true; # typing /foo will do cd /foo if /foo is a directory.

    enableVteIntegration = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "thefuck" "history" "rust" "fd" "gh" "mosh" "ssh-agent" "sudo" "tmux"];
      theme = "robbyrussell";
      extraConfig = ''
        PATH=$HOME/.cargo/bin:$PATH
      '';
    };
  };
}
