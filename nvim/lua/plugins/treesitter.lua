return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<c-space>", desc = "Increment selection" },
    { "<bs>", desc = "Schrink selection", mode = "x" },
  },
  ---@type TSConfig
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    context_commentstring = { enable = true, enable_autocmd = false },
    ensure_installed = {
      "bash",
      "help",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = "<nop>",
        node_decremental = "<bs>",
      },
    },
  },
  ---@param opts TSConfig
  config = function(_, opts)
    opts.rainbow = {
      enable = true,
      -- list of languages you want to disable the plugin for
      -- disable = { "jsx", "cpp" },
      -- Which query to use for finding delimiters
      query = "rainbow-parens",
      -- Highlight the entire buffer all at once
      strategy = require("ts-rainbow.strategy.global"),
      -- Do not enable for files with more than n lines
      max_file_lines = 3000,
    }
    require("nvim-treesitter.configs").setup(opts)
  end,
  dependencies = { "HiPhish/nvim-ts-rainbow2" },
}
