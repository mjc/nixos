{...}: {
  # virtualisation.oci-containers.containers.emulatorjs = {
  #   image = "linuxserver/emulatorjs";
  #   ports = [
  #     "3000:3000"
  #     "9000:80"
  #     "4001:4001"
  #   ];
  #   volumes = [
  #     "/var/lib/emulatorjs:/config:rw"
  #     "/mnt/media/emulation:/data:ro"
  #   ];
  #   autoStart = true;
  # };
  # services.nginx.virtualHosts."emulators.325i.org" = {
  #   http3 = true; # requires services.nginx.package = pkgs.nginxQuic;
  #   enableACME = true;
  #   forceSSL = true;
  #   locations."/" = {
  #     proxyPass = "http://127.0.0.1:9000";
  #     proxyWebsockets = true;
  #   };
  # };
}
