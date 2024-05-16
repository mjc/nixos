{...}: {
  services.bazarr = {
    enable = true;
    group = "media";
  };

  services.nginx.virtualHosts."bazarr.325i.org" = {
    quic = true; # requires services.nginx.package = pkgs.nginxQuic;
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:6767";
      proxyWebsockets = true; # needed if you need to use WebSocket
    };
  };
}
