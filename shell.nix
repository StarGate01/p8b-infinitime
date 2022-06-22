{ pkgs ? import <nixpkgs> { }, pkgs-fork-lv_font_conv ? import <nixpkgs-fork-lv_font_conv> { } }:
with pkgs;

mkShell {
  buildInputs = [
    gcc-arm-embedded
    cmake
    pkgs-fork-lv_font_conv.nodePackages.lv_font_conv
    python3
  ];
}
