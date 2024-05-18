{...}: {
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
