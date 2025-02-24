# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{pkgs ? import <nixpkgs> {}}: rec {
  # Personal scripts
  force-push = pkgs.callPackage ./force-push {};
  dev-clean = pkgs.callPackage ./dev-clean {};
  org-location = pkgs.callPackage ./org-location {};
  google = pkgs.callPackage ./google {};
  krisp-patcher = pkgs.callPackage ./krisp-patcher {};
  krisper = pkgs.callPackage ./krisper {};
}
