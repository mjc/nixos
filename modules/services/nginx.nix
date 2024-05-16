{pkgs, ...}: {
  security.acme = {
    acceptTerms = true;
    defaults.email = "michael.joseph.cohen@gmail.com";
  };

  services.nginx = {
    package = pkgs.nginxQuic;
    enable = true;

    enableQuicBPF = true;

    recommendedBrotliSettings = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedZstdSettings = true;
    # other Nginx options
    appendHttpConfig = ''
      real_ip_header CF-Connecting-IP;
    '';

    virtualHosts."home.325i.org" = {
      default = true;
      forceSSL = true;
      enableACME = true;
      root = "/var/www/home.325i.org";
      http3 = true;
      serverAliases = ["www.325i.org" "router.325i.org"];
    };
  };
}
