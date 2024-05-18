{...}: {
  services.sonarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  services.nginx.virtualHosts."sonarr.325i.org" = {
    http3 = true; # requires services.nginx.package = pkgs.nginxQuic;
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8989";
      proxyWebsockets = true;
    };
  };
}
