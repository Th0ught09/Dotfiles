{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kirkm";
  home.homeDirectory = "/home/kirkm";
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
		rustlings
		starship
    pinentry
    mu
    rofi
    porsmo
    pavucontrol
    ncspot
    tldr
    unzip
    cheat
    onefetch
    
    # Hardware
    pciutils
    usbutils
    lm_sensors # For cpu monitoring?
    htop

    # File Manipulation
    ranger
    zip
    bat
    zathura
    stow
    pandoc

    # Term Repls
    gnuplot
    bc
    gawk

    # Tracking
    hyperfine

    # Term Navigation
    fd
    tree

    # Music
    cmus

    # Build tools
    gnumake
    ninja
    maven

    # OS essentials
    ps_mem
		speedtest-cli
		wget
    pinentry-all # For pass
    pass

    # Languages
    shellcheck
    nodejs_23
    rustup
    php
    gcc
    texliveFull
    ghc
    R
    lua
    luaformatter
    luaPackages.ldoc
    zulu17
    go

    ## Servers
    lua-language-server
    haskell-language-server

    ## Haskell
    cabal-install
    haskellPackages.hoogle

    ## Python
    python312Packages.pip
    python312Packages.gitpython
    python312Packages.bpython
    python312Packages.pyflakes
    isort

    # Apps
    anki
    godot_4
    whatsapp-for-linux
    libreoffice-qt
    oh-my-git
    gtypist
    spotify
    discord
    protonmail-desktop
    _1password-gui
    obsidian
    flameshot

    # Photography
    gphoto2
    gimp
    darktable

    # Shell
    zoxide
    eza
    oh-my-zsh
    ripgrep
    inputs.nixpkgs.legacyPackages.${pkgs.system}.fzf
    
    # Editor
    jetbrains.pycharm-professional
    jetbrains.phpstorm
    jetbrains.datagrip
    jetbrains.idea-ultimate
    jetbrains-toolbox
    vim
    neovim
    jupyter-all
    gdb

    # Term
    alacritty
    tmux

    # Dev Tools
		conda
    git
    ctags
    docker
    docker-compose
    podman
    distrobox
    cmake
    strace

    # LLM
    inputs.nixpkgs.legacyPackages.${pkgs.system}.ollama-rocm
    
    # Networking
    cacert
    msmtp
    nmap
    openssh
    nginx
    inetutils
    openssl
    protonmail-bridge
    protonmail-bridge-gui
    isync
    mtpfs

    # OS
    dust
    dict
    ispell
    libtool
    time
    xsel
    mesa-demos
    mesa
    pkg-config
    nix-ld
    awesome

    # Misc
    screenkey
    xorg.xev
    xorg.xmodmap
    kanata
    steam-tui
    vimgolf
    steamcmd
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
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
    epkgs.nix-mode
    epkgs.magit
    epkgs.mu4e
    epkgs.doom
    epkgs.org-caldav
    epkgs.pdf-tools
    ];
  };
}
