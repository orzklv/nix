{
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation {
  pname = "hyperfluent-grub-theme";
  version = "1.0.1";
  src = fetchFromGitHub {
    owner = "Coopydood";
    repo = "HyperFluent-GRUB-Theme";
    rev = "v1.0.1";
    hash = "sha256-zryQsvue+YKGV681Uy6GqnDMxGUAEfmSJEKCoIuu2z8=";
  };
  installPhase = "cp -r $src/nixos $out";
}
