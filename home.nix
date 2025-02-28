{ config, pkgs, ... }:

{

  programs = {
    git = {
      enable = true;
      userName = "OpenTritium";
      userEmail = "tritium404@hotmail.com";
    };
    gh.enable = true;
    plasma.enable = true;
    vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        ms-python.python
      ];
    };
    firefox.enable = true;
    home-manager.enable = true;
  };
  home = {
    #backupFileExtension = "backup";
    username = "tritium";
    homeDirectory = "/home/tritium";
    packages = with pkgs; [
      android-studio
      btop
      nixfmt-rfc-style
      jetbrains.idea-ultimate
      wpsoffice-cn
      clash-nyanpasu
      jdk
      qq
      source-han-sans
    ];
    stateVersion = "24.11";
  };

}
