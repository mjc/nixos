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

  networking.hostName = "tina"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/Denver";

  users.defaultUserShell = pkgs.zsh;

  users.groups.media.members = ["mjc" "plex" "radarr" "sonarr" "sabnzbd" "bazarr"];

  users.users.mjc = {
    isNormalUser = true;
  };

  users.extraGroups.wheel.members = ["mjc"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    glances
    hddtemp
    fd
    ripgrep
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

  services.smartd.enable = true;
  services.smartd.autodetect = true;
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };

  # TODO: this doesn't work  yet either
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
