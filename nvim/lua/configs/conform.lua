local formatter = "prettier"

local map = vim.keymap.set

local toggle = function()
  if formatter == "prettier" then
    formatter = "eslint_d"
  elseif formatter == "eslint_d" then
    formatter = "prettier"
  end
end

map("n", "<leader>fx", toggle, { desc = "Toggle Formatter for JS" })

local format = function()
  return { formatter }
end

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    typescript = format,
    typescriptreact = format,
    javascript = format,
    javascriptreact = format,
    sh = { "beautysh" },
    rust = { "rustfmt" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 5000,
    lsp_format = "never",
    stop_after_first = true,
  },
}

require("conform").setup(options)
