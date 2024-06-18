{...}: {
  services.lidarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  services.nginx.virtualHosts."lidarr.325i.org" = {
    http3 = true; # requires services.nginx.package = pkgs.nginxQuic;
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8686";
      proxyWebsockets = true;
    };
  };
}
