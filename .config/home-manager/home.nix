{ config, pkgs, inputs, ... }:

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
        sbcl
        shellcheck
        nodejs_24
        rustup
        php
        gcc
        clang-tools
        texliveFull
        R
        zulu17
        go

        ## Rust
        bacon
        rusty-man

        ## Python
        python313Packages.debugpy
        python312Packages.bpython
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

        # Apps
        obs-studio
        whatsapp-for-linux
        libreoffice-qt
        gtypist
        discord
        protonmail-desktop
        _1password-gui
        flameshot
        shotcut
        lutris

        # Photography
        gphoto2
        gimp3
        blender
        darktable

        # Chess
        chessx
        chessdb
        chess-tui
        gnuchess
        stockfish

        # Shell
        nushell
        eza
        oh-my-zsh
        zsh
        fish
        ripgrep
        inputs.nixpkgs.legacyPackages.${pkgs.system}.fzf

        # Editor
        emacs
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
        presenterm
        wiki-tui
        acpi
        unetbootin
	evcxr

    ];

    home.file = {
    };

    home.sessionVariables = {
        EDITOR = "nvim";
        SHELL = "fish";
    };

    # programs.fish = {
    #     enable = true;
    # };

    programs.home-manager.enable = true;

}
