return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".DS_Store",
          },
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(_file_path)
            --auto close
            require("neo-tree").close_all()
          end,
        },
      },
    },
  },
}