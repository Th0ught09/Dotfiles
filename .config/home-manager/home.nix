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

        # File Manipulation
        poppler_utils # Displaying pdfs
        ranger
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
        tmux

        # Dev Tools
        file
        gnumake
        git
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
        acpi
        unetbootin

    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
        # # Building this configuration will create a copy of 'dotfiles/screenrc' in
        # # the Nix store. Activating the configuration will then make '~/.screenrc' a
        # # symlink to the Nix store copy.
        # ".screenrc".source = dotfiles/screenrc;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/kirkm/etc/profile.d/hm-session-vars.sh
    #
    home.sessionVariables = {
        EDITOR = "nvim";
        SHELL = "zsh";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # programs.emacs = {
    # enable = true;
    #     extraPackages = epkgs: [
    #     epkgs.nix-mode
    #     epkgs.magit
    #     epkgs.mu4e
    #     epkgs.doom
    #     epkgs.org-caldav
    #     epkgs.pdf-tools
    #     ];
    # };
}
