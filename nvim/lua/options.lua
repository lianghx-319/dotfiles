require "nvchad.options"

vim.opt.relativenumber = true
vim.opt.textwidth = 120
vim.opt.colorcolumn = "+1"
vim.opt.spell = false
vim.opt.spelllang = "en_us"
vim.lsp.enable "cspell_ls"
-- views can only be fully collapsed with the global statusline for avante
vim.opt.laststatus = 3

vim.lsp.buf.format { timeout_ms = 5000 }
