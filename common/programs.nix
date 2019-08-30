{ ... }:
{
  firejail.enable = true;

  mtr.enable = true;

  adb.enable = true;

  thefuck.enable = true;

  gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  less = {
    enable = true;
    envVariables = {
      LESS = "-XRi";
    };
  };
}
