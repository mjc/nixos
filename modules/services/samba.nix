# TODO: not working quite yet
{...}: {
  services.samba = {
    enable = true;
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
        "read only" = "no";
        "guest ok" = "no";
      };
      movies = {
        path = "/mnt/movies";
        browseable = "yes";
        "read only" = "yes";
        "guest ok" = "yes";
      };
      backup = {
        path = "/mnt/backup";
        "valid users" = "mjc viki";
        browseable = "yes";
        "read only" = "no";
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
