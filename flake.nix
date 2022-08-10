{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        config.segger-jlink.acceptLicense = true;
      };
    in
    {
      devShell.x86_64-linux =
        pkgs.mkShell {
          shellHook = ''
            export ARM_NONE_EABI_TOOLCHAIN_PATH="${pkgs.gcc-arm-embedded}"
            export NRF5_SDK_PATH="${pkgs.nrf5-sdk}/share/nRF5_SDK"
          '';

          buildInputs = with pkgs; [
            gcc-arm-embedded
            nodePackages.lv_font_conv
            cmake
            openocd
            segger-jlink
            nrf-command-line-tools
            mynewt-newt
            nrf5-sdk
            clang-tools
            python3Packages.adafruit-nrfutil
            (python3.withPackages (ps: with ps; [
              cbor
              click
              cryptography
              numpy
              pexpect
              pillow
              pydbus
              pygobject3
              pyserial
              pysdl2
              pytest
              intelhex
              adafruit-nrfutil
            ]))
          ];
        };
    };
}
