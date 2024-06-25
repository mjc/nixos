{config, ...}: {
  virtualisation.oci-containers.containers.tautulli = {
    image = "linuxserver/tautulli";
    ports = ["8181:8181"];
    volumes = ["/var/lib/tautulli:/config:rw"];
    autoStart = true;
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
