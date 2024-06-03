{pkgs, ...}: {
  services.plex = let
    plexpass = pkgs.plex.override {
      plexRaw = pkgs.plexRaw.overrideAttrs (old: rec {
        version = "1.40.3.8530-ac2fe9b3c";
        src = pkgs.fetchurl {
          url = "https://downloads.plex.tv/plex-media-server-new/${version}/debian/plexmediaserver_${version}_amd64.deb";
          sha256 = "sha256-A/2nv7kZnolC+i+k54N5WZ5U8WaAy7g7UyeCAxwTQps=";
        };
      });
    };
  in {
    enable = true;
    openFirewall = true;
    package = plexpass;
    group = "media";
  };

  services.nginx.virtualHosts."plex.325i.org" = {
    http3 = true; # requires services.nginx.package = pkgs.nginxQuic;
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:32400";
      proxyWebsockets = true; # needed if you need to use WebSocket
    };
  };
}
