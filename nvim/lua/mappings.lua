require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- vim-tmux-navigator
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Tmux left" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Tmux right" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Tmux down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Tmux up" })
