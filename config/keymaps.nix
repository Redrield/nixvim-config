let
  forceWrite = {
    action = "<cmd>silent! update! | redraw<cr>";
    options.desc = "Force write";
  };
in
{
  keymaps = [
    {
      key = "<leader>n";
      action = "<cmd>enew<cr>";
      options.desc = "New file";
    }
    {
      inherit (forceWrite) action options;
      key = "<c-s>";
    }
    {
      inherit (forceWrite) options;
      mode = [ "i" "x" ];
      key = "<c-s>";
      action = "<esc>${forceWrite.action}";
    }
    {
      key = "|";
      action = "<cmd>vsplit<cr>";
      options.desc = "Split vertically";
    }
    {
      key = "\\";
      action = "<cmd>split<cr>";
      options.desc = "Split horizontally";
    }
    {
      key = "<leader>c";
      action = "<cmd>bp<CR><cmd>bd #<CR>";
      options.desc = "Close current buffer";
    }
    {
      key = "<leader>q";
      action = "<cmd>quitall<CR>";
      options.desc = "Quits all buffers and exits";
    }
  ];
}
