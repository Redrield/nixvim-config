# homepage: https://github.com/folke/which-key.nvim
# nixvim doc: https://nix-community.github.io/nixvim/plugins/which-key/index.html
{ icons, ... }:

{
  opts = {
    enable = true;
    settings.icons.group = "";
    settings.win.border = "single";

    # Disable which-key when in neo-tree or telescope
    settings.disable.ft = [
      "TelescopePrompt"
      "neo-tree"
      "neo-tree-popup"
    ];

    # Customize section names (prefixed mappings)
    settings.spec = [
      {
        __unkeyed-1 = "<leader>b";
        icon = icons.Tab;
        group = "Buffers";
      }
      {
        __unkeyed-1 = "<leader>bs";
        icon = icons.Sort;
        group = "Sort Buffers";
      }
      {
        __unkeyed-1 = "<leader>d";
        icon = icons.Debugger;
        group = "Debugger";
      }
      {
        __unkeyed-1 = "<leader>f";
        icon = icons.Search;
        group = "Find";
      }
      {
        __unkeyed-1 = "<leader>g";
        icon = icons.Git;
        group = "Git";
      }
      {
        __unkeyed-1 = "<leader>l";
        icon = icons.ActiveLSP;
        group = "Language Tools";
      }
      {
        __unkeyed-1 = "<leader>m";
        icon = "";
        group = "Markdown";
      }
      {
        __unkeyed-1 = "<leader>s";
        icon = icons.Session;
        group = "Session";
      }
      {
        __unkeyed-1 = "<leader>t";
        icon = icons.Terminal;
        group = "Terminal";
      }
      {
        __unkeyed-1 = "<leader>u";
        icon = icons.Window;
        group = "UI/UX";
      }
    ];
  };

  # Enable catppuccin colors
  # https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/which_key.lua
  rootOpts.colorschemes.catppuccin.settings.integrations.which_key = true;
}
