{config, ...}: {
  services.nix-serve = {
    enable = true;
    secretKeyFile = "/var/lib/nix-cache/cache-priv-key.pem";
  };

  services.nginx.virtualHosts."nixcache.325i.org" = {
    http3 = true; # requires services.nginx.package = pkgs.nginxQuic;
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
      proxyWebsockets = true; # needed if you need to use WebSocket
    };
  };
}
