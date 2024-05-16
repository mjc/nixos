{...}: {
  services.sabnzbd = {
    enable = true;
    #openFirewall = true;
    group = "media";
  };
  services.nginx.virtualHosts."sabnzbd.325i.org" = {
    http3 = true; # requires services.nginx.package = pkgs.nginxQuic;
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8080";
      proxyWebsockets = true; # needed if you need to use WebSocket
    };
  };
}
