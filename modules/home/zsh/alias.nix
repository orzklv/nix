{
  pkgs,
  lib,
  ...
}: let
  determinate-systems = "${lib.getExe pkgs.curl} --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix";

  is-mac =
    pkgs.stdenv.hostPlatform.system
    == "aarch64-darwin"
    || pkgs.stdenv.hostPlatform.system
    == "x86_64-darwin";

  mac = lib.mkIf is-mac {
    # Refresh
    clean = "${lib.getExe pkgs.nix} store gc";
  };

  linux = lib.mkIf (!is-mac) {
    # Refresh
    clean = "${lib.getExe pkgs.nix} store gc && ${lib.getExe pkgs.nix} collect-garbage -d";
  };

  default = rec {
    # General aliases
    down = "cd ~/Downloads";
    ".." = "cd ..";
    "...." = "cd ../..";
    "celar" = "clear";
    ":q" = "exit";
    neofetch = fetch;
    ssh-hosts = "${grep} -P \"^Host ([^*]+)$\" $HOME/.ssh/config | ${lib.getExe pkgs.gnused} 's/Host //'";

    # Polite motherfucker!
    # Do you speak it?!
    please = "sudo";
    move = "mv";
    copy = "cp";
    remove = "rm";
    list = ls;
    edit = vim;
    fetch = "${lib.getExe pkgs.fastfetch}";

    # Made with Rust
    top = "${lib.getExe pkgs.btop}";
    cat = "${lib.getExe pkgs.bat}";
    ls = "${lib.getExe pkgs.eza}";
    sl = ls;
    ps = "${lib.getExe pkgs.procs}";
    grep = "${lib.getExe pkgs.ripgrep}";
    search = "${lib.getExe pkgs.ripgrep}";
    look = "${lib.getExe pkgs.fd}";
    find = "${lib.getExe pkgs.fd}";
    ping = "${lib.getExe pkgs.gping}";
    time = "${lib.getExe pkgs.hyperfine}";
    korgi = "cargo";

    # Refresh
    refresh = "source ~/.zshrc";

    # Development
    vi = "${lib.getExe pkgs.helix}";
    vim = vi;
    zed = "${lib.getExe pkgs.zed-editor}";
    heck = "zed .";
    hack = "${lib.getExe pkgs.nix} develop -c $SHELL";

    # Others (Developer)
    ports = "sudo ${lib.getExe pkgs.lsof} -PiTCP -sTCP:LISTEN";
    youtube-video = ''${lib.getExe pkgs.yt-dlp} -f bestvideo+bestaudio/best -S vcodec:h264,res,acodec:m4a --add-metadata -o "%(title)s.%(ext)s" --embed-chapters'';
    youtube-music = ''${lib.getExe pkgs.yt-dlp} -f ba[ext=m4a] --add-metadata -o "%(title)s.%(ext)s"'';
    dotenv = "eval export $(cat .env)";
    xclip = "${lib.getExe pkgs.xclip} -selection c";
    speedtest = "${lib.getExe pkgs.curl} -o /dev/null cachefly.cachefly.net/100mb.test";

    # Updating system
    update = "${lib.getExe pkgs.topgrade}";
    nix-develop = "${lib.getExe pkgs.nix} develop -c \"$SHELL\"";
    determinate = "${determinate-systems} | sh -s -- ";
    repair = "${determinate-systems} | sh -s -- repair";
  };

  cfg = lib.mkMerge [
    mac
    linux
    default
  ];
in {
  config = {
    programs.zsh.shellAliases = cfg;
  };
}
