{pkgs, ...}: {
  services.plex = let
    plexpass = pkgs.plex.override {
      plexRaw = pkgs.plexRaw.overrideAttrs (old: rec {
        version = "1.40.2.8395-c67dce28e";
        src = pkgs.fetchurl {
          url = "https://downloads.plex.tv/plex-media-server-new/${version}/debian/plexmediaserver_${version}_amd64.deb";
          sha256 = "sha256-gYRhQIf6RaXgFTaigFW1yJ7ndxRmOP6oJSNnr8o0EBM=";
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
    quic = true; # requires services.nginx.package = pkgs.nginxQuic;
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:32400";
      proxyWebsockets = true; # needed if you need to use WebSocket
    };
  };
}
