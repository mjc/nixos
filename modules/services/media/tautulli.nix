{config, ...}: {
  services.tautulli = {
    enable = true;
    dataDir = "/var/lib/tautulli";
    group = "media";
  };
  services.nginx.virtualHosts."tautulli.325i.org" = {
    http3 = true;
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.tautulli.port}";
      proxyWebsockets = true;
    };
  };
}
