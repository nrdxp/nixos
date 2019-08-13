NixOS configuration
-------------------

Herein lies my configuration files for NixOS. You can easily pick and choose 
optional components from the `extra` and `abstract` folders by including them in
`configuration.nix`. I also have device specific configurations under the devices
folder. You must pick one device configuration or generate your own.

I wrote a simple recursive import function so that I could simply map my file
heirarchy to match the NixOS' expected attribute set. For example I can plop a
file under `common/services/foo.nix` and everything contained within that record
will automatically be compiled as `services.foo` in the final configuration.
You can also have a `common/services.nix` for simple service declarations and it
will merge with the declarations in the `services` subfolder.  In addition, 
you can also pass around attributes like `pkgs` or `config` in the
same way as traditional imports. e.g. `{ pkgs, ... }:` at the top of the file.
This function lives at `fn/recImport.nix`.

Other then that, please excuse my mess and feel free to look around.

Disclaimer:
May not work without my fork of nixpkgs
