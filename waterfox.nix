{ pkgs, stdenv, nixpkgs, lib, ... }@attrs:

stdenv.mkDerivation rec {
  name = "waterfox-${version}";

  version = "G4.0.6";

  src = pkgs.fetchurl {
    url = "https://github.com/WaterfoxCo/Waterfox/releases/download/${version}/waterfox-${version}.en-US.linux-x86_64.tar.bz2";
    sha256 = "9de8a5e19bd42d33fc70c7d0a9a24192ff1b01b0ae14cd3628694d10fd3e73d2";
  };

  nativeBuildInputs = [
    pkgs.autoPatchelfHook
    pkgs.xorg.libXt
    pkgs.xorg.libXext
    pkgs.xorg.libXdamage
    pkgs.gtk3
    pkgs.dbus-glib
    pkgs.dbus
  ];

  buildInputs = [
    pkgs.alsaLib
    pkgs.openssl
    pkgs.zlib
    pkgs.pulseaudio
  ];

    desktopItem = pkgs.makeDesktopItem {
        name = "waterfox";
        exec = "waterfox %U";
        icon = "waterfox";
        comment = "";
        desktopName = "Waterfox";
        genericName = "Web Browser";
        categories = "Network;WebBrowser;";
        mimeType = lib.concatStringsSep ";" [
            "text/html"
            "text/xml"
            "application/xhtml+xml"
            "application/vnd.mozilla.xul+xml"
            "x-scheme-handler/http"
            "x-scheme-handler/https"
            "x-scheme-handler/ftp"
        ];
    };

  installPhase = ''
    mkdir -p $out/bin
    cp -prf . $out/bin
    install -D -t $out/share/applications $desktopItem/share/applications/*
  '';
}