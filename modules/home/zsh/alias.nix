{
  pkgs,
  lib,
  ...
}:
let
  determinate-systems = "${lib.getExe pkgs.curl} --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix";

  mac = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    # Refresh
    clean = "${lib.getExe pkgs.nix} store gc";
  };

  linux = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
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
    list = ls;
    edit = vim;
    please = "sudo";
    fetch = "${lib.getExe pkgs.fastfetch}";
    move = "${lib.getExe' pkgs.uutils-coreutils-noprefix "mv"}";
    copy = "${lib.getExe' pkgs.uutils-coreutils-noprefix "cp"}";
    remove = "${lib.getExe' pkgs.uutils-coreutils-noprefix "rm"}";

    # Made with Rust
    sl = ls;
    ls = "${lib.getExe pkgs.eza}";
    top = "${lib.getExe pkgs.btop}";
    cat = "${lib.getExe pkgs.bat}";
    ps = "${lib.getExe pkgs.procs}";
    grep = "${lib.getExe pkgs.ripgrep}";
    search = "${lib.getExe pkgs.ripgrep}";
    look = "${lib.getExe pkgs.fd}";
    find = "${lib.getExe pkgs.fd}";
    ping = "${lib.getExe pkgs.gping}";
    time = "${lib.getExe pkgs.hyperfine}";

    # Relies on executables on PATH
    korgi = "cargo";

    # Refresh
    refresh = "source ~/.zshrc";

    # Development
    vim = vi;
    vi = "${lib.getExe pkgs.helix}";
    zed = "${lib.getExe pkgs.zed-editor}";
    heck = "${lib.getExe pkgs.zed-editor} .";
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
in
{
  config = {
    programs.zsh.shellAliases = lib.mkMerge [
      mac
      linux
      default
    ];
  };
}
