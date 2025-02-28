{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "256M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0022"
                  "dmask=0022"
                ];
              };
            };
            system = {
              size = "100%";
              content = {
                type = "btrfs";
                subvolumes = {
                  root = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" ];
                  };
                  home = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" ];
                  };
                  nix = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                };
              };
            };
            swap = {
              size = "16G";
              type = "8200";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
          };
        };
      };
    };
  };
}
