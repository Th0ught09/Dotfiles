{ config, pkgs, inputs, ... }:
with pkgs;
let
  R-with-my-packages = rWrapper.override{ packages = with rPackages; [ ggplot2 dplyr xts ]; };
in
{
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "kirkm";
    home.homeDirectory = "/home/kirkm";
    home.enableNixpkgsReleaseCheck = false;
    nixpkgs.config.allowUnfree = true;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [

        # Term QOL
        tmux
        thefuck  # Aliased to mb
        hexyl
        yank
        rustlings
        starship
        rofi
        tldr
        cheat
        onefetch
        iosevka

        # Mail
        msmtp   # Unsure
        mu      # Create email database
        isync   # Sync with Email
        mtpfs

        # Hardware
        amdgpu_top
        stress
        pciutils
        usbutils
        lm_sensors # For cpu monitoring?
        htop
        pavucontrol
        dust

        # File Manipulation
        ripgrep-all
        yazi
        zip
        unzip
        stow
        inputs.nixpkgs.legacyPackages.${pkgs.system}.pandoc

        # file rendering
        delta       # Compare files
        zathura
        bat
        presenterm
        poppler_utils # Displaying pdfs

        # Security
        pinentry-all # For pass
        pass

        # Term Repls
        gdb
        gnuplot
        bc
        gawk

        # Tracking
        strace
        hyperfine

        # Term Navigation
        zoxide
        fd
        tree

        # Music
        pulseaudioFull
        alsa-utils
        alsa-oss
        audacity
        mpv
        vlc
        soulseekqt

        # Languages
        sqlite
        mariadb 
        sbcl # rust
        shellcheck
        nodejs_24
        rustup
        php
        gcc
        clang-tools
        texliveFull
        R-with-my-packages
        jdk21
        go

        # C#
        ilspycmd
        # dotnet-sdk
        # inputs.nixpkgs.legacyPackages.${pkgs.system}.msbuild

        ## Json
        jq
        jqp

        ## Rust
        bacon
        rusty-man
        rust-script

        ## Python
        python313Packages.debugpy
        python312Packages.bpython
        virtualenv
        uv
        streamlit

        ## Lua
        lua
        lua-language-server
        lua52Packages.busted
        lua52Packages.nlua
        luaformatter

        ## Haskell
        haskell-language-server
        ghc
        stack
        cabal-install
        haskellPackages.hspec
        haskellPackages.haskell-dap
        haskellPackages.ghci-dap
        haskellPackages.haskell-debug-adapter
        haskellPackages.hoogle

        # Apps
        obs-studio # Recording
        libreoffice-qt
        gtypist # Typing help
        discord
        protonmail-desktop
        _1password-gui
        _1password-cli
        flameshot
        shotcut # Video Editing

        # internet
        wiki-tui
        impala

        # tuis
        discordo

        # Photography
        gphoto2 # Get photos from camera
        gimp3 # Photoshop
        darktable # More detailed photoshop

        # Chess
        chessx
        chessdb
        chess-tui
        gnuchess
        stockfish

        # Shell
        nushell     # Parsing Data
        eza         # Better ls
        oh-my-zsh   # BC
        zsh         # BC
        fish        # Modern Shell
        ripgrep     # Faster Grep
        inputs.nixpkgs.legacyPackages.${pkgs.system}.fzf

        # Editor
        vim         # NeoVim is broken
        inputs.nixpkgs.legacyPackages.${pkgs.system}.neovim
        jupyter-all # Data Science
        emacsPackages.mu4e
        jetbrains.idea-ultimate # Java Errors
        jetbrains.rider # Java Errors
        jetbrains.pycharm-professional #  Java Errors

        # Games
        vimgolf     # Vim Practice

        # Term
        alacritty   # Main Terminal
        ghostty     # Image Rendering
        mprocs      # Watch a bunch of processes

        # git
        git
        oh-my-git
        lazygit
        gh

        # Dev Tools
        just        # better make
        tokei       # View directory info
        fselect     # Query files using sql
        file        # View file type
        gnumake     # Makefiles
        ctags       # Tag File
        docker      # Docker
        docker-compose # TODO
        podman      # Container Stuff
        distrobox   # Emulate Other distros
        cmake       # Making Makefiles

        # Networking
        trippy          # monitoring tool
        wget            # Query Internet
        speedtest-cli   # Test Speed
        psmisc
        cifs-utils
        cacert
        nmap            # Query Network
        openssh         # SSH
        nginx           # (Needed?)
        inetutils
        openssl # rust packages
        protonmail-bridge # Mail Server
        protonmail-bridge-gui # GUI

        # OS
        systemctl-tui
        ps_mem
        sysbench
        stress-ng
        fastfetch
        clinfo
        mesa
        picom
        dust
        dict
        ispell
        time # Manually link
        xsel

        # nix
        nix-ld
        nix-index

        # WM
        awesome
        i3lock-color
        ly
        xbanish
        gromit-mpx
        screenkey

        # libs
        libtool
        pkg-config

        # Misc
        taskjuggler # task management
        bison # lfs
        harfbuzz # text shaping?
        opencv # for nix index?
        cairo # 2D graphics
        pango # rendering
        manim # 3b1b
        calibre # converting
        kdePackages.kdenlive
        nixpkgs-review
        godot
        roslyn-ls
        xorg.transset # transparent
        inkscape
        pandoc-lua-filters
        librsvg # cairo for pdf
        texlivePackages.utf8add
        texlivePackages.media9
        icu # markdown
        gosmore # maps
        r2modman
        xcolor
        graphviz
        beep
        mermaid-cli
        acpi
        unetbootin
        evcxr
        rpi-imager
        wasistlos
        mangohud # fps

    ];

    home.file = {
    };

    home.sessionVariables = {
        EDITOR = "emacsclient -c";
        SHELL = "zsh";
        PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    };

    programs.fish = {
        interactiveShellInit = ''
        set fish_greeting # Disable greeting
        starship init fish | source
        '';
        plugins = [
            {
                name = "plugin-git";
                src = pkgs.fishPlugins.plugin-git.src;
            }
            {
                name = "transient-fish";
                src = pkgs.fishPlugins.transient-fish;
            }
        ];
    };
    programs.emacs = {
        enable = true;
        extraPackages = epkgs: [
            epkgs.mu4e
        ];
    };

    xdg = {
        desktopEntries = {
            emacs = {
                name = "emacs client";
                genericName = "text editor";
                exec = "emacsclient -c";
                terminal = false;
            };
        };
    };

    programs.home-manager.enable = true;

}
