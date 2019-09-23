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

In terms of choosing configuration "components", the idea is that the user
should only have to modify `imports` in `configuration.nix` to pick and choose
what they currently want setup out of the available choices in the `xtra` or
`abstract` directories.

Disclaimer:
I merge my changes into [nixpkgs master](https://github.com/NixOS/nixpkgs),
but depending on the timing, this configuration may not work without my
[nixpkgs fork](https://github.com/nrdxp/nixpkgs/tree/fork).

