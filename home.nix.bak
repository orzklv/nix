{ pkgs, ... }: {
  # This is required information for home-manager to do its job
  home = {
    stateVersion = "23.11";
    username = "sakhib";
    homeDirectory = "/Users/sakhib";

    # Tell it to map everything in the `config` directory in this
    # repository to the `.config` in my home directory
    file.".config" = { source = ./config; recursive = true; };

    # Packages to be installed on my machine
    packages = [
      # Downloader
      pkgs.aria

      # Linguistics
      pkgs.aspell
      pkgs.hunspell
      pkgs.ispell

      # Developer Mode
      pkgs.automake
      pkgs.autoconf
      pkgs.cargo-update
      pkgs.clang-tools
      pkgs.cmake
      pkgs.cocoapods
      pkgs.gcc
      pkgs.gh
      pkgs.git-lfs
      pkgs.gitoxide
      pkgs.gitui
      pkgs.libgccjit
      pkgs.libheif
      pkgs.llvm
      pkgs.just
      pkgs.gnumake
      pkgs.mdbook
      pkgs.pcre
      pkgs.shfmt
      pkgs.wget

      # Environment
      pkgs.bat
      pkgs.btop
      pkgs.cowsay
      pkgs.eza
      pkgs.fd
      pkgs.figlet
      pkgs.gping
      pkgs.hyperfine
      pkgs.lolcat
      pkgs.neofetch
      pkgs.onefetch
      pkgs.pfetch
      pkgs.procs
      pkgs.ripgrep
      pkgs.tealdeer
      pkgs.tmux
      pkgs.topgrade

      # Tech
      pkgs.deno
      pkgs.go
      pkgs.jdk
      pkgs.bun
      pkgs.poetry
      pkgs.python3
      pkgs.rustup
      pkgs.volta
      pkgs.zig

      # Media encode & decode
      pkgs.ffmpeg

      # GPG Signing
      pkgs.gnupg
      pkgs.pinentry_mac
    ];
  };

  # This is to ensure programs are using ~/.config rather than
  # /Users/sakhib/Library/whatever
  xdg.enable = true;

  # Let's enable home-manager
  programs.home-manager.enable = true;


  # Zpxide path integration
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Setup pinentry for mac
  home.file.".gnupg/gpg-agent.conf".text = ''
    pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
  '';

  # I use zsh, but bash and fish work just as well here. This will setup
  # the shell to use home-manager properly on startup, neat!
  programs.zsh = {
    enable = true;

    # ZSH Autosuggestions
    enableAutosuggestions = true;

    # ZSH Completions
    enableCompletion = true;

    # ZSH Syntax Highlighting
    syntaxHighlighting.enable = true;

    shellAliases = {
      # General aliases
      down = "cd ~/Downloads";
      ".." = "cd ..";
      "...." = "cd ../..";
      "celar" = "clear";
      ":q" = "exit";
      ssh-hosts = "grep -P \"^Host ([^*]+)$\" $HOME/.ssh/config | sed 's/Host //'";

      # Made with Rust
      top = "btop";
      cat = "bat";
      ls = "exa";
      sl = "exa";
      ps = "procs";
      grep = "rg";
      search = "rg";
      look = "fd";
      find = "fd";
      ping = "gping";
      time = "hyperfine";
      j = "just";
      make = "just";
      korgi = "cargo";

      # Refresh
      refresh = "sudo nixos-rebuild switch";

      # Vim
      vi = "hx";
      vim = "hx";

      # Others (Developer)
      ports = "sudo lsof -PiTCP -sTCP:LISTEN";
      rit = "gitui";
      # open = "xdg-open";
      xclip = "xclip -selection c";
      speedtest = "curl -o /dev/null cachefly.cachefly.net/100mb.test";

      # Updating system
      update = "sudo nixos-rebuild switch --upgrade";
      update-home="home-manager switch --flake ~/Developer/orzklv/nix";

      # Editing configurations
      config = "sudo hx /etc/nixos/configuration.nix";
      hard-config = "sudo hx /etc/nixos/hardware-configuration.nix";
      home-config = "sudo hx /etc/nixos/home-configuration.nix";
    };

    # Extra manually typed configs
    initExtra = ''
      # Global settings
      setopt AUTO_CD
      setopt BEEP
      setopt HIST_BEEP
      setopt HIST_EXPIRE_DUPS_FIRST
      setopt HIST_FIND_NO_DUPS
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_IGNORE_DUPS
      setopt HIST_REDUCE_BLANKS
      setopt HIST_SAVE_NO_DUPS
      setopt HIST_VERIFY
      setopt INC_APPEND_HISTORY
      setopt INTERACTIVE_COMMENTS
      setopt MAGIC_EQUAL_SUBST
      setopt NO_NO_MATCH
      setopt NOTIFY
      setopt NUMERIC_GLOB_SORT
      setopt PROMPT_SUBST
      setopt SHARE_HISTORY

      # Key bindings
      bindkey -e
      bindkey '^U' backward-kill-line
      bindkey '^[[2~' overwrite-mode
      bindkey '^[[3~' delete-char
      bindkey '^[[H' beginning-of-line
      bindkey '^[[1~' beginning-of-line
      bindkey '^[[F' end-of-line
      bindkey '^[[4~' end-of-line
      bindkey '^[[1;5C' forward-word
      bindkey '^[[1;5D' backward-word
      bindkey '^[[3;5~' kill-word
      bindkey '^[[5~' beginning-of-buffer-or-history
      bindkey '^[[6~' end-of-buffer-or-history
      bindkey '^[[Z' undo
      bindkey ' ' magic-space

      # History files
      HISTFILE=~/.zsh_history
      HIST_STAMPS=mm/dd/yyyy
      HISTSIZE=5000
      SAVEHIST=5000
      ZLE_RPROMPT_INDENT=0
      WORDCHARS=''${WORDCHARS//\/}
      PROMPT_EOL_MARK=
      TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

      # Zsh Autosuggestions Configs
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'

      # Zsh Completions Configs
      zstyle ':completion:*:*:*:*:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' auto-description 'specify: %d'
      zstyle ':completion:*' completer _expand _complete
      zstyle ':completion:*' format 'Completing %d'
      zstyle ':completion:*' group-name ' '
      zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
      zstyle ':completion:*' use-compctl false
      zstyle ':completion:*' verbose true
      zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
      typeset -gA ZSH_HIGHLIGHT_STYLES
      ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
      ZSH_HIGHLIGHT_STYLES[default]=none
      ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=white,underline
      ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
      ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
      ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
      ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
      ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
      ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
      ZSH_HIGHLIGHT_STYLES[path]=bold
      ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
      ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
      ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
      ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
      ZSH_HIGHLIGHT_STYLES[command-substitution]=none
      ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
      ZSH_HIGHLIGHT_STYLES[process-substitution]=none
      ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
      ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
      ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
      ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
      ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
      ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
      ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
      ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
      ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
      ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
      ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
      ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
      ZSH_HIGHLIGHT_STYLES[assign]=none
      ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
      ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
      ZSH_HIGHLIGHT_STYLES[named-fd]=none
      ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
      ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
      ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
      ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
      ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
      ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
      ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
      ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
      ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.helix = {
    enable = true;

    settings = {
      theme = "autumn_night";

      editor = {
        line-number = "relative";

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };


        file-picker = {
          hidden = false;
        };

        statusline = {
          left = [ "mode" "spinner" ];

          center = [ "file-name" ];

          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];

          separator = "│";

          mode = {
            normal = "SLAVE";
            insert = "MASTER";
            select = "DUNGEON";
          };
        };

      };

      keys.normal = {
        # Easy window movement
        "C-left" = "jump_view_left";
        "C-right" = "jump_view_right";
        "C-up" = "jump_view_up";
        "C-down" = "jump_view_down";

        "C-h" = "jump_view_left";
        "C-j" = "jump_view_down";
        "C-k" = "jump_view_up";
        "C-l" = "jump_view_right";

        "C-r" = ":reload";
      };
    };
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

    # User credentials
    userName = "Sokhibjon Orzikulov";
    userEmail = "sakhib@orzklv.uz";

    extraConfig = {
      http.sslVerify = false;
    };

    # GPG Signing
    signing = {
      signByDefault = true;
      key = "00D27BC687070683FBB9137C3C35D3AF0DA1D6A8";
    };

    # Aliases
    aliases = {
      ch = "checkout";
    };

    # Git ignores
    ignores = [
      ".idea"
      ".DS_Store"
    ];
  };
}