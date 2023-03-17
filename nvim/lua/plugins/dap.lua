return {
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui", lazy = true, dependancies = { "mfussenegger/nvim-dap" } },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependancies = { "mfussenegger/nvim-dap" },
    opts = { automatic_setup = true },
    config = function(_, opts)
      require("mason-nvim-dap").setup(opts)
      require("mason-nvim-dap").setup_handlers({})
    end,
  },
}
