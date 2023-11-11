# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs ? import <nixpkgs> { } }: rec {
  # Personal scripts
  devcc = pkgs.callPackage ./devcc { };
  google = pkgs.callPackage ./google { };
  ghloc = pkgs.callPackage ./ghloc { };
  fp = pkgs.callPackage ./fp { };
}
