{...}: {
  virtualisation.oci-containers.containers.organizrr = {
    image = "organizr/organizr";
    ports = ["9898:80"];
    volumes = ["/var/lib/organizrr:/config:rw"];
    environment = {
      TZ = "America/Denver";
      # fpm = true;
      branch = "v2-master";
      PGID = "994";
    };
  };

  services.nginx.virtualHosts."organizrr.325i.org" = {
    http3 = true; # requires services.nginx.package = pkgs.nginxQuic;
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:9898";
      proxyWebsockets = true;
    };
  };
}
