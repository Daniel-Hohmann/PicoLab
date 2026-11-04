{
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
          export PROJECT_ROOT="$PWD"
          export PICO_SDK_PATH="$PROJECT_ROOT/pico-sdk"

          echo "Pico SDK environment loaded!"
          echo "PICO_SDK_PATH=$PICO_SDK_PATH"

          if [ ! -d "$PICO_SDK_PATH" ]; then
            echo "ERROR: Pico SDK not found!"
            return 1
          fi

          echo "Setting up CMake paths..."

          cp "$PICO_SDK_PATH/external/pico_sdk_import.cmake" \
             "$PROJECT_ROOT/firmware/"

          cd "$PROJECT_ROOT/firmware"

          echo "Working directory: $PWD"
        '';
      };
    };
}
