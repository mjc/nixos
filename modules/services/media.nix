{
  config,
  pkgs,
  ...
}: {
  services.bazarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
    user = "mjc";
    group = "media";
  };

  services.prowlarr = {
    enable = true;
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
    user = "mjc";
    group = "media";
  };

  services.sabnzbd = {
    enable = true;
    #openFirewall = true;
    user = "mjc";
    group = "media";
  };

  services.plex = let
    plexpass = pkgs.plex.override {
      plexRaw = pkgs.plexRaw.overrideAttrs (old: rec {
        version = "1.40.2.8351-9938371be";
        src = pkgs.fetchurl {
          url = "https://downloads.plex.tv/plex-media-server-new/${version}/debian/plexmediaserver_${version}_amd64.deb";
          sha256 = "sha256-yL/3cNChtdfYaRqRl0WeJuc3Y6F/r4r63fVIVjk+FeY=";
        };
      });
    };
  in {
    enable = true;
    openFirewall = true;
    package = plexpass;
    group = "media";
  };
}
