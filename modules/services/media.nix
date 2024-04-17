{pkgs, ...}: {
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
        version = "1.40.2.8383-15541a816";
        src = pkgs.fetchurl {
          url = "https://downloads.plex.tv/plex-media-server-new/${version}/debian/plexmediaserver_${version}_amd64.deb";
          sha256 = "sha256-iL+kzAcAw8V8dmd1t8aAO8T/eKLAtnLGSBXepS9JCJQ=";
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
