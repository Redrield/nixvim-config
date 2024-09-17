# homepage: https://github.com/NMAC427/guess-indent.nvim
{ pkgs, ... }:

{
  extra = {
    packages = [ pkgs.vimPlugins.guess-indent-nvim ];

    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/configs/guess-indent.lua
    config = ''
      require("guess-indent").setup({})
    '';
  };
}
