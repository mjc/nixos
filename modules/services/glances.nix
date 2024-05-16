{pkgs, ...}: {
  # TODO: figure out why services.glances.enable = true; does not work
  systemd.services.glances = {
    enable = true;
    wantedBy = ["multiuser.target"];
    after = ["network.target"];
    description = "Start the glances web ui";

    serviceConfig = {
      Type = "simple";
      Restart = "on-abort";
      ExecStart = ''${pkgs.glances}/bin/glances -w -B 127.0.0.1 --enable-plugin hddtemp'';
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
