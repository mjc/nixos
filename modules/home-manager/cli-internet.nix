{pkgs, ...}: {
  home.packages = with pkgs; [
    rclone
    wget
    yt-dlp

    mosh
  ];

  security.pam.sshAgentAuth.enable = true;
  programs.ssh.knownHosts = {
    "tina" = {
      publicKeyFile = "ssh-hosts/tina";
      hostNames = [
        "tina"
        "tina.local"
        "tina.lan.325i.org"
      ];
    };
  };
}
