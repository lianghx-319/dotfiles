return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
            ["rush-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
      },
    },
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    keys = {
      { "gh", "<cmd>Lspsaga lsp_finder<CR>", desc = "Lspsaga Finder" },
    },
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      --Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
}
