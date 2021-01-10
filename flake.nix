{
  description = "Test flake";

  inputs = {
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages."${system}";
    in rec {
      # `nix build`
      packages.hello = pkgs.hello;
      defaultPackage = packages.hello;

      # `nix run`
      apps.hello = utils.lib.mkApp {
        drv = packages.hello;
      };
      defaultApp = apps.hello;
    });
}
