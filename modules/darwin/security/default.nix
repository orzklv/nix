{ ... }:
{
  # Fingerprint sudo
  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
    watchIdAuth = true;
  };
}
