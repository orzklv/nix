{pkgs, ...}: {
  # Setup pinentry for linux
  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program ${pkgs.kwalletcli}/bin/pinentry-kwallet
  '';
}
