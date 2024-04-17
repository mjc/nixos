# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    zfsSupport = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    mirroredBoots = [
      {
        devices = ["nodev"];
        path = "/boot";
      }
    ];
  };

  networking.hostName = "tina"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/Denver";

  nixpkgs.config.allowUnfree = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  users.defaultUserShell = pkgs.zsh;

  users.groups.media.members = ["mjc" "plex" "radarr" "sonarr" "sabnzbd" "bazarr"];

  users.users.mjc = {
    isNormalUser = true;
  };


  users.extraGroups.wheel.members = ["mjc"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    emacs
    wget
    fd
    alejandra
    nixfmt-rfc-style
    glances
    hddtemp
    mediainfo
    git
  ];

  home-manager = {
    # also pass inputs to home-manager modules
    #extraSpecialArgs = { inherit inputs; };
    users = {
      "mjc" = import ./home.nix;
    };
  };

  # makes nix search work
  nix = {
    package = pkgs.nixFlakes;
    extraOptions =
      lib.optionalString (config.nix.package == pkgs.nixFlakes)
      "experimental-features = nix-command flakes";
  };

  # nix.settings.auto-optimise-store = true;
  # schedule, rather than run every time. I have lots of space.
  nix.optimise.automatic = true;
  nix.optimise.dates = ["05:00"];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.nix-ld.enable = true;
  programs.zsh.enable = true;
  programs.mosh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  services.smartd.enable = true;
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.avahi = {
    enable = true;
    ipv4 = true;
    ipv6 = true;
    openFirewall = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
      workstation = true;
    };
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };

  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    extraConfig = ''
      server string = tina
      netbios name = tina
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
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    # other Nginx options
    virtualHosts."325i.org" = {
      enableACME = true;
      root = "/var/www";
    };
    virtualHosts."sonarr.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8989";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."prowlarr.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:9696";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."radarr.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:7878";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."bazarr.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:6767";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."sabnzbd.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8080";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    virtualHosts."plex.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:32400";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };
    # virtualHosts."jellyfin.325i.org" = {
    #   enableACME = true;
    #   forceSSL = true;
    #   root = "/var/www";
    #   locations."/" = {
    #     proxyPass = "http://127.0.0.1:8096";
    #     proxyWebsockets = true; # needed if you need to use WebSocket
    #   };
    # };
    virtualHosts."glances.325i.org" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:61208";
        proxyWebsockets = true; # needed if you need to use WebSocket
      };
    };

    appendHttpConfig = ''
      real_ip_header CF-Connecting-IP;
    '';
  };

  systemd.services.hddtemp = {
    enable = true;
    wantedBy = ["multiuser.target"];
    after = ["network.target"];

    description = "Hard drive temperature monitor daemon";

    serviceConfig = {
      Type = "simple";
      Restart = "on-abort";
      Group = "disk";
      ExecStart = ''${pkgs.hddtemp}/bin/hddtemp -d /dev/sd?'';
    };
  };

  # TODO: figure out why services.glances.enable = true; does not work
  systemd.services.glances = {
    enable = true;
    wantedBy = ["multiuser.target"];
    after = ["network.target"];
    description = "Start the glances web ui";

    serviceConfig = {
      Type = "simple";
      RemainAfterExit = "yes";
      Restart = "on-abort";
      User = "mjc";
      ExecStart = ''${pkgs.glances}/bin/glances -w -B 127.0.0.1 --enable-plugin hddtemp'';
    };
  };

  services.bazarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
    user = "mjc";
    group = "media";
  };

  services.prowlarr = {
    enable = true;
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
    user = "mjc";
    group = "media";
  };

  services.sabnzbd = {
    enable = true;
    #openFirewall = true;
    user = "mjc";
    group = "media";
  };
  
  services.plex = let
    plexpass = pkgs.plex.override {
      plexRaw = pkgs.plexRaw.overrideAttrs (old: rec {
        version = "1.40.2.8351-9938371be";
        src = pkgs.fetchurl {
          url = "https://downloads.plex.tv/plex-media-server-new/${version}/debian/plexmediaserver_${version}_amd64.deb";
          sha256 = "sha256-yL/3cNChtdfYaRqRl0WeJuc3Y6F/r4r63fVIVjk+FeY=";
        };
      });
    };
  in {
    enable = true;
    openFirewall = true;
    package = plexpass;
    group = "media";
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "michael.joseph.cohen@gmail.com";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall.enable = false;

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "zfs";

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
