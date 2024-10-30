return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        fish = { "fish" },
        -- typescript = { "eslint_d" },
        -- typescriptreact = { "eslint_d" },
        -- javascript = { "eslint_d" },
        -- javascriptreact = { "eslint_d" },
        -- Use the "*" filetype to run linters on all filetypes.
        -- ['*'] = { 'global linter' },
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
        -- ['_'] = { 'fallback linter' },
        -- ["*"] = { "typos" },
      },
    },
    config = function(_, opts)
      local M = {}

      local lint = require "lint"
      lint.linters_by_ft = opts.linters_by_ft

      function M.debounce(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = M.debounce(100, function()
          lint.try_lint()
        end),
      })
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    event = "LspAttach",
    config = function()
      require "configs.none-ls"
    end,
  },
}
