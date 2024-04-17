{config, ...}: {
  services.avahi = {
    enable = true;
    ipv4 = true;
    ipv6 = true;
    openFirewall = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
      workstation = true;
    };
  };
}
