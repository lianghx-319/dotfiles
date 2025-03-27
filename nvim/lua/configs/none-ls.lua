local none_ls = require "null-ls"

local options = {
  diagnostics_format = "[#{c}] #{m} (#{s})",
  sources = {
    require "none-ls.code_actions.eslint_d",
    require "none-ls.diagnostics.eslint_d",
    -- require "none-ls.formatting.eslint_d",
  },
}

none_ls.setup(options)
