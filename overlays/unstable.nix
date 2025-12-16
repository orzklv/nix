# When applied, the unstable nixpkgs set (declared in the flake inputs) will
# be accessible through 'pkgs.unstable'
{inputs, ...}: final: _prev: {
  unstable = import inputs.nixpkgs-unstable {
    inherit (final.stdenv.hostPlatform) system;
    config.allowUnfree = true;
  };
}
