{
  description = "Mika's NixOS Configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations.tina = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/tina/configuration.nix
        ./modules/nixos/nvidia.nix
        ./modules/nixos/disks.nix

        ./modules/services/docker.nix
        ./modules/services/jdownloader.nix

        ./modules/services/tailscale.nix
        ./modules/services/avahi.nix
        ./modules/services/samba.nix
        ./modules/services/openssh.nix

        ./modules/services/nginx.nix
        ./modules/services/glances.nix
        ./modules/services/media.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
