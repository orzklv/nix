# Use this as a playground to test nix expressions
# export NIXPKGS_ALLOW_UNFREE=1 && nix repl -f ./repl.nix --impure
{
  pkgs ? let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
    import nixpkgs {overlays = [];},
  ...
}: let
  mkArrIf = condition: content:
    if condition
    then content
    else [];

  # Packages that are not aarch64 compatible
  aarch64-packages =
    mkArrIf
    pkgs.stdenv.hostPlatform.isAarch64
    [
      pkgs.discord
    ];

  packages =
    # Stable packages
    (with pkgs; [
      telegram-desktop
    ])
    # Unstable packages
    ++ (with pkgs.unstable; [])
    # Aarch64 only packages
    ++ aarch64-packages;
in {
  inherit packages;
}
