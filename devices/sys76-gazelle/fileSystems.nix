{ ... }:
{
  "/" =
    { device = "/dev/disk/by-uuid/880d08c9-f653-4be0-b4c1-662877d77a9e";
      fsType = "xfs";
    };

  "/boot/efi" =
    { device = "/dev/disk/by-uuid/FAC0-3221";
      fsType = "vfat";
    };
}
