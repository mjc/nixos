{pkgs, ...}: let
  webGlances = pkgs.glances.overrideAttrs (old: {
    propagatedBuildInputs =
      (old.propagatedBuildInputs or [])
      ++ (with pkgs.python3Packages; [
        batinfo
        docker
        fastapi
        orjson
        jinja2
        uvicorn
        nvidia-ml-py
        requests
        sparklines
        zeroconf
      ]);
  });
in {
  environment.systemPackages = with pkgs; [
    webGlances
  ];

  systemd.services.glances = {
    enable = true;
    wantedBy = ["multiuser.target"];
    after = ["network.target"];
    description = "Start the glances web ui";

    serviceConfig = {
      Type = "simple";
      Restart = "on-abort";
      ExecStart = ''${webGlances}/bin/glances -w -B 127.0.0.1 --enable-plugin hddtemp'';
    };
  };

  services.nginx.virtualHosts."glances.325i.org" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:61208";
      proxyWebsockets = true; # needed if you need to use WebSocket
    };
  };
}
