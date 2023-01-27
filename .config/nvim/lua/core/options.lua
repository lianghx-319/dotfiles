local opt = vim.opt

-- Line Number
opt.relativenumber = true
opt.number = true

-- Indent
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Text Style
opt.wrap = false

-- Cursor
opt.cursorline = true

-- Enable Mouse
opt.mouse:append("a")

-- System Clipboard
opt.clipboard:append("unnamedplus")

-- Windows
opt.splitright = true
opt.splitbelow = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
