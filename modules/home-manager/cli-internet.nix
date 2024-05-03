{pkgs, ...}: {
  home.packages = with pkgs; [
    rclone
    wget
    yt-dlp
  ];
}
