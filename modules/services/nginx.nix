{pkgs, ...}: {
  security.acme = {
    acceptTerms = true;
    defaults.email = "michael.joseph.cohen@gmail.com";
  };

  services.nginx = {
    package = pkgs.nginxQuic;
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    # other Nginx options
    appendHttpConfig = ''
      real_ip_header CF-Connecting-IP;
    '';
  };

  services.nginx.virtualHosts."325i.org" = {
    forceSSL = false;
    enableACME = true;
    root = "/var/www";
    quic = true;
  };

  services.nginx.virtualHosts."home.325i.org" = {
    forceSSL = false;
    enableACME = true;
    root = "/var/www";
    quic = true;
  };
}
