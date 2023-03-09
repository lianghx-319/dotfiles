return {
  "sainnhe/everforest",
  lazy = false,
  name = "everforest",
  priority = 1000,
  config = function()
    vim.g.background = "dark"
    vim.g.everforest_background = "hard"
    vim.g.everforest_better_performance = 1
    vim.g.everforest_transparent_background = 1
    vim.g.everforest_enable_italic = 1
    vim.g.everforest_dim_inactive_windows = 1
    vim.g.everforest_ui_contrast = 1
    vim.g.everforest_diagnostic_text_highlight = 1
    vim.g.everforest_diagnostic_virtual_text = 1
  end,
}
