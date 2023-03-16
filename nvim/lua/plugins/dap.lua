return {
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui", lazy = true, dependancies = { "mfussenegger/nvim-dap" } },
  {
    "jay-babu/mason-nvim-dap.nvim",
    lazy = true,
    dependancies = { "mfussenegger/nvim-dap" },
    opts = { automatic_setup = true },
  },
}
