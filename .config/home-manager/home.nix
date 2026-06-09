{ config, pkgs, inputs, ... }:

with pkgs;
let
    R-with-my-packages = rWrapper.override{ packages = with rPackages; [ ggplot2 dplyr xts onsr rmarkdown knitr lmtest data_table]; };
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
        hexyl
        yank
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
        calibre # book format
        feh # display image
        imagemagick
        ripgrep-all
        poppler-utils # Displaying pdfs
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
        clang-tools
        texliveFull
        zulu17
        go

        # R
        R-with-my-packages

        ## Rust
        evcxr
        rustlings
        prek # rust pre-commit
        gccgo # for rust pre-commit
        rust-analyzer
        cargo
        rustfmt
        bacon
        rusty-man
        clippy
        rustc # debugging?

        ## Python
        python313Packages.debugpy
        python313Packages.ipykernel
        virtualenv
        uv

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
        glibc

        # work tools
        mermaid-cli
        kdePackages.wacomtablet
        pdftowrite
        styluslabs-write # writing using pen

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
        kdePackages.kdenlive

        # Photography
        gphoto2
        gimp3
        darktable

        # Shell
        nushell
        eza
        oh-my-zsh
        zsh
        fish
        ripgrep
        inputs.nixpkgs.legacyPackages.${pkgs.system}.fzf

        # nix
        nixpkgs-review
        nix-ld
        nix-index

        # Editor
        vim
        neovim
        jupyter-all
        jetbrains.pycharm
        jetbrains.idea

        # web dev
        phpunit # unit testing
        php
        nginx

        # Games
        godot
        exercism
        speedread
        kaggle # data science
        slipstream # ftl mod manager
        oh-my-git
        lazygit
        vimgolf

        # Term
        alacritty
        ghostty
        tmux
        mprocs # Watch a bunch of processes

        # Dev Tools
        jqp
        pre-commit
        nasm # assembly stuff
        tokei
        fselect
        file
        gnumake
        git
        gh
        just
        delta
        ctags
        docker
        docker-compose
        podman
        distrobox
        cmake

        # Networking
        transmission_4 # bittorrent
        openvpn # connect to home pc
        gnome-keyring # protonmail bridge
        protonvpn-gui # vpn
        wget
        speedtest-cli
        psmisc
        cifs-utils
        cacert
        nmap
        openssh
        inetutils
        openssl
        protonmail-bridge
        protonmail-bridge-gui

        # OS
        acpi # battery
        unetbootin # create live bootable drive
        systemctl-tui # system stuff via tui
        zenity # notification daemon
        xclip # system copying
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

        # file viewing
        presenterm
        delta
        jq

        # WM
        awesome
        i3lock-color
        ly
        xbanish
        gromit-mpx
        screenkey

        # media
        castero # podcasts
        wikit # wikipedia
        comaps # maps
        yt-dlp # video/audio downloader
        youtube-tui # social
        whatsapp-electron
        wike

        # Misc
        # slop # depedency?
        # arc-icon-theme # dep?
        # libtool # dependency?

        # latex packages
        texlivePackages.smartdiagram
        texlivePackages.enumitem
        texlivePackages.ragged2e
        texlivePackages.geometry
        texlivePackages.fancyhdr
        texlivePackages.xcolor
        texlivePackages.xifthen
        texlivePackages.etoolbox
        texlivePackages.setspace
        texlivePackages.unicode-math
        texlivePackages.parskip

    ];

    home.file = {
    };

    home.sessionVariables = {
        EDITOR = "emacsclient -c -a emacs";
        SHELL = "fish";
        PATH = "$PATH:/home/kirkm/cargo/bin";
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
        "inode/directory"="nautilus.desktop";
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
