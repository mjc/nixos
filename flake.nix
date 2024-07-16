{
  description = "Mika's NixOS Configs";

  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # pkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    pkgs,
    nixpkgs,
    nix-darwin,
    home-manager,
    ...
  }: let
    configuration = {pkgs, ...}: {
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
      nix.settings = {
        extra-substituters = [
          "https://nixcache.325i.org"
          "https://nix-community.cachix.org"
        ];
        extra-trusted-public-keys = [
          "nixcache.325i.org:Rpps5GPjheD16IEWMx6vwAtTqDuYRffVMA4teUwnWRI="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };
  in {
    nixosConfigurations.tina = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        configuration
        ./hosts/tina/configuration.nix
        # this machine backs up important data to another zfs pool
        ./modules/services/backup.nix
        ./modules/nixos/nvidia.nix
        ./modules/nixos/disks.nix

        ./modules/services/docker.nix

        ./modules/services/tailscale.nix
        ./modules/services/avahi.nix
        ./modules/services/samba.nix
        ./modules/services/openssh.nix
        ./modules/services/web/nix-serve.nix

        ./modules/services/nginx.nix
        ./modules/services/glances.nix

        ./modules/services/jdownloader2.nix

        ./modules/services/homeassistant.nix

        ./modules/services/media/bazarr.nix

        ./modules/services/media/lidarr.nix
        ./modules/services/media/overseerr.nix
        ./modules/services/media/radarr.nix
        ./modules/services/media/sonarr.nix

        # ./modules/services/media/tdarr-server.nix

        ./modules/services/media/jellyfin.nix
        ./modules/services/media/plex.nix
        ./modules/services/media/tautulli.nix

        ./modules/services/usenet/prowlarr.nix
        ./modules/services/usenet/sabnzbd.nix

        inputs.home-manager.nixosModules.default
      ];
    };

    nixosConfigurations.tali = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        configuration
        ./hosts/tali/configuration.nix


        # inputs.home-manager.nixosModules.default
      ];
    };


    darwinConfigurations."mika-m1" = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs;};
      modules = [
        configuration
        ./hosts/mika-m1/configuration.nix

        home-manager.darwinModules.home-manager
        {
          home-manager.users.mjc = import ./hosts/mika-m1/home.nix;
          users.users.mjc.home = "/Users/mjc";
        }
      ];
    };

    darwinConfigurations."Mika-ELC-Laptop" = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs;};
      modules = [
        configuration
        ./hosts/Mika-ELC-Laptop/configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            users.mcohen = import ./hosts/Mika-ELC-Laptop/home.nix;
            backupFileExtension = ".home-manager-backup";
          };
          users.users.mcohen.home = "/Users/mcohen";
        }
      ];
    };
  };
}
