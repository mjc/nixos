{
  pkgs,
  lib,
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
    ../../modules/home-manager/direnv.nix
    ../../modules/home-manager/cli-internet.nix
    ../../modules/home-manager/cli-media.nix
    ../../modules/home-manager/cli-quality-of-life.nix
    ../../modules/home-manager/dev-tools.nix
    ../../modules/home-manager/file-management.nix
    ../../modules/home-manager/ssh-gpg.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/zsh.nix
  ];

  home.sessionVariables = {
    EDITOR = "code -w";
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      # Add additional package names here
      "discord-ptb"
    ];

  home.packages = with pkgs; [
    discord-ptb
    nmap
  ];
}
