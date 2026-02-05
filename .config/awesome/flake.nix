{
    description = "Awesome Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = { self, nixpkgs }@inputs:
    let
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
        devShells."x86_64-linux".default = pkgs.mkShell {
            packages = with pkgs; [
                    gnumake
                    cmake
                    imagemagick
                    lua53Packages.lua
                    lua53Packages.ldoc
                    lua53Packages.lgi
                    pkg-config
                    glib
                    cairo
                    gdk-pixbuf
                    libstartup_notification
                    xcbutilxrm
                    xcb-util-cursor
                    xorg.xcbutil
                    xorg.xcbutilkeysyms
                    xorg.xcbutilwm
                    libxdg_basedir
                    libxkbcommon
                ];
        };
    };
}
