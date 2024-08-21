{ pkgs, ... }:
{
  extra = {
    packages = [ (pkgs.callPackage ./package.nix {} ) ];

    config = "";
  };
}
