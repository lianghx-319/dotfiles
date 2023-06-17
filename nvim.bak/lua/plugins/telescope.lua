return {
  {
    "nvim-telescope/telescope.nvim",
    commit = "057ee0f8783872635bc9bc9249a4448da9f99123",
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
