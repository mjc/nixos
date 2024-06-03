{
  description = "Mika's NixOS Configs";

  inputs = {
    # pkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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

        ./modules/services/nginx.nix
        ./modules/services/glances.nix

        ./modules/services/jdownloader2.nix

        ./modules/services/homeassistant.nix

        ./modules/services/media/bazarr.nix
        ./modules/services/media/overseerr.nix
        ./modules/services/media/plex.nix
        ./modules/services/media/radarr.nix
        ./modules/services/media/sonarr.nix
        ./modules/services/media/tautulli.nix
        ./modules/services/media/fileflows.nix

        ./modules/services/usenet/prowlarr.nix
        ./modules/services/usenet/sabnzbd.nix

        # ./modules/services/web/organizrr.nix

        inputs.home-manager.nixosModules.default
      ];
    };

    darwinConfigurations."mika-m1" = nix-darwin.lib.darwinSystem {
      specialArgs = {inherit inputs;};
      modules = [
        configuration
        ./hosts/mika-m1/configuration.nix

        home-manager.darwinModules.home-manager
        {
          home-manager = {
            # include the home-manager module
            users.mjc = import ./hosts/mika-m1/home.nix;
          };
          users.users.mjc.home = "/Users/mjc";
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."mika-m1".pkgs;
  };
}
