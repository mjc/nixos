{config, ...}: {
  # services:
  # tdarr:
  #   container_name: tdarr
  #   image: ghcr.io/haveagitgat/tdarr:latest
  #   restart: unless-stopped
  #   network_mode: bridge
  #   ports:
  #     - 8265:8265 # webUI port
  #     - 8266:8266 # server port
  #   environment:
  #     - TZ=Europe/London
  #     - PUID=${PUID}
  #     - PGID=${PGID}
  #     - UMASK_SET=002
  #     - serverIP=0.0.0.0
  #     - serverPort=8266
  #     - webUIPort=8265
  #     - internalNode=true
  #     - inContainer=true
  #     - ffmpegVersion=6
  #     - nodeName=MyInternalNode
  #     - NVIDIA_DRIVER_CAPABILITIES=all
  #     - NVIDIA_VISIBLE_DEVICES=all
  #   volumes:
  #     - /docker/tdarr/server:/app/server
  #     - /docker/tdarr/configs:/app/configs
  #     - /docker/tdarr/logs:/app/logs
  #     - /media:/media
  #     - /transcode_cache:/temp

  #   devices:
  #     - /dev/dri:/dev/dri
  #   deploy:
  #     resources:
  #       reservations:
  #         devices:
  #         - driver: nvidia
  #           count: all
  #           capabilities: [gpu]
  virtualisation.oci-containers.containers.tdarr = {
    image = "ghcr.io/haveagitgat/tdarr:latest";
    autoStart = true;
    ports = [
      "8265:8265"
      "8266:8266"
    ];
    environment = {
      TZ = "America/Denver";
      PUID = "${toString config.users.users.mjc.uid}";
      PGID = "${toString config.users.groups.media.gid}";
      UMASK_SET = "002";
      serverIP = "0.0.0.0";
      serverPort = "8266";
      webUIPort = "8265";
      internalNode = "true";
      inContainer = "true";
      ffmpegVersion = "7";
      nodeName = "tina";
      NVIDIA_DRIVER_CAPABILITIES = "all";
      NVIDIA_VISIBLE_DEVICES = "all";
    };
    volumes = [
      "/var/lib/tdarr/server:/app/server"
      "/var/lib/tdarr/configs:/app/configs"
      "/var/lib/tdarr/logs:/app/logs"
      "/mnt/movies:/mnt/movies"
      "/var/lib/tdarr/cache:/temp"
    ];
  };

  services.nginx.virtualHosts."tdarr.325i.org" = {
    http3 = true; # requires services.nginx.package = pkgs.nginxQuic;
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8265";
      proxyWebsockets = true;
    };
  };
}
