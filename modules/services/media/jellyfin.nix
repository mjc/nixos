{pkgs, ...}: {
  services.jellyfin = {
    enable = true;
    group = "media";
  };
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
}
