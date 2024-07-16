{pkgs, ...}: {
  # services.gpg-agent = {
  #   enable = true;
  #   defaultCacheTtl = 1800;
  #   enableSshSupport = true;
  # };
  home.packages = with pkgs; [
    mosh
  ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    compression = true;
    controlMaster = "auto";
    controlPersist = "yes";
    forwardAgent = true;

    matchBlocks = {
      "tina" = {
        hostname = "tina";
        user = "mjc";
        forwardAgent = true;
      };
      "tina_remote" = {
        hostname = "router.325i.org";
        user = "mjc";
        forwardAgent = true;
        port = 1122;
      };
      "router" = {
        hostname = "router.325i.org";
        user = "mjc";
        forwardAgent = true;
        port = 2211;
      };
      "tali" = {
        "hostname" = "192.168.1.37"; # fixme
        "user" = "mjc";
        "forwardAgent" = true;
      };
    };

    # knownHosts = {
    #   "tina" = {
    #     publicKeyFile = "ssh-hosts/tina";
    #     hostNames = [
    #       "tina"
    #       "tina.local"
    #       "tina.lan.325i.org"
    #     ];
    #   };
    # };
  };
}
