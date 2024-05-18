{pkgs, ...}: {
  imports = [
    ../../modules/home-manager/cli-internet.nix
    ../../modules/home-manager/cli-media.nix
    ../../modules/home-manager/cli-quality-of-life.nix
    ../../modules/home-manager/dev-tools.nix
    ../../modules/home-manager/dev-tools.nix
    ../../modules/home-manager/file-management.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/ssh-gpg.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mjc";
  home.homeDirectory = "/home/mjc";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    (writeShellScriptBin "recompress-nzbs" ''
      zfs list -o name,space,compress,compressratio backup/downloads/nzbs
      fd 'gz$' /mnt/downloads/nzbs -x gzip -fd
      sleep 5
      zfs list -o name,space,compress,compressratio backup/downloads/nzbs
    '')
  ];

  home.sessionVariables = {
    EDITOR = "emacs";
  };
}
