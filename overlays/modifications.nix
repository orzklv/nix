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
}
