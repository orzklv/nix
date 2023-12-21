# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{pkgs ? import <nixpkgs> {}}: rec {
  # Personal scripts
  fp = pkgs.callPackage ./fp {};
  devcc = pkgs.callPackage ./devcc {};
  ghloc = pkgs.callPackage ./ghloc {};
  google = pkgs.callPackage ./google {};
  brewster = pkgs.callPackage ./brewster {};
}
