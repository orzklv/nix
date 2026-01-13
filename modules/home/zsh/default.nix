{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./alias.nix
    ./prompt.nix
  ];

  # I use zsh, but bash and fish work just as well here. This will setup
  # the shell to use home-manager properly on startup, neat!
  programs.zsh = {
    # Install zsh
    enable = true;

    # ZSH Completions
    enableCompletion = true;

    # History file
    history = {
      size = 5000;
      save = 5000;
    };

    # Extra Features
    setOptions = [
      "AUTO_CD"
      "BEEP"
      "HIST_BEEP"
      "HIST_EXPIRE_DUPS_FIRST"
      "HIST_FIND_NO_DUPS"
      "HIST_IGNORE_ALL_DUPS"
      "HIST_IGNORE_DUPS"
      "HIST_REDUCE_BLANKS"
      "HIST_SAVE_NO_DUPS"
      "HIST_VERIFY"
      "INC_APPEND_HISTORY"
      "INTERACTIVE_COMMENTS"
      "MAGIC_EQUAL_SUBST"
      "NO_NO_MATCH"
      "NOTIFY"
      "NUMERIC_GLOB_SORT"
      "PROMPT_SUBST"
      "SHARE_HISTORY"
    ];

    # ZSH Autosuggestions
    # The option `programs.zsh.enableAutosuggestions' defined in config
    # has been renamed to `programs.zsh.autosuggestion.enable'.
    autosuggestion = {
      enable = true;
      highlight = "fg=gray";
    };

    # ZSH Syntax Highlighting
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "pattern"
      ];
      patterns = {
        "rm -rf *" = "fg=white,bold,bg=red";
      };
      styles = {
        default = "none";
        unknown-token = "fg=gray,underline";
        reserved-word = "fg=cyan,bold";
        suffix-alias = "fg=green,underline";
        global-alias = "fg=green,bold";
        precommand = "fg=green,underline";
        commandseparator = "fg=blue,bold";
        autodirectory = "fg=green,underline";
        path = "bold";
        path_pathseparator = "";
        path_prefix_pathseparator = "";
        globbing = "fg=blue,bold";
        history-expansion = "fg=blue,bold";
        command-substitution = "none";
        command-substitution-delimiter = "fg=magenta,bold";
        process-substitution = "none";
        process-substitution-delimiter = "fg=magenta,bold";
        single-hyphen-option = "fg=green";
        double-hyphen-option = "fg=green";
        back-quoted-argument = "none";
        back-quoted-argument-delimiter = "fg=blue,bold";
        single-quoted-argument = "fg=yellow";
        double-quoted-argument = "fg=yellow";
        dollar-quoted-argument = "fg=yellow";
        rc-quote = "fg=magenta";
        dollar-double-quoted-argument = "fg=magenta,bold";
        back-double-quoted-argument = "fg=magenta,bold";
        back-dollar-quoted-argument = "fg=magenta,bold";
        assign = "none";
        redirection = "fg=blue,bold";
        comment = "fg=black,bold";
        named-fd = "none";
        numeric-fd = "none";
        arg0 = "fg=cyan";
        bracket-error = "fg=red,bold";
        bracket-level-1 = "fg=blue,bold";
        bracket-level-2 = "fg=green,bold";
        bracket-level-3 = "fg=magenta,bold";
        bracket-level-4 = "fg=yellow,bold";
        bracket-level-5 = "fg=cyan,bold";
        cursor-matchingbracket = "standout";
      };
    };

    # External plugins
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];

    # Extra manually typed configs
    initContent = ''
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
      HIST_STAMPS=mm/dd/yyyy
      ZLE_RPROMPT_INDENT=0
      WORDCHARS=''${WORDCHARS//\/}
      PROMPT_EOL_MARK=
      TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

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

      function fixnix {
        sudo rm -rf /etc/zshrc.before-nix-darwin /etc/zprofile.before-nix-darwin
        sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin
        sudo mv /etc/zprofile /etc/zprofile.before-nix-darwin
      }

      # Golang's Trash
      export GOPATH="$HOME/.go"

      ${lib.optionalString pkgs.stdenv.hostPlatform.isLinux ''
        # Golang's Trash
        export GOPATH="$HOME/.go"

        # Rustup for globals
        export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
      ''}

      ${lib.optionalString pkgs.stdenv.hostPlatform.isDarwin ''
        # Rustup for globals
        # export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
        # export PATH="/Users/sakhib/.cargo/bin:$PATH"
      ''}
    '';
  };
}
