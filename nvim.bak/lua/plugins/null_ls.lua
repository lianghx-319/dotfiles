return {
  "jose-elias-alvarez/null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "mason.nvim" },
  opts = function()
    local nls = require("null-ls")
    return {
      sources = {
        -- nls.builtins.formatting.prettierd,
        nls.builtins.formatting.stylua,
        nls.builtins.diagnostics.flake8,
        nls.builtins.diagnostics.cspell.with({
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
          end,
        }),
        nls.builtins.code_actions.cspell,
        nls.builtins.formatting.eslint_d,
        nls.builtins.diagnostics.eslint_d,
        nls.builtins.code_actions.eslint_d,
        nls.builtins.diagnostics.fish,
      },
    }
  end,
}
