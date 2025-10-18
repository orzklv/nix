{
  pkgs ? let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs-unstable.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
    import nixpkgs {overlays = [];},
  ...
}:
pkgs.stdenv.mkDerivation {
  name = "nix";

  nativeBuildInputs = with pkgs; let
    linter = statix.overrideAttrs (old: rec {
      src = fetchFromGitHub {
        owner = "oppiliappan";
        repo = "statix";
        rev = "8eefaec2e74ff54f6eb541aaeb80aa352ecae884";
        sha256 = "sha256-duH6Il124g+CdYX+HCqOGnpJxyxOCgWYcrcK0CBnA2M=";
      };
      cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
        inherit src;
        hash = "sha256-IeVGsrTXqmXbKRbJlBDv02fJ+rPRjwuF354/jZKRK/M=";
      };
    });
  in [
    git
    just
    nixd
    sops
    linter

    deadnix
    alejandra
  ];

  shellHook = ''
    # Fetch whatever update
    git pull
  '';

  NIX_CONFIG = "extra-experimental-features = nix-command flakes pipe-operators";
}
