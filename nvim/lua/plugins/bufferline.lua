return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
  },
  opts = {
    options = {
      -- mode = "tabs",
      separator_style = "slant",
      always_show_bufferline = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      color_icons = true,
    },
  },
}
