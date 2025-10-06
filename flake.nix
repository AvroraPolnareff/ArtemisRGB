{
  description = "Artemis";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.buildDotnetModule rec {
          pname = "ArtemisRGB";
          version = "acd3517";
          
          src = ./src;
          projectFile = "Artemis.UI.Linux/Artemis.UI.Linux.csproj";
          nuggetDeps = ./deps.nix;
          dotnet-sdk = pkgs.dotnetCorePackages.sdk_9_0;
          dotnet-runtime = pkgs.dotnetCorePackages.runtime_9_0;
          executables = [ "Artemis.UI.Linux" ];
          meta = with pkgs.lib; {
            description = "Artemis";
            platforms = platforms.linux;
          };
        };
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            pkgs.dotnetCorePackages.sdk_9_0;
            pkgs.dotnetCorePackages.runtime_9_0;
          ];
        };
     });
}