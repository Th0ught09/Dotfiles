{ config, pkgs, inputs, ... }:

with pkgs;
let
    R-with-my-packages = rWrapper.override{ packages = with rPackages; [ ggplot2 dplyr xts onsr rmarkdown knitr]; };
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
        thefuck                     # Aliased to mb
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
        poppler_utils # Displaying pdfs
        ranger
        yazi
        zip
        unzip
        bat
        zathura
        stow
        pandoc

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

        # Languages
        sqlite
        sbcl
        shellcheck
        nodejs_24
        rustup
        php
        gcc
        clang-tools
        texliveFull
        zulu17
        go

        # R
        R-with-my-packages

        ## Rust
        bacon
        rusty-man

        ## Python
        python313Packages.debugpy
        python313Packages.ipykernel
        python312Packages.bpython
        virtualenv
        uv
        inputs.nixpkgs.legacyPackages.${pkgs.system}.streamlit

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

        ## C
        ccls

        # Apps
        libreoffice-qt
        gtypist
        discord
        protonmail-desktop
        _1password-gui
        flameshot

        # Video
        shotcut
        obs-studio

        # Photography
        gphoto2
        gimp3
        blender
        darktable

        # Chess
        chess-tui
        gnuchess
        stockfish
        scid

        # Shell
        nushell
        eza
        oh-my-zsh
        zsh
        fish
        ripgrep
        inputs.nixpkgs.legacyPackages.${pkgs.system}.fzf

        # Editor
        jetbrains.pycharm-professional
        vim
        neovim
        jupyter-all

        # Games
        oh-my-git
        lazygit
        vimgolf

        # Term
        alacritty
        ghostty
        tmux
        mprocs # Watch a bunch of processes

        # Dev Tools
        tokei
        fselect
        file
        gnumake
        git
        delta
        ctags
        docker
        docker-compose
        podman
        distrobox
        cmake

        # Networking
        wget
        speedtest-cli
        psmisc
        cifs-utils
        cacert
        nmap
        openssh
        nginx
        inetutils
        openssl
        protonmail-bridge
        protonmail-bridge-gui

        # OS
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
        nix-ld

        # WM
        awesome
        i3lock-color
        ly
        xbanish
        gromit-mpx
        screenkey

        # Misc
        slop
        wacomtablet
        mermaid-cli
        evince # touchscreen pdf
        graphviz # for plantuml
        plantuml # understanding python files
        jqp
        presenterm
        wiki-tui
        acpi
        unetbootin
        arc-icon-theme
        evcxr
        openblas
        mask
        just
        gh
        jq
        styluslabs-write
        delta
        glibc
        nix-index
        impala
        systemctl-tui
        libtool

    ];

    home.file = {
    };

    home.sessionVariables = {
        EDITOR = "emacsclient -c -a emacs";
        SHELL = "fish";
    };

    xdg.desktopEntries = {
        yazi = {
            name = "Yazi";
            genericName = "File Browser";
            exec = "ghostty -e yazi";
            terminal = false;
            categories = [ "Application" "Network" "WebBrowser" ];
        };
        emacs = {
            name = "emacs";
            genericName = "text editor";
            exec = "emacsclient -c -a emacs";
            terminal = false;
        };
    };
    xdg.mimeApps.defaultApplications = {
        "inode/directory"="yazi.desktop";
        "application/pdf"="zathura.desktop";
    };
    programs.emacs = {
        enable = true;
        extraPackages = epkgs: [
            epkgs.mu4e
            pkgs.rPackages.onsr
        ];
    };

    programs.home-manager.enable = true;

}
