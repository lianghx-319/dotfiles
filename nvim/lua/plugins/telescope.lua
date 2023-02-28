return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      -- {
      --   "nvim-telescope/telescope-file-browser.nvim",
      --   config = function()
      --     require("telescope").load_extension("file_browser")
      --   end,
      -- },
    },
  },
}
