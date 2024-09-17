{ pkgs, ... }:
{
  extra = {
    packages = [ ( pkgs.callPackage ./package.nix {} ) ];
    config = ''
    vim.cmd('let g:flog_enable_extended_chars = v:true')
    '';
  };

  rootOpts = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>gL";
        action = ":Flog<cr>";
      }
    ];
  };
}
