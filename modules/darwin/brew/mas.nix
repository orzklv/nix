{
  lib,
  config,
  ...
}:
{
  # AppStore installations
  homebrew.masApps = lib.optionals config.homebrew.enable {
    "GarageBand" = 682658836;
    "JSONPeep" = 1458969831;
    "Image2icon" = 992115977;
    "Xcode" = 497799835;
    "OctoLinker" = 1549308269;
    "Transporter" = 1450874784;
    "Apple Configurator" = 1037126344;
    "ServerCat" = 1501532023;
    "RunCat" = 1429033973;
    "TestFlight" = 899247664;
    "Pages" = 409201541;
    "Telegram" = 747648890;
    "Developer" = 640199958;
    "Wappalyzer - Technology profiler" = 1520333300;
    "Refined GitHub" = 1519867270;
    "iMovie" = 408981434;
    "Numbers" = 409203825;
    "Keynote" = 409183694;
  };
}
