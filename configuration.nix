{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];
  nixpkgs.config.allowUnfree = true;
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";
  nix.settings = {
    max-jobs = "auto";
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
    ];
  };
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    priority = 5;
    memoryPercent = 50;
  };
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.libinput.enable = true;
  users.users.tritium = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };
  environment.variables.EDITOR = "nvim";
  # environment.sessionVariables = {
  #   GDK_SPI_SCALE = "1.5";
  #   GDK_SCALE = "1.5";
  #   QT_SCALE_FACTOR = "1.5";
  #   #QT_FONT_DPI = "192";
  #   XCURSOR_SZIE = "48";
  #   PLASMA_USE_QT_SCALING = "1";
  # };
  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    git
  ];
  system.stateVersion = "24.11";
}
