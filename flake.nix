{
  description = "Raspberry Pi Pico C++ development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          cmake
          ninja
          git
          python3
          gcc
          gcc-arm-embedded
          gnumake
        ];

        shellHook = ''
          export PICO_SDK_PATH="$PWD/pico-sdk"
          echo "Pico SDK environment loaded!"
          echo "PICO_SDK_PATH=$PICO_SDK_PATH"
        '';
      };
    };
}
