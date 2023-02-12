-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
  view = {
    side = "right",
    hide_root_folder = false,
  },
  renderer = {
    highlight_git = true,
    highlight_opened_files = "none",
    root_folder_label = function(path)
      local project = vim.fn.fnamemodify(path, ":t")
      return string.upper(project)
    end,
  },
  filters = {
    dotfiles = false,
    custom = { "^\\.git$" },
  },
})

