{...}: {
  virtualisation.oci-containers = {
    containers.homeassistant = {
      volumes = ["home-assistant:/config"];
      environment.TZ = "America/Denver";
      image = "ghcr.io/home-assistant/home-assistant:stable"; # Warning: if the tag does not change, the image will not be updated
      extraOptions = [
        "--network=host"
        "--device=/dev/ttyACM0:/dev/ttyACM0" # Example, change this to match your own hardware
      ];
    };
  };

  services.nginx.virtualHosts."homeassistant.325i.org" = {
    http3 = true; # requires services.nginx.package = pkgs.nginxQuic;
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8123";
      proxyWebsockets = true;
    };
  };
}
