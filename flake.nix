{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    nixpkgs-lv_img_conv.url = "github:StarGate01/nixpkgs/lv_img_conv";
  };

  outputs = { self, nixpkgs, nixpkgs-lv_img_conv }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        config.segger-jlink.acceptLicense = true;
      };
      pkgs-lv_img_conv = nixpkgs-lv_img_conv.legacyPackages.x86_64-linux;
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
            pkgs-lv_img_conv.lv_img_conv
            cmake
            openocd
            segger-jlink
            nrf-command-line-tools
            mynewt-newt
            nrf5-sdk
            clang-tools
            python3Packages.adafruit-nrfutil
            itd
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
