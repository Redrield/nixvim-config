{ ... }:
{
  opts = {
    enable = true;
  };
  rootOpts = {
    plugins.cmp-buffer.enable = true;
    plugins.cmp-nvim-lsp.enable = true;
    plugins.cmp-path.enable = true;
    plugins.cmp-cmdline = true;
  };
}
