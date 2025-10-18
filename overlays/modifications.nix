# This one contains whatever you want to overlay
# You can change versions, add patches, set compilation flags, anything really.
# https://wiki.nixos.org/wiki/Overlays
{inputs, ...}: _final: prev: {
  # example = prev.example.overrideAttrs (oldAttrs: rec {
  # ...
  # });
  sf-mono-liga = prev.stdenvNoCC.mkDerivation rec {
    pname = "sf-mono-liga";
    version = "dev";
    src = inputs.sf-mono-liga;
    dontConfigure = true;
    installPhase = ''
      mkdir -p $out/share/fonts/opentype
      cp -R $src/*.otf $out/share/fonts/opentype/
    '';
  };

  # statix = prev.statix.overrideAttrs {
  #   version = "dev";
  #   src = prev.fetchFromGitHub {
  #     owner = "nerdypepper";
  #     repo = "statix";
  #     rev = "e9df54ce918457f151d2e71993edeca1a7af0132";
  #     sha256 = "sha256-duH6Il124g+CdYX+HCqOGnpJxyxOCgWYcrcK0CBnA2M=";
  #   };
  #   cargoHash = "sha256-IeVGsrTXqmXbKRbJlBDv02fJ+rPRjwuF354/jZKRK/M=";
  # };
}
