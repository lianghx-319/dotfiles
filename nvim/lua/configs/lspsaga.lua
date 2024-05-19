local options = {
  diagnostic = {
    keys = {
      exec_action = { "<cr>" },
      toggle_or_jump = { "o" },
    },
  },
}

require("lspsaga").setup(options)
