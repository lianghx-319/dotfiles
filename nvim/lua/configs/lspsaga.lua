local options = {
  diagnostic = {
    keys = {
      exec_action = { "<cr>" },
      toggle_or_jump = { "o" },
    },
  },
  outline = {
    win_width = 50,
  },
}

require("lspsaga").setup(options)
