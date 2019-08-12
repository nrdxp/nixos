{ ... }:
{ firejail.enable = true;

  mtr.enable = true;

  adb.enable = true;

  gnupg.agent =
  { enable           = true;
    enableSSHSupport = true;
  };
}
