# homepage: https://github.com/rcarriga/nvim-notify
# nixvim doc: https://nix-community.github.io/nixvim/plugins/notify/index.html
{ icons, ... }:

{
  opts = {
    enable = true;
    settings = {
      fps = 60;

      # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/notify.lua#L27-L28
      max_height.__raw = "function() return math.floor(vim.o.lines * 0.75) end";
      max_width.__raw = "function() return math.floor(vim.o.columns * 0.75) end";

      # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/notify.lua#L20-L26
      icons = {
        debug = icons.Debugger;
        error = icons.DiagnosticError;
        info = icons.DiagnosticInfo;
        trace = icons.DiagnosticHint;
        warn = icons.DiagnosticWarn;
      };

      # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/notify.lua#L29-L42
      on_open = ''
        function(win)
          local buf = vim.api.nvim_win_get_buf(win)
          vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
          vim.api.nvim_win_set_config(win, { zindex = 175 })
          vim.wo[win].conceallevel = 3
          vim.wo[win].spell = false
        end
      '';

      stages = "fade";
    };
  };

  rootOpts.keymaps = [
    {
      mode = "n";
      key = "<leader>uD";
      action.__raw = "function() require('notify').dismiss { pending = true, silent = true } end";
      options.desc = "Dismiss notifications";
    }
    {
      mode = "n";
      key = "<leader>fn";
      action.__raw = "function() TelescopeWithTheme('notify', {}, 'notify') end";
      options.desc = "Find notifications";
    }
  ];
}
