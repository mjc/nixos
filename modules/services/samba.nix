# TODO: not working quite yet
{...}: {
  services.samba = {
    enable = true;
    enableNmbd = true;
    enableWinbindd = true;
    nsswins = true;

    securityType = "user";
    openFirewall = true;
    extraConfig = ''
      server string = tina
      netbios name = tina
      workgroup = WORKGROUP
      use sendfile = yes
      hosts allow = 192.168.1.0/24 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
      browseable = yes
    '';

    shares = {
      homes = {
        browseable = "no";
        "guest ok" = "no";
      };
      apps = {
        path = "/mnt/media/apps";
        browseable = "yes";
        "guest ok" = "yes";
        "write list" = "mjc";
      };
      games = {
        path = "/mnt/media/games";
        browseable = "yes";
        "guest ok" = "yes";
        "write list" = "mjc";
      };
      music = {
        path = "/mnt/media/music";
        browseable = "yes";
        "guest ok" = "yes";
        "write list" = "mjc";
      };
      movies = {
        path = "/mnt/media/movies";
        browseable = "yes";
        "guest ok" = "yes";
        "write list" = "mjc";
      };
      tv = {
        path = "/mnt/tv";
        browseable = "yes";
        "guest ok" = "yes";
        "write list" = "mjc";
      };
      backup = {
        path = "/mnt/backup";
        "valid users" = "mjc viki";
        browseable = "yes";
        "guest ok" = "no";
      };
      time_machine = {
        path = "/mnt/backup/time_machine";
        "valid users" = "mjc viki";
        public = "no";
        writeable = "yes";
        "force group" = "media";
        "fruit:aapl" = "yes";
        "fruit:time machine" = "yes";
        "vfs objects" = "catia fruit streams_xattr";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
