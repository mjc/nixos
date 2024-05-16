{...}: {
  virtualisation.oci-containers.containers.overseerr = {
    image = "lscr.io/linuxserver/overseerr:develop";
    ports = ["5055:5055"];
    volumes = ["/var/lib/overseerr:/config:rw"];
    autoStart = true;
  };

  services.nginx.virtualHosts."overseerr.325i.org" = {
    http3 = true; # requires services.nginx.package = pkgs.nginxQuic;
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:5055";
      proxyWebsockets = true;
    };
  };
}
