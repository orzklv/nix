{
  lib,
  config,
  ...
}: let
  apps = lib.mkIf config.homebrew.enable {
    "Affinity Publisher 2" = 1606941598;
    "GarageBand" = 682658836;
    "JSONPeep" = 1458969831;
    "Playgrounds" = 1496833156;
    "Image2icon" = 992115977;
    "Xcode" = 497799835;
    "OctoLinker" = 1549308269;
    "HextEdit" = 1557247094;
    "Transporter" = 1450874784;
    "Apple Configurator" = 1037126344;
    "Affinity Designer 2" = 1616831348;
    "ServerCat" = 1501532023;
    "Classroom" = 1358883623;
    "RunCat" = 1429033973;
    "Affinity Photo 2" = 1616822987;
    "TestFlight" = 899247664;
    "Pages" = 409201541;
    "Telegram" = 747648890;
    "Developer" = 640199958;
    "AdGuard for Safari" = 1440147259;
    "Wappalyzer - Technology profiler" = 1520333300;
    "PiPer" = 1421915518;
    "Refined GitHub" = 1519867270;
    "iMovie" = 408981434;
    "Numbers" = 409203825;
    "ColorSlurp" = 1287239339;
    "Keynote" = 409183694;
    "Hotspot Shield" = 771076721;
    "Shazam" = 897118787;
  };
in {
  # AppStore installations
  homebrew.masApps = apps;
}
