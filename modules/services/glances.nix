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
}
