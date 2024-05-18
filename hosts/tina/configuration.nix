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

  users.users = {
    mjc = {
      isNormalUser = true;
      extraGroups = ["wheel" "docker" "media" "backup"];
      home = "/home/mjc";
      shell = pkgs.zsh;
    };
    viki = {
      isNormalUser = true;
      extraGroups = ["media" "backup"];
      home = "/home/viki";
      shell = pkgs.zsh;
    };
    aurora = {
      isNormalUser = true;
      extraGroups = ["media" "backup"];
      home = "/home/aurora";
      shell = pkgs.zsh;
    };
  };

  users.groups.media.members = [
    "plex"
    "radarr"
    "sonarr"
    "sabnzbd"
    "bazarr"
  ];
  users.extraGroups.wheel.members = ["mjc"];
  users.extraGroups.docker.members = ["mjc"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    glances
    mosh
    fd
    ripgrep-all
    git
    microcodeAmd
    rasdaemon
    home-manager
    doas-sudo-shim
  ];

  hardware.rasdaemon.enable = true;
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  # for running binaries from other architectures
  # boot.binfmt.emulatedSystems = ["aarch64-linux" "wasm64-wasi" "x86_64-windows" "i686-windows"];

  home-manager = {
    # also pass inputs to home-manager modules
    # extraSpecialArgs = { inherit inputs; };
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

  # nix-ld fixes remote vscode
  programs.nix-ld.enable = true;

  programs.zsh.enable = true;
  programs.mosh.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [
    {
      users = ["mjc"];
      keepEnv = true;
      persist = true;
    }
  ];

  networking.firewall.enable = false;
  boot.kernel.sysctl."net.ipv4.tcp_congestion_control" = "bbr";
  boot.kernel.sysctl."net.core.default_qdisc" = "fq";
  boot.kernel.sysctl."net.core.wmem_max" = 1073741824; # 1 GiB
  boot.kernel.sysctl."net.core.rmem_max" = 1073741824; # 1 GiB
  boot.kernel.sysctl."net.ipv4.tcp_rmem" = "4096 87380 1073741824"; # 1 GiB max
  boot.kernel.sysctl."net.ipv4.tcp_wmem" = "4096 87380 1073741824"; # 1 GiB max

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
