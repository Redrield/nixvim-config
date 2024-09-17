{ pkgs, ... }:
{
  extra = {
    packages = [ (pkgs.callPackage ./package.nix {} ) ];
  };

  rootOpts = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>gL";
        action = ":Flog";
      }
    ];
  };
}
