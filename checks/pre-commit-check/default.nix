{
  # You also have access to your flake's inputs.
  inputs,

  # All other arguments come from NixPkgs. You can use `pkgs` to pull checks or helpers
  # programmatically or you may add the named attributes as arguments here.
  pkgs,
  ...
}:

# Create your check
inputs.pre-commit-hooks.lib.${pkgs.stdenv.hostPlatform.system}.run {
  src = ./.;
  hooks = {
    statix = {
      enable = true;
      package = pkgs.statix.overrideAttrs (_o: rec {
        src = pkgs.fetchFromGitHub {
          owner = "oppiliappan";
          repo = "statix";
          rev = "e9df54ce918457f151d2e71993edeca1a7af0132";
          hash = "sha256-duH6Il124g+CdYX+HCqOGnpJxyxOCgWYcrcK0CBnA2M=";
        };

        cargoDeps = pkgs.rustPlatform.importCargoLock {
          lockFile = src + "/Cargo.lock";
          allowBuiltinFetchGit = true;
        };
      });
    };
    nixfmt.enable = true;
  };
}
