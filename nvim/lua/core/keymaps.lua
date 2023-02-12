vim.g.mapleader = " "

local keymap = vim.keymap

-- Insert Mode
keymap.set("i", "jk", "<ESC>")

-- Visual Mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move to next line
keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move to previous line

-- Normal Mode
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertical
keymap.set("n", "<leader>sh", "<C-w>h") -- split window horizontal

keymap.set("n", "<leader>nh", ":nohl<CR>") -- cancal search highlight

-- Nvim Tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Buffer Line
keymap.set("n", "<C-L>", ":bnext<CR>")
keymap.set("n", "<C-H>", ":bprevious<CR>")

