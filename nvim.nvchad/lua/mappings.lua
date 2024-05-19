require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- vim-tmux-navigator
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Tmux left" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Tmux right" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Tmux down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Tmux up" })

-- lspsaga
map("n", "gh", "<cmd>Lspsaga finder<cr>", { desc = "Lspsaga finder" })
nomap({ "n", "v" }, "<leader>ca")
map({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<cr>", { desc = "Lspsaga code action" })
map("n", "gr", "<cmd>Lspsaga rename<cr>", { desc = "Lspsaga rename" })
map("n", "gp", "<cmd>Lspsaga peek_definition<cr>", { desc = "Lspsaga peek definition" })
map("n", "gd", "<cmd>Lspsaga goto_definition<cr>", { desc = "Lspsaga goto definition" })
map("n", "gt", "<cmd>Lspsaga peek_type_definition<cr>", { desc = "Lspsaga peek type definition" })
map("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<cr>", { desc = "Lspsaga show line diagnostics" })
map("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<cr>", { desc = "Lspsaga show workspace diagnostics" })
map("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<cr>", { desc = "Lspsaga show cursor diagnostics" })
map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Lspsaga goto prev diagnostic" })
map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Lspsaga goto next diagnostics" })
map("n", "K", "<cmd>Lspsaga hover_doc<cr>", { desc = "Lspsaga hover doc" })
map("n", "<leader>o", "<cmd>Lspsaga outline<cr>", { desc = "Lspsaga outline" })
map("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<cr>", { desc = "Lspsaga incoming calls" })
map("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<cr>", { desc = "Lspsaga outgoing calls" })
